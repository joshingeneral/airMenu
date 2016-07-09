#!/bin/bash
echo "Script will put the correct settings in for the 'Eleduino Raspberry Pi 7 Inch 1024x600 Pixel IPS Hdmi Input Capacitive TouchScreen Display'"
echo "Make sure you run this as root so it can write to /boot/config.txt"
pause
echo "hdmi_group=2" >> /boot/config.txt
echo "hdmi_mode=1" >> /boot/config.txt
echo "hdmi_mode=87" >> /boot/config.txt
echo "hdmi_cvt 1024 600 60 0 0 0 " >> /boot/config.txt
echo "max_usb_current=1" >> /boot/config.txt
