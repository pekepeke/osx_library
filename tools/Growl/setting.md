## Thunderbird
- Mailbox Alert
	- [Add On](https://addons.mozilla.org/ja/thunderbird/addon/mailbox-alert/)
	- for Growl setting
		- /usr/bin/osascript /path/to/Growl/EmailAlertNotification.scpt
		- Growl > Application > AlertNotifier > EmailAlertNotification
			- 画面にとどまる → 常に
	- 注意
		- 日本語を含む通知が行えない(使うとアクションが行われない。デフォルトのアクションも無効となる)ので、表示項目には日本語が含まれないフィールドを使用する必要がある。
```
	#/usr/bin/osascript /path/to/Growl/EmailAlertNotification.scpt %sendername %subject\ -\ %folder
	/usr/bin/osascript /path/to/Growl/EmailAlertNotification.scpt %senderaddress "Received alert notification"
```

