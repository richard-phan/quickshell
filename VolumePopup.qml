import QtQuick
import Quickshell

PopupWidget {
    implicitWidth: mainContent.implicitWidth
    implicitHeight: mainContent.implicitHeight

    isWindowVisible: WindowStates.volumeVisible

    anchors {
        top: true
        right: true
    }

    margins.top: 30

    Rectangle {
        id: mainContent

        property var padding: 25

        implicitWidth: contentLayout.implicitWidth + padding
        implicitHeight: contentLayout.implicitHeight + padding

        color: Theme.surface

        Row {
            id: contentLayout
            anchors.centerIn: parent
            spacing: 12

            Column {
                // FIX: Convert these to single vertical element
                spacing: 10

                Item {
                    width: volumeMax.width
                    height: volumeMax.height

                    Rectangle {
                        id: volumeMax
                        width: 15
                        height: 200
                        radius: width / 2
                        
                        color: Theme.elevated

                        MouseArea {
                            id: volumeMouseArea
                            anchors.fill: parent
                            hoverEnabled: true

                            drag.target: parent
                            drag.axis: y
                            
                            onPressed: (mouse) => {
                                const vol = getVolumePercent(mouse.y)
                                if (vol) Audio.audio.volume = vol
                            }
                            
                            onPositionChanged: (mouse) => {
                                if (mouse.buttons & Qt.LeftButton) {
                                    const vol = getVolumePercent(mouse.y)
                                    if (vol) Audio.audio.volume = vol
                                }
                            }

                            function getVolumePercent(y) {
                                const volPercent = (height - y) / height
                                return volPercent <= 1 && volPercent >= 0 
                                    ? volPercent 
                                    : undefined
                            }
                        }
                    }

                    Rectangle {
                        id: volumePercent

                        width: 15
                        height: (Audio.volume / 100) * 200
                        radius: width / 2

                        y: ((100 - Audio.volume) / 100) * 200

                        color: Audio.muted
                            ? Theme.foreground
                            : Theme.primary
                        
                    }
                }

                Item {
                    width: muteButton.width
                    height: muteButton.height
                    // FIX: align center

                    Rectangle {
                        id: muteButton
                        width: 20
                        height: 20
                        radius: 4
                        color: Audio.muted ? Theme.red : Theme.red

                        anchors.centerIn: parent
                    }

                    Text {
                        text: Audio.muted ? "" : ""
                        color: Theme.background

                        anchors.centerIn: parent
                    }

                    MouseArea {
                        id: muteMouseArea
                        anchors.fill: parent
                        hoverEnabled: true

                        onContainsMouseChanged: {
                            if (muteMouseArea.containsMouse) {
                                // TODO add mouse hover
                            }
                        }

                        onClicked: {
                            Audio.audio.muted = !Audio.audio.muted
                        }
                    }
                }
            }
            
            Column {
                spacing: 5

                Rectangle {
                    width: 15
                    height: 200
                    radius: width / 2
                }

                Text {
                    text: "M"
                    color: "white"
                }
            }
        }
    }
}
