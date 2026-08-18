import QtQuick
import QtQuick.Layouts

import "../../"
import "../../components"

AnimatedPopup {
  id: root

  isWindowVisible: WindowStates.volumeVisible

  notchLeft: true
  notchRight: true

  anchors {
    top: true
    right: true
  }

  RowLayout {
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

          color: Colors.on_primary_container

          MouseArea {
            id: volumeMouseArea
            anchors.fill: parent
            hoverEnabled: true

            drag.target: parent
            drag.axis: y

            onPressed: mouse => {
              const vol = getVolumePercent(mouse.y);
              if (vol)
                AudioService.audio.volume = vol;
            }

            onPositionChanged: mouse => {
              if (mouse.buttons & Qt.LeftButton) {
                const vol = getVolumePercent(mouse.y);
                if (vol)
                  AudioService.audio.volume = vol;
              }
            }

            function getVolumePercent(y) {
              const volPercent = (height - y) / height;
              return volPercent <= 1 && volPercent >= 0 ? volPercent : undefined;
            }
          }
        }

        Rectangle {
          id: volumePercent

          width: 15
          height: (AudioService.volume / 100) * 200
          radius: width / 2

          y: ((100 - AudioService.volume) / 100) * 200

          color: AudioService.muted ? Colors.secondary : Colors.primary_container
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
          color: AudioService.muted ? Colors.red : Colors.red

          anchors.centerIn: parent
        }

        Text {
          text: AudioService.muted ? "" : ""
          color: Colors.background

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
            AudioService.audio.muted = !AudioService.audio.muted;
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
