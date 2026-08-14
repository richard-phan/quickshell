import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower

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
      color: Colors.on_primary
      font.bold: true
    }

    Text {
      text: "Power profile: " + BatteryService.powerProfile
      color: Colors.on_primary
      font.bold: true
    }

    Item {
      width: parent.width
      height: row.implicitHeight

      Rectangle {
        width: row.width
        height: row.height
        radius: height / 2
        color: Colors.on_primary_container
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

          delegate: Rectangle {
            id: powerModeSelection
            width: 45
            height: width
            radius: height / 2

            property bool selected: model.text === BatteryService.powerProfile
            property bool hovered: powerModeHover.containsMouse

            color: selected ? Colors.tertiary : hovered ? Qt.lighter(Colors.tertiary, 1.3) : Colors.on_surface

            Text {
              anchors.centerIn: parent
              text: model.icon
              font.pointSize: 14
              color: powerModeSelection.selected ? Colors.background : Colors.on_primary
            }

            MouseArea {
              id: powerModeHover
              anchors.fill: parent
              hoverEnabled: !powerModeSelection.selected

              onClicked: {
                switch (model.text) {
                case "Power Saving":
                  PowerProfiles.profile = PowerProfile.PowerSaver;
                  break;
                case "Balanced":
                  PowerProfiles.profile = PowerProfile.Balanced;
                  break;
                case "Performance":
                  PowerProfiles.profile = PowerProfile.Performance;
                  break;
                default:
                  return;
                }
              }
            }
          }
        }
      }
    }
  }
}
