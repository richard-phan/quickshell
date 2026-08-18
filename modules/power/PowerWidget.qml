import QtQuick
import Quickshell

import "../../components"

Widget {
  bgColor: Colors.primary_container
  icon: ""
  textColor: Colors.on_primary_container

  tapHandler.onTapped: WindowStates.powerVisible = !WindowStates.powerVisible
}
