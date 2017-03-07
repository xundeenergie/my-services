#!/bin/bash

# Check if NetworkManager is online, and if there is a working connection
# If no working connection, restart Networkmanager
# restarts also network-online.target, if networkmanager is startet and online, but target is stopped
DEBUG=false

if [ "$(/bin/systemctl is-active NetworkManager.service)" = "active" ]; then
	if /usr/bin/nm-online -q --timeout=5 ; then
		if [ "$(/bin/systemctl is-active network-online.target)" = "active" ]; then
			if /bin/ping -q -c 1 www.google.com > /dev/null ; then
				if $DEBUG ;then echo "online and working";fi
			else
				if  $DEBUG  ;then echo "online NOT working";fi
				exit 2
				#/bin/systemctl restart NetworkManager.service
			fi
		else
			if  $DEBUG  ;then echo "restart network-online.target";fi
			/bin/systemctl start network-online.target

			if /bin/ping -q -c 1 www.google.com > /dev/null ; then
				if  $DEBUG  ;then echo "online and working";fi
			else
				if  $DEBUG  ;then echo "online NOT working";fi
				exit 3
				#/bin/systemctl restart NetworkManager.service
			fi
		fi
	else
		if  $DEBUG  ;then echo "offline";fi
		exit 1
	fi
else
	if  $DEBUG  ;then echo "NetworkManager not running";fi
	exit 0	
fi
exit 0
