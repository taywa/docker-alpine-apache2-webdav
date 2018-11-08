#!/bin/bash

only_www=false
only_ftp=false
username=""
sharename=""


usage()
{
    echo "usage: create_user_share.sh [[[-w] [-f] [-s sharename] username] | [-h]]"
}


create_www()
{
    echo "create www share:$sharename username:$username"
    share_conf=$(cat <<EOF
Alias /$sharename "/var/www/$sharename"
<Directory "/var/www/$sharename">
    Include /etc/apache2/webdav_defaults.conf
    AuthUserFile "/etc/auth/apache2/$sharename/users.passwd"
</Directory>
EOF
    )
    mkdir -p /etc/auth/apache2/$sharename
    echo "$share_conf" > /etc/auth/apache2/$sharename/share.conf
    passwd_hash=$(openssl passwd -apr1)
    echo "$username:$passwd_hash" >> /etc/auth/apache2/$sharename/users.passwd
}


create_ftp()
{
    echo "create ftp share:$sharename username:$username"
    share_conf="local_root=/var/www/$sharename/"
    echo "$share_conf" > /etc/auth/vsftpd/users/$username
    mkdir -p /etc/auth/apache2/$sharename
    echo "$share_conf" > /etc/auth/apache2/$sharename/share.conf
    passwd_hash=$(openssl passwd -1)
    echo "$username:$passwd_hash" >> /etc/auth/vsftpd/users.passwd

}


create()
{
    if [ $only_www == true ]; then
        create_www
    fi

    if [ $only_ftp == true ]; then
        create_ftp
    fi
}


while [ "$1" != "" ]; do
    case $1 in
        -w | --www )            only_www=true
                                ;;
        -f | --ftp )            only_ftp=true
                                ;;
        -s | --sharename )      shift
                                sharename=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     username=$1
                                ;;
    esac
    shift
done


if [ "$username" != "" ]; then
    if [ "$sharename" == "" ]; then
        sharename=$username
    fi
    create
else
    usage
    exit 1
fi
