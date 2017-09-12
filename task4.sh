#!/bin/bash


function systemd {
    if [ $distro == "1" ]
    then
        if [ $(systemctl is-active httpd) != "active" ]
        then
            systemctl start httpd
        fi
    fi

    if [ $distro == "3" ]
    then
        if [ $(systemctl is-active apache2) != "active" ]
        then
            systemctl start apache2
        fi
    fi
}

function systemv {
    check=$(service --status-all | grep -o apache2)
    if [ -z "$check" ]
    then
        service apache2 start
    fi
}


echo "Choose distro:"
echo "1. CentOS 7"
echo "2. Debian 8"
echo "3. Ubuntu 16"

read -r -p "Make your choice [1/2/3] " distro
case $distro in
    1)
        systemd
        ;;
    2)
        systemv
        ;;
    3)
        systemd
        ;;
    *)
        echo "You need to make choice"
        ;;
esac
