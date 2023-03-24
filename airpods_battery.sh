#!/bin/bash

# Set your AirPods name
airpods_name="Your AirPods Name"

# Get the current status of Bluetooth on macOS Ventura
bluetooth_status=$(system_profiler SPBluetoothDataType | grep -c "Not Connected:" )
num_lines_not_connected=$(system_profiler SPBluetoothDataType | grep -A 100 "Not Connected:"  | wc -l )

if [ "$bluetooth_status" -eq 0 ]; then
	# If Bluetooth is turned off
	echo "Bluetooth OFF"
else
	if [ "$num_lines_not_connected" -eq 5 ]; then
		# If Bluetooth is turned on & AirPods is connected
		system_profiler SPBluetoothDataType | grep -A 7 "$airpods_name" | awk '/Left Battery Level/{print $4} /Right Battery Level/{print $4}' ORS=' ' \
		&& system_profiler SPBluetoothDataType | grep -A 7 "$airpods_name" | awk '/Case Battery Level/{print "("$4 ")"}'| tail -n1
	else
		# If Bluetooth is turned on & AirPods is not connected
		echo "Not Connected"
	fi
fi