#! /bin/bash

export x=6
export y=9

echo "x=$x, y=$y"
echo "x + y = "$(($x+$y))
echo "x - y = "$(($x-$y))
echo "x * y = "$(($x*$y))
echo "x / y = "$(($x/$y))
echo "x ** y = "$(($x**$y))
