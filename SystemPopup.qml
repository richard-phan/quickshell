import "."

import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell

PanelWindow {
    id: systemInfoWindow

    visible: true

    anchors {
        top: true
        left: true
    }

    // Bar height + dashboard height
    implicitWidth: 350
    implicitHeight: barHeight + dashboardHeight

    color: "transparent"

    property int barHeight: 30
    property int dashboardHeight: 250

    exclusionMode: ExclusionMode.Ignore

    mask: Region {
        item: WindowStates.dashboardVisible ? slidingRect : null
    }

    Rectangle {
        id: slidingRect

        width: systemInfoWindow.implicitWidth
        height: systemInfoWindow.dashboardHeight

        y: WindowStates.dashboardVisible
           ? systemInfoWindow.barHeight
           : systemInfoWindow.barHeight - height

        color: Theme.surface

        bottomRightRadius: 10
        clip: true

        Behavior on y {
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutQuart
            }
        }

        Column {
            x: 10
            y: 10

            width: slidingRect.width - 20
            spacing: 15

            Text {
                text: "System Overview"
                color: Theme.foreground
                font.bold: true
            }

            Connections {
                target: System

                function onDataChanged() {
                    infoTable.model.setProperty(0, "value", System.cpu)
                    infoTable.model.setProperty(1, "value", System.memory)
                    infoTable.model.setProperty(2, "value", System.storage)
                }
            }

            Repeater {
                id: infoTable

                model: ListModel {
                    ListElement {
                        title: "CPU"
                        icon: ""
                        value: 0
                        color: "green"
                    }

                    ListElement {
                        title: "Memory"
                        icon: ""
                        value: 0
                        color: "blue"
                    }

                    ListElement {
                        title: "Storage"
                        icon: ""
                        value: 0
                        color: "purple"
                    }
                }

                delegate: Item {
                    width: slidingRect.width - 20
                    height: 50

                    Row {
                        anchors.fill: parent
                        spacing: 10

                        Rectangle {
                            width: 40
                            height: 40
                            radius: 10

                            anchors.verticalCenter: parent.verticalCenter

                            color: Theme.elevated

                            Text {
                                text: model.icon
                                anchors.centerIn: parent
                                color: Theme[model.color]
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
                                width: slidingRect.width - 120
                                height: 10

                                Rectangle {
                                    anchors.fill: parent
                                    radius: height / 2
                                    color: Theme.elevated
                                }

                                Rectangle {
                                    width: parent.width * (model.value / 100)
                                    height: parent.height
                                    radius: height / 2
                                    color: Theme[model.color]
                                }
                            }
                        }

                        Item {
                            width: 40
                            height: parent.height

                            Text {
                                anchors.centerIn: parent
                                text: model.value + "%"
                                color: Theme.foreground
                                font.bold: true
                            }
                        }
                    }
                }
            }
        }
    }
}
