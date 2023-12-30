#! /usr/bin/env bash
# These are specifically around me attaching and detaching my rokid max glasses

# Get the monitor name from the user input
monitor_name=$1

# Get the list of all monitors in JSON format
monitors=$(hyprctl monitors -j all)

# Loop through each monitor in the list
is_rokid_monitor=$(echo "$monitors" | jq -r ".[] | select(.name == \"${monitor_name}\" and .model == \"Rokid Max\") | true // false ")

 # Decode the monitor JSON object
if [ "$is_rokid_monitor" == "true" ]; then
    echo "$monitors" | jq -c '.[]' | while read -r monitor; do
        name=$(echo "$monitor" | jq -r '.name')
        # Check if the monitor is the one specified by the user
        if [ "$name" != "$monitor_name" ]; then
            # Disable the monitor
            hyprctl keyword monitor "$name,disable"
        fi
    done
fi
