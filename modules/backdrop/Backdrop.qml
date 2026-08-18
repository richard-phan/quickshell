import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
  id: root

  required property bool backdropVisible

  signal closePopup

  visible: backdropVisible
  color: "transparent"

  WlrLayershell.layer: WlrLayer.Top
  WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

  exclusiveZone: -1

  anchors {
    top: true
    bottom: true
    left: true
    right: true
  }

  Rectangle {
    anchors.fill: parent
    color: "transparent"

    MouseArea {
      anchors.fill: parent

      onClicked: root.closePopup()
    }
  }
}
