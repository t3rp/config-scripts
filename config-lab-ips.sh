#!/bin/bash

# Check for valid lab connection
check=`ip a s tun0 | egrep -o 'inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d ' ' -f 2 | cut -d '.' -f 1`

# Grab third octet from tun0
tunnel=`ip a s tun0 | egrep -o 'inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d ' ' -f 2`
octet=`echo $tunnel | cut -d '.' -f 3`

# Replace ips
sed '/Begin-oswe-lab-ips/,/End-oswe-lab-ips/d' < /etc/hosts > newhosts

# Add oswe/awae ips
echo "#Begin-oswe-lab-ips
192.168.$octet.103 atutor
192.168.$octet.106 atmail
192.168.$octet.112 bassmaster
192.168.$octet.113 manageengine
192.168.$octet.120 dnn
192.168.$octet.123 erpnext
192.168.$octet.126 opencrx
192.168.$octet.129 openitcockpit
192.168.$octet.247 sqeakr
192.168.$octet.249 docedit
192.168.$octet.251 answers
192.168.$octet.253 debugger
#End-oswe-lab-ips" >> newhosts

if [ "$check" != '192' ]; then
	printf "Double check the VPN connection."
	rm newhosts
	exit
else
	# Make a backup
	mv /etc/hosts /etc/hosts.back
	# Replace with new
	mv newhosts /etc/hosts
fi
