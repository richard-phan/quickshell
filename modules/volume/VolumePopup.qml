import QtQuick
import QtQuick.Layouts

import "."
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

    ColumnLayout {
      id: speakerColumn

      spacing: 10

      VolumeSlider {
        Layout.preferredWidth: 15
        Layout.preferredHeight: 200

        Layout.alignment: Qt.AlignHCenter

        from: 0
        to: 100

        bgColor: Colors.on_primary_container
        progressColor: AudioService.muted ? Colors.inverse_primary : Colors.on_primary

        value: AudioService.volume

        orientation: Qt.Vertical

        onMoved: AudioService.setVolume(value / 100)
      }

      BackgroundButton {
        btnWidth: 25
        btnHeight: 25

        radius: 4

        color: hoverHandler.hovered ? Colors.primary : "transparent"

        btnText: AudioService.muted ? "" : ""
        btnTextColor: hoverHandler.hovered ? Colors.on_primary : Colors.primary

        Layout.alignment: Qt.AlignHCenter

        tapHandler.onTapped: AudioService.setMuted(!AudioService.muted)
      }
    }
  }
}
