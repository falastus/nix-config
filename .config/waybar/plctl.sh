#! /bin/sh
if [ "$(playerctl status)" = "Playing" ];
then
    playerctl metadata --format "- {{title}} -"
fi
