import QtQuick
import Quickshell

PopupWidget {
    implicitWidth: mainContent.implicitWidth
    implicitHeight: mainContent.implicitHeight

    isWindowVisible: true

    anchors {
        top: true
        right: true
    }

    Rectangle {
        id: mainContent

        property var padding: 25

        implicitWidth: contentLayout.implicitWidth + padding
        implicitHeight: contentLayout.implicitHeight + padding

        color: Theme.surface

        Row {
            id: contentLayout
            anchors.centerIn: parent
            spacing: 15

            Column {
                spacing: 5

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
                                console.log(volPercent)
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

                Text {
                    text: "V"
                    color: Theme.foreground
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
