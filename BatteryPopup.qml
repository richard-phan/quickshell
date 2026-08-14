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
      color: Theme.foreground
      font.bold: true
    }

    Text {
      text: "Power profile: " + BatteryService.powerProfile
      color: Theme.foreground
      font.bold: true
    }

    Item {
      width: parent.width
      height: row.implicitHeight

      Rectangle {
        width: row.width
        height: row.height
        radius: height / 2
        color: Theme.elevated
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

            color: selected ? Theme.primary : hovered ? Qt.lighter(Theme.elevated, 1.3) : Theme.elevated

            Text {
              anchors.centerIn: parent
              text: model.icon
              font.pointSize: 14
              color: powerModeSelection.selected ? Theme.background : Theme.foreground
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
