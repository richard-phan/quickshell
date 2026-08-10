import QtQuick
import Quickshell.Hyprland

Widget {
    bgColor: Theme.surface
    icon: ""
    property int maxLength: 35
    text: Hyprland.activeToplevel.title
    textColor: Theme.foreground
}
