# PF Wan Updater
This is an add-on for pfSense that will monitor WAN IP changes and notify users via email.

- The script relies on existing SMTP configuration settings under "System > Advanced > Notifications".
- The script will check the current WAN IP via a curl to third-party site
- The current WAN IP is stored in /tmp/old_wan_ip and compared each time the script is run
- Ideally this should be setup to run as a daily cron task
- If there is no change the script will exit quietly
