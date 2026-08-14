import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Networking

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
        color: Theme.foreground
        font.bold: true
      }

      Item {
        Layout.fillWidth: true
      }

      BackgroundButton {
        btnWidth: 30
        btnHeight: btnWidth

        radius: 4

        color: hoverHandler.hovered ? Theme.surface : "transparent"

        btnText: "󰑐"
        btnTextColor: Theme.foreground
        btnTextPointSize: 14

        tapHandler.onTapped: NetworkState.enableScan = true
      }

      BackgroundButton {
        btnWidth: 30
        btnHeight: btnWidth

        radius: 4

        color: NetworkState.enabled ? Theme.green : Theme.red

        btnText: NetworkState.enabled ? "" : ""
        btnTextColor: Theme.background
        btnTextPointSize: 14
      }
    }

    Repeater {
      model: NetworkState.connectedNetwork

      delegate: NetworkEntry {
        entryWidth: contentLayout.width
        entryHeight: 50
        entryPadding: 30

        entryColor: Theme.elevated

        radius: 10

        networkName: modelData.name
      }
    }
  }
}
