# -*- coding: utf-8 -*-

# Copyright (c) 2010, Webreactor - Marcin Lulek <info@webreactor.eu>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#    * Redistributions of source code must retain the above copyright
#      notice, this list of conditions and the following disclaimer.
#    * Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
#    * Neither the name of the <organization> nor the
#      names of its contributors may be used to endorse or promote products
#      derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# Additional contributions (licensed as above):
# Copyright (c) 2011, The Interaction Consortium
#                     Aram Dulyan <aram@interaction.net.au>

import re
from string import whitespace

try:
  from lxml import etree
except ImportError:
  try:
    # Python 2.5
    import xml.etree.cElementTree as etree
  except ImportError:
    try:
      # Python 2.5
      import xml.etree.ElementTree as etree
    except ImportError:
      try:
        # normal cElementTree install
        import cElementTree as etree
      except ImportError:
        try:
          # normal ElementTree install
          import elementtree.ElementTree as etree
        except ImportError:
          print("Failed to import ElementTree from any known place")

# A mapping of simple inline HTML tags to their Textile representations
SIMPLE_TAGS = {
    'b': '*', # Official spec says **, but we're forcing good HTML practices
    'strong': '*',
    'i': '_', # Official spec says __, but we're forcing good HTML practices
    'em': '_',
    'cite': '??',
    'del': '-',
    's': '-', # No Textile equivalent, but <del> is rendered as strikethrough
    'strike': '-', # As above
    'ins': '+', 
    'u': '+', # No Textile equiv, but most browsers render <ins> as underlined
    'big': '++',
    'small': '--',
    'span': '%',
    'code': '@',
    'sub': '~',
    'sup': '^',
}

# Tags that cannot be rendered in certain contexts like list items
LIMITED_TAGS = (
    'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', 'div', 'br', 'blockquote',
)

# A regular expression to match additional attributes that can be passed to
# textile tags
TAG_SUFFIX = r'(\([^\)]+\)){0,2}(\{[^\}]+\})?(\[[^\]]+\])?'

# A regular expression to to match any whitespace or lone paragraph/heading
# declarations at the end of a string
WHITESPACE_SUFFIX = re.compile(
    r'((p|bq|h[1-6])%s\.)?\s*$' % TAG_SUFFIX)

def safe_url(text, characters):
    """
    URL-escape the specified characters in the text (using %## equivalents).
    """
    for char in characters:
        text = text.replace(char, '%%%x' % ord(char))
    return text

