(* 

	insert XML declaration
	

[version]	0.5α
[lastmod]	2012-02-25
[author]	1024jp <http://wolfrosch.com/>
[licence]	Creative Commons Attribution-NonCommercial 3.0 Unported License
*)

tell application "CotEditor"
	if exists front document then
		set {loc, len} to range of selection
		
		set newStr to "<?xml version=\"1.0\" encoding=\"" & IANA charset of front document & "\"?>" & return
		
		set numOfMove to count of character of newStr
		
		set contents of selection of front document to newStr
		set range of selection of front document to {loc + numOfMove, 0}
	end if
end tell