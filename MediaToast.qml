import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

AnimatedPopup {
  id: root

  isWindowVisible: WindowStates.mediaToastVisible

  notchLeft: true
  notchRight: true

  anchors.top: true

  Connections {
    target: MediaService

    function onTrackTitleChanged() {
      WindowStates.mediaToastVisible = true;
      hideDelay.running = true;
      hideDelay.restart();
    }
  }

  RowLayout {
    anchors.centerIn: parent
    width: 300

    spacing: 20

    ClippingWrapperRectangle {
      width: 50
      height: 50
      radius: 5

      Image {
        sourceSize.width: 50
        sourceSize.height: 50

        source: MediaService.activePlayer.trackArtUrl
      }
    }

    ColumnLayout {
      id: contentLayout
      spacing: 2

      Text {
        Layout.fillWidth: true

        text: MediaService.activePlayer.trackTitle
        elide: Text.ElideRight

        font.pointSize: 12
        font.bold: true

        color: Colors.on_primary
      }

      Text {
        Layout.fillWidth: true

        text: MediaService.activePlayer.trackArtist
        elide: Text.ElideRight

        font.pointSize: 10

        color: Colors.inverse_Primary
      }
    }
  }

  Timer {
    id: hideDelay
    running: false
    interval: 5000

    onTriggered: WindowStates.mediaToastVisible = false
  }
}
