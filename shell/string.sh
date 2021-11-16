#!/bin/bash
var="http://www.aaa.com/root/123.htm"
#1.
echo $var |awk -F '//' '{print $2}'
#2.
echo $var |awk -F '/' '{print $5}'
#3.
echo $var |grep -o 'http.*root'
#4.
echo $var |awk -F '/' '{print $1}'
#5.
echo $var |grep -o 'http://'
#6.
echo $var |grep -o 'www.*htm'
#7.
echo $var |grep -o '123'
#8.
echo $var |grep -o '123.htm'
