#!/bin/bash

for((;;))
do
echo "Type something"
read var
echo "You typed: $var"

sleep 20
echo "type string to return"
read second_var
sleep 30
echo "You entered $second_var later"
done