class EchoTarget(object):
    """
    The target object for the XMLParser.
    """
    
    def __init__(self):
        # A stack of strings that will be joined together to form the final
        # Textile output
        self.final_output = []
        # Indicates whether we're in the middle of parsing a link
        self.block = False
        # A stack that's used instead of `final_output` while parsing a link
        self.haystack = []
        self.ol_ident = 0
        self.ul_ident = 0
        self.list_types = []
        # Indicates whether a simple inline tag was just opened. Used to
        # determine if spaces need to be added or removed to maintain valid
        # Textile syntax.
        self.just_opened = False
        # Indicates whether a simple inline tag was just closed, used as above.
        self.just_closed = False
        # A stack of the simple tags that are currently open (in their Textile
        # representations). Used to maintain continuity across <br/> tags.
        self.open_simple_tags = []
        self.tags_inside_links = []
        self.nested_tags = []
    
    def _stack(self, override=False):
        """
        Returns the output stack that is currently active. Returning
        `final_output` can be forced by setting the "override" argument.
        """
        return self.haystack if self.block and not override else self.final_output
    
    def _reverse_stack_iter(self):
        """
        An iterator over non-empty strings in the current stack in reverse 
        order. Rather than returning the string itself, returns a tuple of the
        reference to the stack and the index of the current item. This is done
        to allow the item to be modified in place.
        """
        stack = self._stack()
        for idx in xrange(-1, -1-len(stack), -1):
            if stack[idx]:
                yield stack, idx
    
    def _rstrip(self):
        """
        Strips any trailing whitespace or lone paragraph/heading declarations
        from the stack.
        """
        for stack, idx in self._reverse_stack_iter():
            stack[idx] = WHITESPACE_SUFFIX.sub('', stack[idx])
            if stack[idx]:
                break
    
    def _rstrip_open_tag(self, tag):
        """
        Strip the given tag from the end of the stack if it was just opened.        
        Returns True if the strip was successful.
        """
        if not (self.open_simple_tags \
                and self.open_simple_tags[0] == tag):
            return False
        for stack, idx in self._reverse_stack_iter():
            match = re.search(
                r'%s%s$' % (re.escape(tag), TAG_SUFFIX),
                stack[idx])
            if match:
                stack[idx] = stack[idx][:-len(match.group(0))]
                return True
            break
        return False
    
    def _rstrip_open_simple_tags(self):
        """
        Strips any simple tags in just opened state from the end of the stack.
        Returns an empty string if the strip was productive, otherwise returns
        the string tag sequence to close all open simple tags.
        
        This unorthodox return value is because this functionality 
        is invariably used to determine whether the stack ends with the simple
        tags opened on a blank line, in which case the strip would be
        successful and the tags wouldn't need to be closed.
        """
        stripped = False
        for open_tag in self.open_simple_tags:
            stripped = stripped or self._rstrip_open_tag(open_tag)
        return '' if stripped else ''.join(self.open_simple_tags)
    
    def _ends_with_newline(self):
        """
        Returns True if the current stack ends with a newline, allowing for
        any simple inline tags that may have been reopened due to the line
        break.
        """
        for stack, idx in self._reverse_stack_iter():
            if stack[idx].endswith(
                    '\n%s' % ''.join(reversed(self.open_simple_tags))):
                return True
            break
        return False
    
    def start(self, tag, attrib):
        # For tags that cannot appear inside links (according to the Textile
        # parsing rules), always use the `final_output` stack by setting
        # `override_block` to True.
        override_block = False
        textile = None
        new_tag = None
        newline = '\n'
        dot = ''
        if 'style' in attrib and attrib['style']:
            style_value = '{%s}' % attrib['style']
        else:
            style_value = ''
        
        class_value = ''
        class_values = []
        if 'class' in attrib and attrib['class']:
            class_values += [attrib['class']]

        if 'id' in attrib and attrib['id']:
            class_values += ['#%s' % attrib['id']]
        
        if class_values:
            class_value = '(%s)' % ' '.join(class_values)
            
        if 'lang' in attrib and attrib['lang']:
            lang_value = '[%s]' % attrib['lang']
        else:
            lang_value = ''
        
        if self.list_types and tag in LIMITED_TAGS:
            # Ignore limited tags if inside a list
            pass
        elif tag in SIMPLE_TAGS:
            if SIMPLE_TAGS[tag] in \
                    (self.open_simple_tags + self.tags_inside_links):
                self.nested_tags.insert(0, tag)
            else:
                if not self.just_opened:
                    # Simple tags generally need to be preceded by whitespace to be
                    # recognised as Textile mark-up
                    for stack, idx in self._reverse_stack_iter():
                        if not stack[idx].endswith(tuple(whitespace)):
                            stack[idx] = '%s ' % stack[idx]
                        break
                new_tag = SIMPLE_TAGS[tag]
                newline = ''
                self.open_simple_tags.insert(0, SIMPLE_TAGS[tag])
        elif tag in ('h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', 'div'):
            override_block = True
            self._rstrip()
            # Simple tags should not span across blocks
            newline = '%s\n\n' % self._rstrip_open_simple_tags()
            self.open_simple_tags = []
            if tag in ['p', 'div']:
                if any((style_value, lang_value, class_value)):
                    new_tag = 'p'
                    dot = '. '
                else: 
                    new_tag = ''
                    dot = ''
            else:
                new_tag = tag
                dot = '. '
        elif tag == 'br':
            if self.just_opened:
                textile = ''
            else:
                # Since Textile doesn't allow simple tags to span across
                # line breaks, close them and reopen them after the break
                textile = '%s\n%s' % (
                    self._rstrip_open_simple_tags(),
                    ''.join(reversed(self.open_simple_tags)),
                )
        elif tag == 'blockquote':
            override_block = True
            self._rstrip()
            newline = '\n\n'
            new_tag = 'bq'
            dot = '. '
        elif tag == 'a':
            # We do not support links inside links
            if not self.tags_inside_links:      
                for open_tag in self.open_simple_tags[:]:
                    if self._rstrip_open_tag(open_tag):
                        self.tags_inside_links += [open_tag]
                        self.open_simple_tags.pop(0)
            else:
                self.tags_inside_links = []
                    
            self.block = True
            if 'title' in attrib:
                self.a_part = {'title':attrib.get('title'),
                               'href':attrib.get('href', '')}
            else:
                self.a_part = {'title':None, 'href':attrib.get('href', '')}
            new_tag = ''
            newline = ''
        elif tag == 'img':
            # Grab the alternative text from either the "alt" or "title"
            # property, preferring the former
            alt = ''
            if 'alt' in attrib and attrib['alt']:
                alt = attrib['alt']
            elif 'title' in attrib and attrib['title']:
                alt = attrib['title']
            if alt:
                alt = '(%s)' % alt.replace(')', '&#41;')
            # Since the image syntax has a different structure, we define
            # the `textile` variable here. Note that `new_tag` must remain 
            # empty for this `textile` variant to be used.
            textile = '%(space)s!%(class)s%(style)s%(lang)s%(src)s%(alt)s! ' % {
                'space': '' if self._ends_with_newline() else ' ',
                'src': safe_url(attrib.get('src', ''), ' !('),
                'alt': alt,
                'class': class_value,
                'style': style_value,
                'lang': lang_value,
            }
        elif tag in ('ul', 'ol'):
            new_tag = ''    
            newline = ''
            self.list_types.append(tag)
            if tag == 'ul':
                self.ul_ident += 1
            else:
                self.ol_ident += 1
            return
        elif tag == 'li':
            indent = self.ul_ident + self.ol_ident
            if self.list_types[-1] == 'ul':
                new_tag = '*' * indent + ' '
                newline = '\n'
            else:
                new_tag = '#' * indent + ' '    
                newline = '\n'
        
        if new_tag is not None:
            textile = '%(newline)s%(tag)s%(class)s%(style)s%(lang)s%(dot)s' % \
                                 {
                                  'newline':newline,
                                  'tag':new_tag,
                                  'class':class_value,
                                  'style':style_value,
                                  'lang':lang_value,
                                  'dot':dot
                                  }
        
        if textile is not None:
            self.just_closed = False 
            self.just_opened = tag in SIMPLE_TAGS.keys() + ['br']
            self._stack(override_block).append(textile)
        
    def end(self, tag):
        textile = None
        change_tag_status = True
        override_block = False
        
        if self.list_types and tag in LIMITED_TAGS:
            # Ignore limited tags if inside a list
            pass
        elif tag in SIMPLE_TAGS:
            if tag in self.nested_tags:
                self.nested_tags.remove(tag)
            else:
                self._rstrip()
                # Prevent empty simple tags, since Textile won't recognise them
                if not self._rstrip_open_tag(SIMPLE_TAGS[tag]):
                    textile = SIMPLE_TAGS[tag]
                try:
                    self.open_simple_tags.remove(SIMPLE_TAGS[tag])
                except ValueError:
                    textile = None
                self.just_opened = False
                self.just_closed = textile is not None
                change_tag_status = False
        elif tag in ('h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', 'div'):
            override_block = True
            self._rstrip()
            textile = '\n\n'
        elif tag == 'a':
            self.block = False
            if ''.join(self.haystack).strip():
                title = self.a_part.get('title', None)
                textilized = '%(space)s"%(tag_open)s%(haystack)s%(tag_close)s%(title)s":%(href)s ' % {
                    'space': '' if self._ends_with_newline() else ' ',
                    'tag_open': ''.join(reversed(self.tags_inside_links)),
                    'haystack': ''.join(self.haystack).strip(),
                    'tag_close': ''.join(self.tags_inside_links),
                    'title': ' (%s)' % title if title else '',
                    'href': safe_url(self.a_part.get('href', ''), ' '),
                }
                self.final_output.append(textilized)
            self.haystack = []
            self.tags_inside_links = []
        elif tag == 'ul':
            self.ul_ident -= 1
            self.list_types.pop()
            if len(self.list_types) == 0:
                textile = '\n'
        elif tag == 'ol':
            self.ol_ident -= 1
            self.list_types.pop()
            if len(self.list_types) == 0:
                textile = '\n'
        else:
            change_tag_status = False
        
        if change_tag_status:
            self.just_opened = False
            self.just_closed = False
        
        if textile is not None:
            self._stack(override_block).append(textile)
        
    def data(self, data):
        # We don't want any linebreaks inside our tags
        node_data = data.replace('\n','')
        # Simple tags generally need to be followed by whitespace to be
        # recognised as Textile mark-up
        if self.just_closed and node_data and node_data[0] != ' ':
            node_data = ' %s' % node_data
        # There can be no spaces between the opening of a simple tag and the
        # text it contains
        elif self.just_opened:
            node_data = node_data.lstrip()
        if node_data:
            self.just_opened = False
            self.just_closed = False
        # Ensure that
        if self._ends_with_newline():
            node_data = node_data.lstrip()
        self._stack().append(node_data)
        
    def comment(self, text):
        pass

    def close(self):
        pass

 
def html2textile(html):
    # 1st passs to clean the whitespace and convert HTML to XHTML
    parser = etree.HTMLParser()
    tree = etree.fromstring(html, parser)
    xhtml = etree.tostring(tree, method="xml")
    parser = etree.XMLParser(remove_blank_text=True)
    root = etree.XML(xhtml, parser)
    cleaned_html = etree.tostring(root)
    # 2nd pass to build the Textile output
    target = EchoTarget()
    parser = etree.XMLParser(target=target)
    root = etree.fromstring(cleaned_html, parser)
    textilized_text = ''.join(target.final_output).strip()
    return textilized_text
