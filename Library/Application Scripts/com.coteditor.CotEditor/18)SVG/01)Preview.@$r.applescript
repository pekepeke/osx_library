(*

	Preview SVG


[description]
	preview current SVG document on CotEditor in Safari

[version]	0.5α
[lastmod]	2012-03-02
[author]	1024jp <http://wolfrosch.com/>
[licence]	Creative Commons Attribution-NonCommercial 3.0 Unported License

[default key assign] 	Command + Shift + R
*)

-- __settings_______________________________________________________________

-- show dialog when script couldn't run
property showAlertDialog : true

-- name of syntax mode
property syntaxName : "SVG"

-- resize window by reload
property resizeWindow : false

-- show toolbar of preview window
property showToolbar : false

-- localize
property lang : "ja"

-- __advanced settings________________________________________________________

-- extension of svg file
property svgExtension : ".svg"

-- delay time to resize by loading image
property loadDelay : 0.2 -- second

-- default preview window size (These values are used only when svg size couldn't get)
property width : 200 -- px
property height : 200 -- px

-- height of titlebar of preview window
property titleberHeight : 24 -- px

-- margin between CotEditor document and preview window
property xPositionMargin : 15 -- px
property yPositionMargin : 80 -- px


-- __main_______________________________________________________________

-- get file path from CotEditor
tell application "CotEditor"
	set thePath to ""
	if exists front document then
		set thePath to path of front document as Unicode text
	else
		return
	end if
end tell

-- end script if coloring mode is not in SVG
tell application "CotEditor"
	if coloring style of front document is not syntaxName then return
end tell

-- end script if no file path is specified
if thePath is "" then
	if showAlertDialog then
		beep
		display alert "No file path is specified." message "Please save the document first." & return & return & "script failed" as warning
	end if
	
	return
end if

-- end script if file doesn't have.svg extension
if thePath does not end with svgExtension then
	if showAlertDialog then
		beep
		display alert localizedStrings("The document would not be a SVG file.") message "SVG file names should end in the extension \"" & svgExtension & "\"." & return & return & "script failed" as warning
	end if
	
	return
end if


-- URI encode
set theURL to "file://" & my encodeURI(thePath)

-- open preview window on Safari
tell application "Safari"
	set isFirstTime to true
	set preloadWindowId to 0
	
	-- open pre window to execute JavaScript when no any window exists
	if not (exists front document) then
		make new document
		set preloadWindowId to id of window 1
	end if
	
	-- check exstance of the preview window
	repeat with aWindow in windows
		try
			if URL of current tab of aWindow is theURL then
				set isFirstTime to false
				set index of aWindow to 1 -- bring the window to front
			end if
		end try
	end repeat
	
	
	-- create preview window
	if isFirstTime then
		-- check whether JavaScript is enabled
		set isJSEnabled to (do JavaScript "navigator.javaEnabled()" in document 1) is true
		
		-- open preview window
		if isJSEnabled then
			-- set preview window position
			tell application "CotEditor" to set cotPos to bounds of window 1
			set xPos to (item 3 of cotPos) + xPositionMargin
			set yPos to (item 2 of cotPos) + yPositionMargin
			
			-- boolean to 1/0 for window.open
			if showToolbar then
				set showToolbar to 1
			else
				set showToolbar to 0
			end if
			
			-- make popup window
			do JavaScript "window.open('' ," & quoted form of thePath & ",'width=" & width & ", height=" & height & ", left=" & xPos & ", top=" & yPos & ", toolbar=" & showToolbar & "');" in document 1
		else
			make new document
		end if
		
		-- close pre window
		if preloadWindowId > 0 then
			close window id preloadWindowId
		end if
	end if
	
	-- refresh
	set URL of document 1 to theURL
	
	-- resize window
	if (resizeWindow or isFirstTime) and isJSEnabled then
		delay loadDelay
		
		tell document 1
			-- get image size
			set width to do JavaScript "document.documentElement.scrollWidth"
			set height to do JavaScript "document.documentElement.scrollHeight"
			
			-- resize
			do JavaScript "self.resizeTo(" & width & "," & height + titleberHeight & ");"
		end tell
	end if
	
	
	-- bring preview window to just behind of the current CotEditor document
	tell application "System Events"
		tell process "Safari" to perform action "AXRaise" of window 1
	end tell
end tell



-- __subroutines____________________________________________________________

-- URI encoder
on encodeURI(theURI)
	return do shell script "ruby -e \"require 'uri'; print URI.encode(" & quoted form of theURI & ")\""
end encodeURI


-- __localize____________________________________________________________

-- simple localizer by 1024jp
on localizedStrings(str)
	-- set japanese
	if lang is "ja" then
		if str is "No file path is specified." then
			set str to "ファイルパスが見つかりませんでした。"
			
		else if str is "Please save the document before preview." then
			set str to "書類を保存してください。"
			
		else if str is "The document would not be a SVG file." then
			set str to "この書類はおそらくSVG形式ではありません。"
			
		end if
	end if
	
	return str
end localizedStrings