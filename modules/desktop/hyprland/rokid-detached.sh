#! /usr/bin/env bash
# These are specifically around me attaching and detaching my rokid max glasses

# Get the monitor name from the user input
monitor_name=$1

# Get the list of all monitors in JSON format
monitors=$(hyprctl monitors -j all)
position () {
  position=""
  model=$(get_model "$1")
  # Big Monitor
  case "$model" in
    "AORUS FV43U")
      position="0x0"
      ;;
    "0x1404")
      position="3840x0"
      ;;
    "*")
      position="auto"
      ;;
  esac
  echo "$position"

}

get_model () {
  model=$(echo "$monitors" | jq -r ".[] | select(.name == \"${1}\") | .model")
  echo "$model"
}

 # Decode the monitor JSON object
if [ "$monitor_name" == "DP-2" ]; then
  echo "$monitors" | jq -c '.[]' | while read -r monitor; do
    name=$(echo "$monitor" | jq -r '.name')
    width=$(echo "$monitor" | jq -r '.width')
    height=$(echo "$monitor" | jq -r '.height')
    # Check if the monitor is the one specified by the user
    if [ "$name" != "$monitor_name" ]; then
      # Enable the monitor
      hyprctl keyword monitor "$name,${width}x${height},$(position "$name"),1"

    fi
  done
fi

