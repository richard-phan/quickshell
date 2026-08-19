import "../../"
import "../../components"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Bluetooth
import Quickshell.Widgets

AnimatedPopup {
  id: root

  isWindowVisible: WindowStates.bluetoothVisible
  notchLeft: true
  notchRight: true

  anchors {
    top: true
    right: true
  }

  Column {
    id: contentLayout

    width: 300
    anchors.centerIn: parent
    spacing: 20

    RowLayout {
      width: parent.width

      Text {
        text: "Bluetooth"
        color: Colors.on_surface
        font.bold: true
      }

      Item {
        Layout.fillWidth: true
      }

      BackgroundButton {
        btnWidth: 30
        btnHeight: 30
        radius: 4
        color: hoverHandler.hovered ? Colors.inverse_primary : "transparent"
        btnText: ""
        btnTextColor: hoverHandler.hovered ? Colors.on_primary_container : Colors.on_primary
      }

      BackgroundButton {
        btnWidth: 30
        btnHeight: 30
        radius: 4
        color: BluetoothService.enabled ? Colors.green : Colors.red
        btnText: BluetoothService.enabled ? "" : ""
        tapHandler.onTapped: Bluetooth.defaultAdapter.enabled = !BluetoothdefaultAdapter.enabled
      }
    }

    ColumnLayout {
      width: parent.width
      spacing: 5

      Repeater {
        id: devices

        model: BluetoothService.devices

        delegate: Rectangle {
          id: deviceRow

          width: parent.width
          implicitHeight: row.implicitHeight + 20
          color: Colors.primary_container
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
                color: Colors.on_primary_container
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
                color: Colors.on_primary_container
                font.bold: true
              }

              Text {
                text: modelData.connected ? "Connected" : "Paired"
                color: Colors.primary
                font.bold: true
              }
            }

            Item {
              Layout.fillWidth: true
            }

            Text {
              text: modelData.batteryAvailable ? modelData.battery * 100 + "%" : ""
              color: Colors.on_primary_container
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
                color: Colors.on_primary_container

                Text {
                  id: connectionIcon

                  text: modelData.connected ? "" : ""
                  anchors.centerIn: parent
                  font.pointSize: 16
                  color: Colors.primary_container
                }

                MouseArea {
                  id: hoverAreaConnect

                  anchors.fill: parent
                  hoverEnabled: true
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
                color: Colors.red

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
                    if (hoverAreaForget.containsMouse)
                      forgetBox.color = Qt.lighter(parent.color, 1.3);
                    else
                      forgetBox.color = Colors.red;
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
