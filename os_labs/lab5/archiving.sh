#!/bin/bash

for((;;))
do
sleep $3
time=$(date +%d_%m_%y_%H_%M_%S)
tar -cf $1_$time.tar.gz $2
done