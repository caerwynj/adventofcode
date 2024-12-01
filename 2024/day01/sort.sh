#!/bin/sh

awk '{print $1}' input.txt |sort -n > t3
awk '{print $2}' input.txt |sort -n > t4
