#!/bin/sh

sed -n '/|/p' $1 > p1
awk -F '|' '{print $1,$2}' p1 > p1.1
tsort p1.1 > p2
sed -n '/,/,$p' $1 > p3
