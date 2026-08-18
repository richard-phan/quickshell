import QtQuick
import QtQuick.Shapes
import Quickshell
import Quickshell.Wayland

import "../"

PanelWindow {
  id: root

  visible: animationTimer.running || isWindowVisible

  implicitWidth: mainContent.implicitWidth + (notchWidth * 2)
  implicitHeight: expectedMaxHeight

  margins.top: 30

  color: "transparent"

  property bool isWindowVisible

  // BUG: need to update these to preffered heights to prevent flickering on initial boot or resizes
  // all resizing windows need to be extended with a max height
  property real expectedMaxHeight: mainContent.implicitHeight

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

    opacity: root.isWindowVisible ? 1 : 0

    x: root.notchLeft ? root.notchWidth : 0
    y: root.isWindowVisible ? 0 : -height
    clip: true

    Behavior on opacity {
      NumberAnimation {
        duration: 600
        easing.type: Easing.OutCubic
      }
    }

    Behavior on y {
      NumberAnimation {
        duration: 300
        easing.type: Easing.OutCubic
      }
    }

    Behavior on implicitHeight {
      NumberAnimation {
        duration: 50
        easing.type: Easing.OutQuart
      }
    }
  }
}
