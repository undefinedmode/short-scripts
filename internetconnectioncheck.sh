#!/bin/bash
# 20190807 Script plays sound when internet is (back) up
###################################################################
function pingloop()
{
if ping -c 1 8.8.8.8 &> /dev/null
then
	echo "1"
	vlc "~/YOURSONG.mp3"
	exit
else
	echo "0: retry"
	sleep 1;
	pingloop
fi
}
pingloop
