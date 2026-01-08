#!/usr/bin/env bash

nmcli -t -f WIFI g | grep enabled >/dev/null && echo "󰤨 WiFi" || echo "󰤭 Offline"
