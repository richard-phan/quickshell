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

  property bool notchLeft
  property bool notchRight

  property color windowColor: Colors.primary

  readonly property Item content: mainContent.children.length > 0 ? mainContent.children[0] : null

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

    interval: 300
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
    notchLeft: root.notchLeft
    notchRight: root.notchRight

    notchColor: root.windowColor
  }

  Rectangle {
    id: mainContent

    property real padding: 40

    implicitWidth: content.width + padding
    implicitHeight: content.height + padding

    bottomLeftRadius: 20
    bottomRightRadius: 20

    color: root.windowColor

    x: root.notchLeft ? root.notchWidth : 0
    y: root.isWindowVisible ? 0 : -height
    clip: true

    Behavior on y {
      NumberAnimation {
        duration: 300
        easing.type: Easing.OutQuart
      }
    }
  }
}
