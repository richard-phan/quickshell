import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Networking

PopupWidget {
  implicitWidth: mainContent.implicitWidth
  implicitHeight: mainContent.implicitHeight

  isWindowVisible: !WindowStates.networkVisible

  anchors {
    top: true
    right: true
  }

  margins.top: 30 // bar height

  Rectangle {
    id: mainContent

    anchors.fill: parent

    property int padding: 40

    implicitWidth: contentLayout.width + padding
    implicitHeight: contentLayout.height + padding

    color: Theme.background

    ColumnLayout {
      id: contentLayout

      anchors.centerIn: parent

      spacing: 10

      width: 300

      RowLayout {

        Text {
          text: "Network"
          color: Theme.foreground
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

          btnText: NetworkState.enabled ? "C" : ""
          btnTextColor: Theme.background
          btnTextPointSize: 14
        }
      }

      Repeater {
        model: Networking.devices

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
}
