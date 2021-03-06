(* 

	Open New Blank SVG Document

[description]
	open new SVG document with templates on CotEditor

[version]	0.5α
[lastmod]	2012-02-29
[author]	1024jp <http://wolfrosch.com/>
[licence]	Creative Commons Attribution-NonCommercial 3.0 Unported License
*)

-- __settings_______________________________________________________________

-- whether insert <title> tag
property insertTitleTag : true

-- whether insert <style> tag
property insertStyleTag : true

-- whether insert <defs> tag
property insertDefsTag : false

-- coloring mode name for new document
property syntaxName : "SVG"

-- default document size
property width : 400 --px
property height : 400 --px


-- __main_______________________________________________________________

-- open new document on CotEditor
tell application "CotEditor"
	make new document
	set coloring style of front document to syntaxName
	set theEncoding to IANA charset of front document of application "CotEditor"
end tell


-- build content
set theSource to "" -- initialize

set theSource to theSource & xmlD(theEncoding) of Templates -- <?xml?>
set theSource to theSource & DTD() of Templates & return -- <!DOCTYPE>

set theSource to theSource & svgStartTag() of Templates & return -- <svg>

if insertTitleTag then set theSource to theSource & titleTags() of Templates & return -- <title></title>

if insertStyleTag then set theSource to theSource & styleTags() of Templates & return -- <style></style>

if insertDefsTag then set theSource to theSource & defsTags() of Templates & return -- <defs></defs>

-- caret position
set caretPosition to count of character of theSource


set theSource to theSource & return ¬
	& return ¬
	& svgEndTag() of Templates -- </svg>


-- insert content into document
tell application "CotEditor"
	set contents of front document to theSource
	set range of selection of front document to {caretPosition, 0}
end tell


-- __Templates_______________________________________________________________

script Templates
	on xmlD(encoding)
		"<?xml version=\"1.0\" encoding=\"" & encoding & "\"?>" & return
	end xmlD
	
	on DTD()
		"<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">" & return
	end DTD
	
	on svgStartTag()
		"<svg version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\"" & return ¬
			& "             xmlns:xlink=\"http://www.w3.org/1999/xlink\"" & return ¬
			& "     width=\"" & width & "px\" height=\"" & height & "px\" viewBox=\"0 0 " & width & " " & height & "\">" & return
	end svgStartTag
	
	
	on svgEndTag()
		"</svg>"
	end svgEndTag
	
	on titleTags()
		"<title></title>" & return
	end titleTags
	
	on defsTags()
		"<defs>" & return ¬
			& tab & return ¬
			& "</defs>" & return
	end defsTags
	
	on styleTags()
		"<style type=\"text/css\"><![CDATA[" & return ¬
			& tab & return ¬
			& "]]></style>" & return
	end styleTags
end script