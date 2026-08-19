#!/bin/bash

WALLPAPER_PATH=""
WALLPAPER=0
THEME=0

while [[ $# -gt 0 ]]; do
    case  "$1" in
        -p|--path)
            WALLPAPER_PATH="$2"
            shift 2
            ;;
        -w|---wallpaper)
            WALLPAPER=1
            shift 1
            ;;
        -t|--theme)
            THEME=1
            shift 1
            ;;
        *)
            echo "Unkown option: $1"
            exit 1
            ;;
    esac
done

if [ -z $WALLPAPER_PATH ]; then
    echo "Error: No wallpaper path provided."
    exit 1
fi

if [ $WALLPAPER == 1 ]; then
    hyprctl hyprpaper wallpaper "eDP-0,$WALLPAPER_PATH,cover"
    hyprctl hyprpaper wallpaper "DP-1,$WALLPAPER_PATH,cover"
fi

if [ $THEME == 1 ]; then
    matugen image $WALLPAPER_PATH -m dark --prefer saturation
fi
