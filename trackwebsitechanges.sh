#!/bin/bash 
# 20190616 Quick script that monitors a static website for changes, to be run as periodic cron job
timestamp=`date +%F_%H%M%S`
url='http://example.com/'
mailaddress='test@example.com'

# DOWNLOAD
wget -O $timestamp.html $url

# check if first run
file=./last.txt
if [ ! -e "$file" ]; then
    echo "File does not exist"
else 
    echo "File exists"
fi 

# compare
file1=`md5sum ./last.txt | cut -c 1-32`
file2=`md5sum ./$timestamp.html | cut -c 1-32`
if [ "$file1" = "$file2" ]
then
    echo "Files have the same content"
else
    echo "Files have NOT the same content"
	# send email
	mail -s "Website change detected" $mailaddress <<< ' '
fi

# cleanup
rm last.txt
mv $timestamp.html last.txt
