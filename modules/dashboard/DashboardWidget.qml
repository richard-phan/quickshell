import QtQuick

import "../../"
import "../../components"

Widget {
  bgColor: Colors.primary_container
  icon: "󰣇"
  text: ""
  textColor: Colors.on_primary_container

  property var systemDashboard

  MouseArea {
    anchors.fill: parent
    onClicked: {
      WindowStates.dashboardVisible = !WindowStates.dashboardVisible;
    }
  }
}
