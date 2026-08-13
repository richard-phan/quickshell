import QtQuick
import QtQuick.Shapes
import Quickshell
import Quickshell.Wayland

PanelWindow {
  implicitWidth: mainContent.implicitWidth + leftNotch.width + rightNotch.width
  implicitHeight: mainContent.implicitHeight

  anchors.top: true
  margins.top: 30

  color: "transparent"

  property bool isWindowVisible

  property int notchWidth: 20
  property int notchHeight: 20

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

  Rectangle {
    id: mainContent
    implicitWidth: 250
    implicitHeight: 100

    bottomLeftRadius: 20
    bottomRightRadius: 20

    x: curvedTriangle.width
    y: 0

    anchors.centerIn: parent

    color: Theme.background
  }

  Notch {
    id: leftNotch
    mainContent: mainContent
    notchWidth: 20
    notchHeight: 20

    notchColor: Theme.background

    leftSide: true
  }

  Notch {
    id: rightNotch
    mainContent: mainContent
    notchWidth: 20
    notchHeight: 20

    notchColor: Theme.background

    leftSide: false
  }
}
