import QtQuick
import Quickshell.Services.UPower

Widget {
  bgColor: Theme.surface
  icon: ""
  text: UPower.displayDevice.percentage * 100 + "%"
  textColor: Theme.foreground
}
