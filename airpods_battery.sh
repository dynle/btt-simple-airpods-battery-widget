#!/bin/bash

airpods_name="My Airpods Pro"

# Get the current status of Bluetooth on macOS Ventura
bluetooth_status=$(system_profiler SPBluetoothDataType | grep -c "Not Connected:" )

if [ "$bluetooth_status" -eq 0 ]; then
	echo "Not Connected"
else
	system_profiler SPBluetoothDataType | grep -A 7 "$airpods_name" | awk '/Left Battery Level/{print $4} /Right Battery Level/{print $4}' ORS=' ' && system_profiler SPBluetoothDataType | grep -A 7 "$airpods_name" | awk '/Case Battery Level/{print "("$4 ")"}'| tail -n1
fi