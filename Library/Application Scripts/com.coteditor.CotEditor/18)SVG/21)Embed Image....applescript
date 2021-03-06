(*

	insert image tag with base64 encoded image


[description]	
	encode selected image to base64 and insert it with SVG <image> tag
	at caret position in current document on CotEditor
		
[version]	0.5α
[lastmod]	2012-03-03
[author]	1024jp <http://wolfrosch.com/>
[licence]	Creative Commons Attribution-NonCommercial 3.0 Unported License
*)

-- __settings_______________________________________________________________

-- limit file size to execute wishout alert  (KB)
property maxFileSize : 250


-- __main_______________________________________________________________

-- let user to select an image
tell application "CotEditor"
	if exists front document then
		-- file selection dialog
		try
			set imagePath to choose file of type {"png", "jpg", "gif", "tiff"} with prompt "select a iamge file to embed"
		on error
			return
		end try
	else
		return
	end if
end tell


-- get file size of the image
tell application "Finder" to set imageSize to size of file imagePath
set imageSize to imageSize / (1000) --KB

-- check image file size
if imageSize > maxFileSize then
	
	-- convert file size to human-readable
	if imageSize > 1000 then
		set HumanImageSize to imageSize / 1000 -- convert to MB
		if HumanImageSize > 10 then
			set HumanImageSize to (round HumanImageSize) & "MB"
		else
			set HumanImageSize to ((round (HumanImageSize * 10)) / 10) & "MB"
		end if
	else
		if imageSize > 10 then
			set HumanImageSize to (round imageSize) & "KB"
		else
			set HumanImageSize to ((round (imageSize * 10)) / 10) & "KB"
		end if
	end if
	
	-- alert
	try
		display alert "The image file you chose is quite large.\n(size: " & HumanImageSize & ")" message "Embedding this as base64 can cause CotEditor to slow down or at worst freeze." & return & return & "Do you really want to continue?" as warning buttons {"Cancel", "Continue"} cancel button "Cancel"
	on error
		return
	end try
end if


-- get image properties
tell application "Image Events"
	activate
	set theImage to open imagePath
	set {width, height} to dimensions of theImage
	set imageType to file type of theImage
	
	
	-- transform imageType to lowercase
	set imageType to do shell script "echo '" & imageType & "' | tr '[A-Z]' '[a-z]'"
end tell


-- base64 encode
set base64 to do shell script "openssl base64 -in " & quoted form of POSIX path of imagePath

-- make <image> tag
set imageTag to "<image width=\"" & width & "\" height=\"" & height & "\" xlink:href=\"data:image/" & imageType & ";base64," & base64 & "\"></image>"


-- insert <image> tag into CotEditor document
tell application "CotEditor"
	set {loc, len} to range of selection of front document
	set contents of selection of front document to imageTag
	set range of selection of front document to {loc + (count of imageTag), 0}
end tell