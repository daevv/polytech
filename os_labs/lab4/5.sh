#! /bin/bash

grep -Rl $1 . > out.txt
touch $2
while I= read -r line
do
  echo "$line $(cat -b $line | grep $1)" >> $2
done < out.txt
cat $2
rm out.txt