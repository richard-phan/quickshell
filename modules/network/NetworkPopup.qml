import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Networking

import "../../components"

AnimatedPopup {
  id: root

  isWindowVisible: WindowStates.networkVisible

  notchLeft: true
  notchRight: true

  anchors {
    top: true
    right: true
  }

  ColumnLayout {
    id: contentLayout

    width: 300

    anchors.centerIn: parent

    spacing: 10

    RowLayout {

      Text {
        text: "Network"
        color: Colors.primary_container
        font.bold: true
      }

      Item {
        Layout.fillWidth: true
      }

      BackgroundButton {
        btnWidth: 30
        btnHeight: btnWidth

        radius: 4

        color: hoverHandler.hovered ? Colors.inverse_primary : "transparent"

        btnText: "󰑐"
        btnTextColor: hoverHandler.hovered ? Colors.on_primary_container : Colors.on_primary
        btnTextPointSize: 14

        tapHandler.onTapped: NetworkState.enableScan = true
      }

      BackgroundButton {
        btnWidth: 30
        btnHeight: btnWidth

        radius: 4

        color: NetworkState.enabled ? Colors.tertiary : Colors.error

        btnText: NetworkState.enabled ? "" : ""
        btnTextColor: Colors.background
        btnTextPointSize: 14
      }
    }

    Repeater {
      model: NetworkState.connectedNetwork

      delegate: NetworkEntry {
        entryWidth: contentLayout.width
        entryHeight: 50
        entryPadding: 30

        entryColor: Colors.primary_container

        radius: 10

        networkName: modelData.name
      }
    }
  }
}
