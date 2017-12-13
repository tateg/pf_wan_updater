#!/bin/sh

# Script to check and compare current WAN IP
# If WAN IP has changed, send email
# Uses SMTP configuration in System > Advanced > Notifications
# Written by Tate Galbraith

provider="whatismyip.akamai.com" # Specify where to check IP
curwanip=$(curl -s $provider)
location=$1 # Accept first argument as location ID
date=$(date)

# Check if the old_wan_ip file exists?
# Create the file in /tmp if it does not
if [ ! -f /tmp/old_wan_ip ]; then
  echo $curwanip > /tmp/old_wan_ip
fi

oldwanip=$(cat /tmp/old_wan_ip)

message="Public WAN IP Change Alert!\n\n\
Date: $date\n\
Location: $location\n\
Old IP: $oldwanip\n\
New IP: $curwanip\n\n\
Please update site-to-site VPN settings accordingly..."

subject="pfSense Public WAN IP Change Alert"

# Check if current and old IPs match
if [ $curwanip = $oldwanip ]; then
  exit # Nothing to do
else
  # Send the email notification then update old IP
  echo $message | /usr/local/bin/mail.php -s=$subject
  echo $curwanip > /tmp/old_wan_ip
fi
