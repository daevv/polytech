#!/bin/bash

export NAME="Dediaev Danil"
export GROUP="5130901/10202"

STRING="Student $NAME from group number $GROUP"
echo $STRING

CUT=${STRING%/*}
echo $CUT

GROUP="$CUT/00000"
echo $GROUP
