'''
Text Editor Actions for Coda

A collection of Python scripts that enable useful actions
from Textmate into Coda

Copyright (c) 2009 Ian Beck

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
'''

import sys
import os.path

from Foundation import *
import objc

NSObject = objc.lookUpClass('NSObject')
CodaPlugIn = objc.protocolNamed('CodaPlugIn')

class TEAforCoda(NSObject, CodaPlugIn):
    '''
    Initializes the menu items and is responsible for directing
    actions to the appropriate class
    '''
    
    def initWithPlugInController_bundle_(self, controller, bundle):
        '''Required method; run when the plugin is loaded'''
        self = super(TEAforCoda, self).init()
        if self is None: return None
        
        defaults = NSUserDefaults.standardUserDefaults()
        # Set up default action set
        defaults.registerDefaults_(NSDictionary.dictionaryWithContentsOfFile_(
            bundle.pathForResource_ofType_('TextActions', 'plist')
        ))
        ns_actions = defaults.dictionaryForKey_('TEATextActions')
        actions = dict(
            [str(arg), value] \
            for arg, value in ns_actions.iteritems()
        )
        
        self.controller = controller
        self.bundle = bundle
        
        # Loop over the actions and add them to the menus
        rootlevel = {}
        submenus = {}
        # Extract out our submenus and root items
        for key, value in actions.iteritems():
            if 'submenu' in value:
                if not str(value['submenu']) in submenus:
                    submenus[str(value['submenu'])] = {}
                submenus[str(value['submenu'])][key] = value
            else:
                rootlevel[key] = value
        # Process the submenus
        submenu_keys = submenus.keys()
        submenu_keys.sort()
        for menu in submenu_keys:
            menu_actions = submenus[menu]
            temp_keys = menu_actions.keys()
            temp_keys.sort()
            for title in temp_keys:
                action = menu_actions[title]
                self.register_action(controller, action, title)
        # Process the root level items
        keys = rootlevel.keys()
        keys.sort()
        for title in keys:
            action = rootlevel[title]
            self.register_action(controller, action, title)
        
        # Add the Support/Scripts folder to the Python import path
        sys.path.append(os.path.join(bundle.bundlePath(), "Support/Scripts"))
        sys.path.append(os.path.join(bundle.bundlePath(), "Support/Library"))
        
        return self
    
    def name(self):
        '''Required method; returns the name of the plugin'''
        return 'TEA for Coda'
    
    def act_(self, sender):
        '''
        Imports the module, initializes the class, and runs its act() method
        '''
        actionname = sender.representedObject().objectForKey_('actionname')
        mod = __import__(actionname)
        if actionname in mod.__dict__:
            target = mod.__dict__[actionname].alloc().init()
        else:
            target = mod
        target.act(self.controller, self.bundle, sender.representedObject().objectForKey_('options'))
    
    def register_action(self, controller, action, title):
    	action = dict(action)
        if 'action' not in action:
            NSLog('TEA: module missing `action` entry')
            return False
        # Required items
        actionname = action['action']
        # Set up defaults
        submenu = action['submenu'] if 'submenu' in action else None
        shortcut = action['shortcut'] if 'shortcut' in action else ''
        options = action['options'] if 'options' in action else NSDictionary.dictionary()
        
        rep = NSDictionary.dictionaryWithObjectsAndKeys_(
            actionname,
            'actionname',
            options,
            'options'
        )
        controller.registerActionWithTitle_underSubmenuWithTitle_target_selector_representedObject_keyEquivalent_pluginName_(
            title,
            submenu,
            self,
            'act:',
            rep,
            shortcut,
            'TEA for Coda'
        )
