import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

import "../../components"

AnimatedPopup {
  id: root

  isWindowVisible: WindowStates.mediaVisible

  notchLeft: true
  notchRight: true

  anchors {
    top: true
  }

  RowLayout {
    id: contentLayout

    anchors.centerIn: parent

    spacing: 20

    ClippingWrapperRectangle {
      width: 150
      height: 150
      radius: 20
      color: Colors.on_surface_variant

      Image {
        id: albumArt
        sourceSize.width: 150
        sourceSize.height: 150
        source: MediaService.activePlayer.trackArtUrl
      }
    }

    ColumnLayout {
      id: rightLayout

      width: 300
      spacing: 15

      Column {
        id: trackInfo

        width: rightLayout.width
        spacing: 2

        Text {
          id: trackTitle

          width: parent.width

          text: MediaService.activePlayer.trackTitle
          font.pointSize: 18
          font.bold: true
          elide: Text.ElideRight

          color: Colors.on_primary
        }

        Text {
          id: trackArtist

          width: parent.width

          text: MediaService.activePlayer.trackArtist
          color: Colors.on_primary
          font.pointSize: 9
          elide: Text.ElideRight
        }

        Text {
          id: trackAlbum

          width: parent.width

          text: MediaService.activePlayer.trackAlbum
          color: Colors.on_primary
          font.pointSize: 9
          elide: Text.ElideRight
        }
      }

      Column {
        id: trackProgress

        width: parent.width
        spacing: 5

        Item {
          width: parent.width
          height: 4

          Rectangle {
            id: progressBarMax

            anchors.fill: parent
            radius: height / 2
            color: Colors.primary_container
          }

          Rectangle {
            id: progressBarPercent
            width: MediaService.durationPercent * progressBarMax.width
            height: parent.height
            radius: height / 2
            color: Colors.on_primary_container
          }
        }

        RowLayout {
          width: rightLayout.width
          height: 1

          Text {
            text: MediaService.position
            color: Colors.on_primary
            Layout.alignment: Qt.AlignLeft
          }

          Item {
            Layout.fillWidth: true
          }

          Text {
            text: MediaService.duration
            color: Colors.on_primary
            Layout.alignment: Qt.AlignRight
          }
        }
      }

      RowLayout {
        width: parent.width
        spacing: 15

        Item {
          Layout.fillWidth: true
        }

        Button {
          btnWidth: 20
          btnHeight: btnWidth
          btnColor: "transparent"

          icon.text: ""
          icon.font.pointSize: 20
          icon.color: Colors.on_primary

          tapHandler.onTapped: MediaService.activePlayer.previous()
        }

        Button {
          btnWidth: 20
          btnHeight: btnWidth
          btnColor: "transparent"

          icon.text: MediaService.isPlaying ? "" : ""
          icon.font.pointSize: 20
          icon.color: Colors.on_primary

          tapHandler.onTapped: MediaService.activePlayer.togglePlaying()
        }

        Button {
          btnWidth: 20
          btnHeight: btnWidth
          btnColor: "transparent"

          icon.text: ""
          icon.font.pointSize: 20
          icon.color: Colors.on_primary

          tapHandler.onTapped: MediaService.activePlayer.next()
        }

        Item {
          Layout.fillWidth: true
        }
      }
    }
  }
}
