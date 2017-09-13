#!/bin/bash

function systemd {
  
    if [ $(systemctl is-active httpd) != "active" ]
        then
            systemctl start httpd		
    fi
    
}

function systemv {
    check=$(service --status-all | grep -o apache2)
    if [ -z "$check" ]
    then
        service apache2 start
	
    fi
}

function systemd1 {
	if [ $(systemctl is-active apache2) != "active" ]
        then
            systemctl start apache2    
        fi
    }

echo "Starting httpd"

if [[ -r /etc/os-release ]]; then
	systemd
elif [[ -r /etc/redhat-release ]]; then
	systemv
elif [[ -r /etc/debian-release ]]; then
	systemd1
else
	echo "ERROR: Unknown distro"
	exit 1
fi
