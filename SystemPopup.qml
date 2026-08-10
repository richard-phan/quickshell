import "."

import QtQuick
import QtQuick.Layouts
import Quickshell

PanelWindow {
    id: systemInfoWindow
    visible: !WindowStates.dashboardVisible
    anchors { top: true; left: true }

    implicitWidth: 300
    implicitHeight: 220

    Rectangle {
        anchors.fill: parent
        color: Theme.surface
        bottomRightRadius: 15

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10

            Text {
                text: "󰞱   System Overview"
                color: Theme.foreground
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                font.bold: true
            }

            Repeater {
                model: ListModel {
                    ListElement { title: "CPU"; icon: ""; value: 12; color: "Theme.green" }
                    ListElement { title: "Memory"; icon: ""; value: 34; color: "Theme.blue" }
                    ListElement { title: "Storage"; icon: ""; value: 56; color: "Theme.purple" }
                }

                delegate: Rectangle {
                    Layout.fillWidth: true
                    height: 50
                    color: Theme.surface

                    Row {
                        anchors.fill: parent
                        spacing: 10

                        Item {
                            width: 40
                            height: 40
                            anchors.verticalCenter: parent.verticalCenter

                            Rectangle {
                                anchors.fill: parent
                                radius: 10
                                color: Theme.elevated

                            }

                            Text {
                                text: model.icon
                                anchors.centerIn: parent
                                color: Theme.blue
                                font.pointSize: 16
                            }
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 7

                            Text {
                                text: model.title
                                color: Theme.foreground
                                font.bold: true
                            }
                            
                            Item {
                                id: fullBar
                                width: 180
                                height: 10

                                Rectangle {
                                    anchors.fill: parent
                                    radius: height / 2
                                    color: Theme.elevated
                                }

                                Rectangle {
                                    id: progressBar
                                    width: model.value / 100
                                    height: parent.height
                                    radius: height / 2
                                    color: Theme.blue
                                }
                            }
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter

                            Text {
                                text: model.value + "%"
                                color: Theme.blue
                            }

                            Text {
                                text: model.value + "%"
                                color: Theme.foreground
                            }
                        }
                    }
                }
            }
        }
    }
}
