import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

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

    spacing: 10

    ClippingWrapperRectangle {
      width: 150
      height: 150
      radius: 20
      color: Theme.elevated

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

          color: Theme.foreground
        }

        Text {
          id: trackArtist

          width: parent.width

          text: MediaService.activePlayer.trackArtist
          color: Theme.foreground
          font.pointSize: 9
          elide: Text.ElideRight
        }

        Text {
          id: trackAlbum

          width: parent.width

          text: MediaService.activePlayer.trackAlbum
          color: Theme.foreground
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
            color: Theme.elevated
          }

          Rectangle {
            id: progressBarPercent
            width: MediaService.durationPercent * progressBarMax.width
            height: parent.height
            radius: height / 2
            color: Theme.primary
          }
        }

        RowLayout {
          width: rightLayout.width
          height: 1

          Text {
            text: MediaService.position
            color: Theme.foreground
            Layout.alignment: Qt.AlignLeft
          }

          Item {
            Layout.fillWidth: true
          }

          Text {
            text: MediaService.duration
            color: Theme.foreground
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
          icon.color: Theme.foreground

          tapHandler.onTapped: MediaService.activePlayer.previous()
        }

        Button {
          btnWidth: 20
          btnHeight: btnWidth
          btnColor: "transparent"

          icon.text: MediaService.isPlaying ? "" : ""
          icon.font.pointSize: 20
          icon.color: Theme.foreground

          tapHandler.onTapped: MediaService.activePlayer.togglePlaying()
        }

        Button {
          btnWidth: 20
          btnHeight: btnWidth
          btnColor: "transparent"

          icon.text: ""
          icon.font.pointSize: 20
          icon.color: Theme.foreground

          tapHandler.onTapped: MediaService.activePlayer.next()
        }

        Item {
          Layout.fillWidth: true
        }
      }
    }
  }
}
