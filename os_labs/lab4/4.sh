#! /bin/bash

cd $1
for file in *;
do
  stat --format='file name %n, size %s, attributes %A' $file >> .1.txt
done
cd ../$2
for file in *;
do
  stat --format='file name %n, size %s, attributes %A' $file >> .2.txt
done
cd ../
ls -l $1
echo "________________"
echo "________________"
echo "________________"
ls -l $2
echo "Diff:"
diff $1/.1.txt $2/.2.txt
rm $1/.1.txt $2/.2.txt