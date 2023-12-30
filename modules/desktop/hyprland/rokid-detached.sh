#! /usr/bin/env bash
# These are specifically around me attaching and detaching my rokid max glasses

# Get the monitor name from the user input
monitor_name=$1

# Get the list of all monitors in JSON format
monitors=$(hyprctl monitors -j all)

 # Decode the monitor JSON object
if [ "$monitor_name" == "DP-2" ]; then
    echo "$monitors" | jq -c '.[]' | while read -r monitor; do
        name=$(echo "$monitor" | jq -r '.name')
        width=$(echo "$monitor" | jq -r '.width')
        height=$(echo "$monitor" | jq -r '.height')
        # Check if the monitor is the one specified by the user
        if [ "$name" != "$monitor_name" ]; then
            # Enable the monitor
            echo "hyprctl keyword monitor $name,${width}x${height},auto,1"
            hyprctl keyword monitor "$name,${width}x${height},auto,1"

        fi
    done
fi