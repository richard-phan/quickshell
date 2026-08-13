import QtQuick
import QtQuick.Shapes
import Quickshell
import Quickshell.Wayland

PanelWindow {
  id: root

  visible: true

  implicitWidth: mainContent.implicitWidth + (notchWidth * 2)
  implicitHeight: mainContent.implicitHeight

  margins.top: 30

  color: "transparent"

  property bool isWindowVisible

  property real notchWidth: 20
  property real notchHeight: 20

  default property alias windowContent: mainContent.data

  mask: Region {
    item: mainContent

    Region {
      item: leftNotch
    }
    Region {
      item: rightNotch
    }
  }

  exclusionMode: ExclusionMode.Ignore
  WlrLayershell.layer: WlrLayer.Overlay

  Notch {
    id: leftNotch
    mainContent: mainContent
    notchWidth: root.notchWidth
    notchHeight: Math.min(mainContent.y + mainContent.height, 25)

    notchColor: Theme.background

    leftSide: true
  }

  Rectangle {
    id: mainContent
    implicitWidth: 250
    implicitHeight: 100

    bottomLeftRadius: bottomRightRadius
    bottomRightRadius: Math.max(((mainContent.y + mainContent.height) / 100), 0.1) * 20

    color: Theme.background

    x: leftNotch.width
    y: root.isWindowVisible ? 0 : 0 - height
    clip: true

    Behavior on y {
      NumberAnimation {
        duration: 250
        easing.type: Easing.OutQuart
      }
    }
  }
}
