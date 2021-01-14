#!/bin/bash

DIRECTORY="/tmp/qrcode"
#echo $DIRECTORY
if [[ ! -d "$DIRECTORY" ]]
then
#    echo "$DIRECTORY directory doesn't exist, creating one"
    mkdir -p "$DIRECTORY"
fi

#echo "Removing old files"
rm -f "$DIRECTORY"/*

#echo "Capture QR code screenshot"
xfce4-screenshooter --region --save "$DIRECTORY" &>/dev/null
wait

#echo "Reading QR code image"
zbarimg "$DIRECTORY"/*

#echo "Removing old files"
rm -f "$DIRECTORY"/*