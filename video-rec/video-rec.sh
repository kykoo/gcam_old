#!/bin/bash

#raspivid -t 180000 -w 1280 -h 960 -fps 25 -b 1200000 -p 0,0,1280,960 -o pivideo.h264
raspivid -t 3000 -w 1280 -h 960 -fps 25 -b 1200000 -p 0,0,1280,960 -o pivideo.h264 
# Wrap the raw video with an MP4 container: 
MP4Box -add pivideo.h264 pivideo.mp4
# Remove the source raw file, leaving the remaining pivideo.mp4 file to play
rm pivideo.h264


strTime=$HOSTNAME"-"$(/bin/date +"%Y-%m%d-%H%M")".mp4"
mv pivideo.mp4 /home/pi/video/$strTime
