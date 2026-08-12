import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Bluetooth

PopupWidget {
    implicitWidth: 300
    implicitHeight: 300

    isWindowVisible: WindowStates.bluetoothVisible

    anchors {
        top: true
        right: true
    }

    margins.top: 30

    Rectangle {
        anchors.fill: parent
        color: Theme.surface

        Column {
            x: 10
            y: 10
            width: parent.width - (x * 2)
            spacing: 5

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

                Rectangle {
                    width: 30
                    height: 30
                    radius: 5
                    color: BluetoothStates.enabled ? Theme.green : Theme.red

                    Text {
                        text: BluetoothStates.enabled ? "" : ""
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        id: hoverAreaBluetooth
                        anchors.fill: parent
                        hoverEnabled: true

                        onContainsMouseChanged: {
                            if (hoverAreaBluetooth.containsMouse) {
                                parent.color = Qt.lighter(parent.color, 1.2)
                            } else {
                                parent.color = BluetoothStates.enabled ? Theme.green : Theme.red
                            }
                        }

                        onClicked: {
                            // TODO: add bluetooth connection state and change
                            console.log('TOGGLING BLUETOOTH')
                        }
                    }
                }
            }
            
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

                        ColumnLayout {
                            Text {
                                text: modelData.name
                                color: Theme.foreground
                                font.bold: true
                            }

                            Text {
                                text: modelData.connected 
                                    ? "Connected" 
                                    : "Paired"
                                color: Theme.mutedForeground
                                font.bold: true
                            }
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        Text {
                            text: modelData.batteryAvailable
                            ? modelData.battery * 100 + "%"
                            : ""
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
                                            connectionBox.color = Qt.lighter(parent.color, 1.2)
                                        }
                                        else {
                                            connectionBox.color = Theme.blue
                                        }
                                    }

                                    onClicked: {
                                        console.log('CLICKED')
                                        // TODO: add connection logic
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
                                            forgetBox.color = Qt.lighter(parent.color, 1.3)
                                        }
                                        else {
                                            forgetBox.color = Theme.red
                                        }
                                    }

                                    onClicked: {
                                        // TODO:forget device
                                        console.log("forgetting device")
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
