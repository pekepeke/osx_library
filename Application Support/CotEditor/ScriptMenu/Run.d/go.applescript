(* written by satomacoto *)
on run {p}
	if p is not "" then
		set f to (do shell script "/usr/bin/basename \"" & p & "\"")
		set e to (do shell script "echo \"" & f & "\"|awk -F . '{print $NF}'")
		set n to (do shell script "/usr/bin/basename \"" & p & "\" ." & e)
		set d to (do shell script "/usr/bin/dirname \"" & p & "\"")
		
		-- set terminal command
		-- for 64 bit
		set c to "cd " & d & "; 6g " & f & "; 6l " & n & ".6; ./6.out"
		-- for 32 bit
		--set c to "cd " & d & "; 8g " & f & "; 8l " & n & ".8; ./8.out"
		
		tell application "Terminal"
			if (count of windows) is 0 then
				do script with command c
			else
				do script with command c in window 1
			end if
			activate
		end tell
		
	end if
	activate
end run
