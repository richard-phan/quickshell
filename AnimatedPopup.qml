import QtQuick
import QtQuick.Shapes
import Quickshell
import Quickshell.Wayland

PanelWindow {
  id: root

  visible: animationTimer.running || isWindowVisible

  implicitWidth: mainContent.implicitWidth + (notchWidth * 2)
  implicitHeight: mainContent.implicitHeight

  margins.top: 30

  color: "transparent"

  property bool isWindowVisible

  property real notchWidth: 20
  property real notchHeight: 20
  property color windowColor: Theme.background

  default property alias windowContent: mainContent.data

  mask: Region {
    item: mainContent

    Region {
      item: notch
    }
  }

  exclusionMode: ExclusionMode.Ignore
  WlrLayershell.layer: WlrLayer.Overlay

  Timer {
    id: animationTimer
    running: false

    interval: 250
  }

  onIsWindowVisibleChanged: {
    if (!isWindowVisible)
      animationTimer.running = true;
  }

  Notch {
    id: notch
    mainContent: mainContent
    notchWidth: root.notchWidth
    notchHeight: Math.min(mainContent.y + mainContent.height, root.notchHeight)

    notchColor: root.windowColor
  }

  Rectangle {
    id: mainContent
    implicitWidth: 250
    implicitHeight: 100

    bottomLeftRadius: bottomRightRadius
    bottomRightRadius: 20

    color: root.windowColor

    x: notch.width
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
