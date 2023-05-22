#!/bin/bash
# This script will check if our IP address has changed,
# and it will update the FreeDNS entry with the new IP

# URLs used to update IPs
URLS=(
	# (enter your URLs here)
	"https://example.com"
)

# Domain to use
DOMAIN="example.com"

# Check if log file exists
! [ -f "/var/log/ip.log" ] && echo "-- Begin IP log --" >> /var/log/ip.log

# Now, check IPs
new_ip=$(curl -s ifconfig.me/ip)
old_ip=$(dig -4 $DOMAIN a +noall +answer | awk '{print $5}')

# Now we check the new IP against the old IP
if [[ $new_ip != $old_ip ]]; then
	echo "$(date) IPs are different, updating! ($new_ip / $old_ip)"

	for url in "${URLS[@]}"; do
		echo $(curl -sk "$url")
	done
else
	echo "IPs are the same, ignoring... ($new_ip)"
fi

# Update /etc/resolv.conf
if [ -w /etc/resolv.conf ]; then
	echo "\
nameserver $new_ip
nameserver 9.9.9.9
nameserver 149.112.112.112" > /etc/resolv.conf
else
	echo "Notice: you have to manually update /etc/resolv.conf,"
	echo "adding 'nameserver $new_ip' before all other nameservers."
fi
