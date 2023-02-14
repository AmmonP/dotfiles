#!/bin/bash

deviceName=$(adb shell getprop ro.product.model)
dateInfo=$(date '+%Y-%m-%d')
dateTime=$(date '+%H:%M:%S')
screenshotName="${deviceName}-Screen-Shot-${dateInfo}-at-${dateTime}.png"
screenshotPath="/sdcard/${screenshotName}"

adb shell screencap -p "$screenshotPath"
adb pull "$screenshotPath" ~/Desktop/"${screenshotName}"
