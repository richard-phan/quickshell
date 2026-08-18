import QtQuick
import Quickshell.Hyprland

Widget {
  bgColor: Colors.primary_container
  icon: ""
  text: {
    const maxLength = 40;
    const title = Hyprland.activeToplevel.title;

    return (title.length <= maxLength) ? title : title.substring(0, maxLength) + "...";
  }
  textColor: Colors.on_primary_container
}
