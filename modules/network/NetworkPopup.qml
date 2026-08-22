import QtQuick
import QtQuick.Layouts

import Quickshell.Networking

import "../../"
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

  onIsWindowVisibleChanged: {
    if (!WindowStates.networkVisible) {
      NetworkService.clearSavedNetworks();
    }
  }

  ColumnLayout {
    id: contentLayout

    width: 300

    anchors.centerIn: parent

    spacing: 10

    RowLayout {

      Text {
        text: "Network"
        color: Colors.on_surface
        font.bold: true
      }

      Item {
        Layout.fillWidth: true
      }

      BackgroundButton {
        btnWidth: 30
        btnHeight: btnWidth

        radius: 4

        color: {
          if (NetworkService.isScanning) {
            return Colors.inverse_primary;
          }
          return hoverHandler.hovered ? Colors.tertiary : "transparent";
        }

        btnText: "󰑐"
        btnTextColor: hoverHandler.hovered ? Colors.on_tertiary : Colors.on_surface
        btnTextPointSize: 14

        tapHandler.onTapped: NetworkService.scanNetwork()
        tapHandler.enabled: !NetworkService.isScanning
      }

      BackgroundButton {
        btnWidth: 30
        btnHeight: btnWidth

        radius: 4

        color: {
          if (Networking.wifiEnabled) {
            return hoverHandler.hovered ? Colors.on_tertiary_container : Colors.tertiary;
          } else {
            return hoverHandler.hovered ? Colors.on_error : Colors.error;
          }
        }

        btnText: Networking.wifiEnabled ? "" : ""
        btnTextColor: {
          if (Networking.wifiEnabled) {
            return hoverHandler.hovered ? Colors.tertiary_container : Colors.on_tertiary;
          } else {
            return hoverHandler.hovered ? Colors.error : Colors.on_error;
          }
        }
        btnTextPointSize: 10

        tapHandler.onTapped: NetworkService.toggleWifi()
      }
    }

    NetworkEntry {
      entryWidth: contentLayout.width
      entryHeight: 50
      entryPadding: 30

      entryColor: Colors.primary
      textColor: Colors.on_primary

      radius: 10

      network: NetworkService.connectedNetwork
    }

    ColumnLayout {

      spacing: 5

      Repeater {
        model: NetworkService.availableNetworks

        delegate: NetworkEntry {
          entryWidth: contentLayout.width
          entryHeight: 50
          entryPadding: 30

          entryColor: Colors.primary_container
          textColor: Colors.on_primary_container

          radius: 10

          network: modelData
        }
      }
    }
  }
}
