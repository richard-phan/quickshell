import QtQuick
import Quickshell

import "../../"
import "../../components"

Widget {
  bgColor: Colors.primary
  icon: ""
  textColor: Colors.on_primary

  tapHandler.onTapped: WindowStates.powerVisible = !WindowStates.powerVisible
}
