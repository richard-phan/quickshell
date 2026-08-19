import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower

import "../../"
import "../../components"

AnimatedPopup {
  id: root

  isWindowVisible: WindowStates.batteryVisible

  notchLeft: true
  notchRight: true

  anchors {
    top: true
    right: true
  }

  ColumnLayout {
    id: contentLayout

    anchors.centerIn: parent

    spacing: 10

    Text {
      text: "Battery: " + BatteryService.powerMode
      color: Colors.on_surface
      font.bold: true
    }

    Text {
      text: "Power profile: " + BatteryService.powerProfile
      color: Colors.on_surface
      font.bold: true
    }

    Row {
      id: row

      spacing: 10

      Repeater {
        model: ListModel {
          ListElement {
            text: "Power Saving"
            icon: "󰌪"
          }
          ListElement {
            text: "Balanced"
            icon: ""
          }
          ListElement {
            text: "Performance"
            icon: "󱓞"
          }
        }

        delegate: BackgroundButton {
          btnWidth: 50
          btnHeight: 50
          color: selected ? Colors.tertiary : hoverHandler.hovered ? Colors.on_primary : Colors.primary
          radius: 25

          property bool selected: model.text === BatteryService.powerProfile

          btnText: model.icon
          btnTextPointSize: 15
          btnTextColor: selected ? Colors.on_tertiary : hoverHandler.hovered ? Colors.primary : Colors.on_primary

          hoverHandler.enabled: !selected

          tapHandler.onTapped: {
            if (selected) {
              return;
            }

            switch (model.text) {
            case "Power Saving":
              PowerProfiles.profile = PowerProfile.PowerSaver;
              return;
            case "Balanced":
              PowerProfiles.profile = PowerProfile.Balanced;
              return;
            case "Performance":
              PowerProfiles.profile = PowerProfile.Performance;
              return;
            }
          }
        }
      }
    }
  }
}
