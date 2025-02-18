#!/bin/sh

while true; do
    myfile=$( find "$HOME/wallpapers" -type f -print0 | shuf -z -n 1 )
    swww img $myfile -t fade --transition-duration 2
    sleep 120
done
