#!/bin/bash
sudo yum update -y 
sudo yum install nginx -y 
sudo service nginx start
echo "hello world" > /usr/share/nginx/html/index.html
MYIP=$(ifconfig | grep 'addr:10' | awk '{ print $2 }' | cut -d ':' -f2)
echo -e "instance ID:\t" $MYIP >>  /usr/share/nginx/html/index.html