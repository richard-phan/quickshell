import QtQuick

import "."

Widget {
  bgColor: Theme.surface
  icon: ""
  text: "ARCH"
  textColor: Theme.foreground

  property var systemDashboard

  MouseArea {
    anchors.fill: parent
    onClicked: {
      WindowStates.dashboardVisible = !WindowStates.dashboardVisible
    }
  }
}
