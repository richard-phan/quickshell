import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Bluetooth
import Quickshell.Widgets

PopupWidget {
  implicitWidth: mainContent.implicitWidth
  implicitHeight: mainContent.implicitHeight

  isWindowVisible: WindowStates.bluetoothVisible

  anchors {
    top: true
    right: true
  }

  margins.top: 30

  Rectangle {
    id: mainContent

    property var padding: 40

    implicitWidth: contentLayout.implicitWidth + padding
    implicitHeight: contentLayout.implicitHeight + padding

    color: Theme.background

    Column {
      id: contentLayout

      width: 300

      anchors.centerIn: mainContent
      spacing: 20

      RowLayout {
        width: parent.width

        Text {
          text: "Bluetooth"
          color: Theme.foreground
          font.bold: true
        }

        Item {
          Layout.fillWidth: true
        }

        BackgroundButton {
          btnWidth: 30
          btnHeight: 30

          radius: 4

          color: hoverHandler.hovered ? Theme.surface : "transparent"

          btnText: ""
          btnTextColor: Theme.foreground
        }

        BackgroundButton {
          btnWidth: 30
          btnHeight: 30

          radius: 4

          color: BluetoothStates.enabled ? Theme.green : Theme.red

          btnText: BluetoothStates.enabled ? "" : ""

          tapHandler.onTapped: Bluetooth.defaultAdapter.enabled = !BluetoothdefaultAdapter.enabled
        }
      }

      ColumnLayout {
        width: parent.width
        spacing: 5

        Repeater {
          id: devices

          model: BluetoothStates.devices

          delegate: Rectangle {
            id: deviceRow
            width: parent.width
            implicitHeight: row.implicitHeight + 20
            color: Theme.elevated
            radius: 10

            RowLayout {
              id: row
              anchors.fill: parent
              anchors.margins: 10
              spacing: 10

              Item {
                width: 40
                height: width

                Rectangle {
                  anchors.fill: parent
                  radius: 4

                  color: Theme.surface
                }

                IconImage {
                  width: 40
                  height: 40
                  source: Quickshell.iconPath(modelData.icon)
                }
              }

              ColumnLayout {
                Text {
                  text: modelData.name
                  color: Theme.foreground
                  font.bold: true
                }

                Text {
                  text: modelData.connected ? "Connected" : "Paired"
                  color: Theme.mutedForeground
                  font.bold: true
                }
              }

              Item {
                Layout.fillWidth: true
              }

              Text {
                text: modelData.batteryAvailable ? modelData.battery * 100 + "%" : ""
                color: Theme.foreground
                font.bold: true
              }

              RowLayout {
                spacing: 0

                Rectangle {
                  id: connectionBox
                  width: 40
                  height: 40
                  topLeftRadius: 4
                  bottomLeftRadius: 4
                  color: Theme.blue

                  Text {
                    id: connectionIcon
                    text: modelData.connected ? "" : ""
                    anchors.centerIn: parent
                    font.pointSize: 16
                    color: Theme.background
                  }

                  MouseArea {
                    id: hoverAreaConnect
                    anchors.fill: parent
                    hoverEnabled: true

                    onContainsMouseChanged: {
                      if (hoverAreaConnect.containsMouse) {
                        connectionBox.color = Qt.lighter(parent.color, 1.2);
                      } else {
                        connectionBox.color = Theme.blue;
                      }
                    }

                    onClicked: {
                      modelData.connected = !modelData.connected;
                    }
                  }
                }

                Rectangle {
                  id: forgetBox
                  width: 40
                  height: 40
                  topRightRadius: 4
                  bottomRightRadius: 4
                  color: Theme.red

                  Text {
                    text: ""
                    font.pointSize: 16
                    anchors.centerIn: parent
                  }

                  MouseArea {
                    id: hoverAreaForget
                    anchors.fill: parent
                    hoverEnabled: true

                    onContainsMouseChanged: {
                      if (hoverAreaForget.containsMouse) {
                        forgetBox.color = Qt.lighter(parent.color, 1.3);
                      } else {
                        forgetBox.color = Theme.red;
                      }
                    }

                    onClicked: {
                      console.log("forgetting device");
                      if (modelData.paired)
                        modelData.forget();
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
