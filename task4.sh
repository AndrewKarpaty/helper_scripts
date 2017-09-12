#!/bin/bash

function systemd {
    if [ -r /etc/os-release ]
    then
        if [ $(systemctl is-active httpd) != "active" ]
        then
            echo "Starting httpd"
            systemctl start httpd
		
        fi
    fi

    if [ -r /etc/debian-release ]
    then
        if [ $(systemctl is-active apache2) != "active" ]
        then
	    echo "Starting httpd"
            systemctl start apache2
	    
        fi
    fi
}

function systemv {
    check=$(service --status-all | grep -o apache2)
    if [ -z "$check" ]
    then
	echo "Starting httpd"
        service apache2 start
	
    fi
}



if [[ -r /etc/os-release ]]; then
	. /etc/os-release
	OS_VERSION=$ID
	echo "Your distro is $OS_VERSION"
	systemd
elif [[ -r /etc/redhat-release ]]; then
	. /etc/redhat-release
	OS_VERSION=$ID
	echo "Your distro is $OS_VERSION"
	systemv
elif [[ -r /etc/debian-release ]]; then
	. /etc/debian-release
	OS_VERSION=$ID
	echo "Your distro is $OS_VERSION"
	systemd
else
	echo ERROR: Unknown distro
	exit 1
fi
