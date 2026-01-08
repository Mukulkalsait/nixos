#!/usr/bin/env bash

cat /sys/class/power_supply/BAT1/capacity | awk '{print "⚡" $1 }'
