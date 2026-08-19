import QtQuick

import "../../"
import "../../components"

Widget {
  bgColor: Colors.primary
  icon: "󰣇"
  text: ""
  textColor: Colors.on_primary

  property var systemDashboard

  MouseArea {
    anchors.fill: parent
    onClicked: {
      WindowStates.dashboardVisible = !WindowStates.dashboardVisible;
    }
  }
}
