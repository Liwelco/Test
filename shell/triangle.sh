#!/bin/bash
# 等腰三角形
read -p "Please input the length: " n
for i in `seq 1 $n`
do
   for ((j=$n;j>i;j--))
   do
      echo -n " "
   done
 
   for m in `seq 1 $i`
   do
     echo -n "* "
   done
   echo 
done
