#! /usr/bin/env bash

# Set the avatar using DBUS
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
dms ipc call profile setImage /home/mukuldk/1_file/9_Pictures/avatar/YangKai-Square.png

echo "Done! Check if avatar appears in DMS"
