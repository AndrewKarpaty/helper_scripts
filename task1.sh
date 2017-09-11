#!/bin/bash

# privilege check
if [[ $EUID -ne 0 ]]; then
    echo "You need to be root or use sudo to run this script"
    exit 1
fi

function centos {
    echo "## Install LAMP"
    yum -y install httpd mariadb mariadb-server php php-mysql
    echo -e "\n"

    echo "## Add firewall rules"
    firewall-cmd --permanent --add-service=http | exit 1  # exit 1 if firewalld is disabled
    firewall-cmd --add-port=8080/tcp | exit 1  # 8080 port for sites created for testing purposes
    systemctl restart firewalld | exit 1  # exit 1 if our centos system does not have firewalld
    echo -e "\n"

    echo "## Restart LAMP"
    systemctl restart httpd
    systemctl restart mariadb
    echo -e "\n"

    echo "## Enable LAMP"
    systemctl enable mariadb
    systemctl enable httpd
    echo -e "\n"
}

function debian {
    echo "## Install LAMP"
    aptitude -y install apache2 apache2-doc mysql-server php5-mysql php5-common libapache2-mod-php5 php5-cli
    echo -e "\n"

    echo "## Restart LAMP"
    service apache2 restart
    service mysql restart
    echo -e "\n"
}

function ubuntu {
    echo "## Install LAMP"
    apt-get -y install apache2 mysql-server mysql-client php libapache2-mod-php php-mcrypt php-mysql
    echo -e "\n"

    echo "## Restart LAMP"
    systemctl restart apache2
    systemctl restart mysql

}

function scratch {
    # set software versions
    autoconf="2.69" # for build svn
    apache_subversion="1.9.7" # for download gcc
    apache_httpd="2.4.27"
    apache_apr="1.6.2" # for build apache
    gcc="7.2.0"

#    echo "## Download GCC"
#    curl -o gcc.tar.xz https://ftp.gnu.org/gnu/gcc/gcc-7.2.0/gcc-7.2.0.tar.xz
#    echo -e "\n"
#    echo "## Unpack GCC"
#    tar xvf gcc.tar.xz

#    echo "## Download Autoconf"
#    curl -o autoconf.tar.gz http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz
#    echo -e "\n"
#    echo "## Unpack Autoconf"
#    tar xvf autoconf.tar.gz
#    echo -e "\n"
#    cd autoconf-$autoconf
#    cd ../

#    echo "Download SVN"
#    curl -o svn.tar.gz http://apache.volia.net/subversion/subversion-$apache_subversion.tar.gz
#    echo -e "\n"
#    echo "## Unpack SVN"
#    tar xvf svn.tar.gz
#    echo -e "\n"
#    echo "## Build SVN"
#    cd subversion-$apache_subversion
#    cd ../

#    echo "## Download APR"
#    curl -o apr.tar.gz http://apache.volia.net//apr/apr-$apache_apr.tar.gz
#    echo -e "\n"
#    echo "## Unpack Apache APR"
#    tar xvf apr.tar.gz
#    echo -e "\n"
#    echo "## Build APR"
#    cd apr-$apache_apr
#    ./configure
#    make
#    make install
#    cd ../
#    echo -e "\n"

#    echo "## Download Apache HTTPD"
#    curl -o apache.tar.gz http://apache.volia.net//httpd/httpd-$apache_httpd.tar.gz
#    echo -e "\n"
#    echo "## Unpack Apache HTTPD"
#    tar xvf apache.tar.gz
#    echo -e "\n"
#    echo "Build Apache"
#    cd httpd-$apache_httpd
#    CC="pgcc" CFLAGS="-O2" \
#    ./configure --prefix=/sw/pkg/apache \
#    --enable-ldap=shared \
#    --enable-lua=shared
#    make
#    make install

echo "Coming soon"
}


echo "Choose distro:"
echo "1. CentOS 7"
echo "2. Debian 8"
echo "3. Ubuntu 16"
echo "4. Other (build from source)"

read -r -p "Make your choice [1/2/3/4] " distro
case $distro in
    1)
        centos &> task1_log.txt
        ;;
    2)
        debian &> task1_log.txt
        ;;
    3)
        ubuntu &> task1_log.txt
        ;;
    4)
        scratch &> task1_log.txt
        ;;
    *)
        echo "You need to make choice"
        ;;
esac

