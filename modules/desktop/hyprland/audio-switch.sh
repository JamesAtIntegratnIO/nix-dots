#!/usr/bin/env bash
case "$1" in
    mic)
        all_mics=$(pactl list short sources | cut -f 2)
        default_mic=$(pactl get-default-source | cut -d : -f 2)
        active_mic=$(echo "$all_mics" | grep -n "$default_mic" | cut -d : -f 1)
        selected_mic=$(echo "$all_mics" | rofi -dmenu -i -a $((active_mic - 1)) -p 'Select a device: ')
        pactl set-default-source "$selected_mic"
        ;;
    speaker)
        all_sinks=$(pactl list short sinks | cut -f 2)
        default_sink=$(pactl get-default-sink | cut -d : -f 2)
        active_sink=$(echo "$all_sinks" | grep -n "$default_sink" | cut -d : -f 1)
        selected_sink=$(echo "$all_sinks" | rofi -dmenu -i -a $((active_sink - 1)) -p 'Select a device: ')
        pactl set-default-sink "$selected_sink"
        ;;
esac

