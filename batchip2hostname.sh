#!/bin/sh
# 2021-06-09 Convert list of IP's to a #1 list containing all hostnames found via nslookup and #2 a list of all IP's with matching (found) hostnames on the next line
timestamp=`date +%Y-%m-%d-%H%M`
both="$timestamp-result-ip-and-hostname.txt"
hostnameonly="$timestamp-result-hostname-only.txt"

cat $1 | while read line
do
	echo $line >> $both
	nslookup $line | grep -i Name | head -n 1| tail -n1 | cut -d:   -f2 | sed -e 's/^[ \t]*//'  | cut -d '=' -f 2- | cut -d. -f1-2 | sed 's|^[[:blank:]]*||g' >> $both
	nslookup $line | grep -i Name | head -n 1| tail -n1 | cut -d:   -f2 | sed -e 's/^[ \t]*//'  | cut -d '=' -f 2- | cut -d. -f1-2 | sed 's|^[[:blank:]]*||g'>> $hostnameonly
done
