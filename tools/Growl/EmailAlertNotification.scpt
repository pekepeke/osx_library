on run argv
	set the_title to "EmailAlertNotification"
	set the_description to "Received Notification"
	if (count argv) ≥ 2 then
		set the_title to item 1 of argv
		set the_description to item 2 of argv
	end if
	
	tell application "System Events"
		set isRunning to (count of (every process whose bundle identifier is "com.Growl.GrowlHelperApp")) > 0
	end tell
	
	
	if isRunning then
		tell application id "com.Growl.GrowlHelperApp"
			-- Make a list of all the notification types 
			-- that this script will ever send:
			set the allNotificationsList to ¬
				{"Alert Notification"}
			
			-- Make a list of the notifications 
			-- that will be enabled by default.      
			-- Those not enabled by default can be enabled later 
			-- in the 'Applications' tab of the growl prefpane.
			set the enabledNotificationsList to ¬
				{"Alert Notification"}
			
			-- Register our script with growl.
			-- You can optionally (as here) set a default icon 
			-- for this script's notifications.
			register as application ¬
				"EmailAlertNotification" all notifications allNotificationsList ¬
				default notifications enabledNotificationsList ¬
				icon of application "Thunderbird"
			
			--       Send a Notification...
			notify with name ¬
				"Alert Notification" title ¬
				the_title description ¬
				the_description application name "EmailAlertNotification"
			
		end tell
	end if
end run
