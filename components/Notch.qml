import QtQuick
import QtQuick.Shapes
import Quickshell

Shape {
  id: triangle

  width: notchWidth
  height: notchHeight

  property Rectangle mainContent
  property int notchWidth: 20
  property int notchHeight: 20
  property bool notchLeft: true
  property bool notchRight: true

  property color notchColor

  readonly property real leftWidth: notchLeft ? notchWidth : 0
  readonly property real rightWidth: notchRight ? notchWidth : 0

  preferredRendererType: Shape.CurveRenderer

  ShapePath {
    fillColor: notchLeft ? notchColor : "transparent"
    strokeWidth: 0

    // away from shape
    startX: 0
    startY: 0

    // next to shape top
    PathLine {
      x: triangle.leftWidth
      y: 0
    }

    PathLine {
      x: triangle.leftWidth
      y: triangle.notchHeight
    }

    PathArc {
      x: 0
      y: 0
      radiusX: triangle.width
      radiusY: triangle.height
      useLargeArc: false
      direction: PathArc.Counterclockwise
    }
  }

  Rectangle {
    x: triangle.notchWidth
    y: 0
    width: mainContent.width
    height: mainContent.height + mainContent.y

    bottomLeftRadius: 20
    bottomRightRadius: 20

    color: triangle.notchColor
  }

  ShapePath {
    fillColor: notchRight ? notchColor : "transparent"
    strokeWidth: 0

    // away from shape
    startX: mainContent.width + (triangle.rightWidth * 2)
    startY: 0

    // next to shape top
    PathLine {
      x: mainContent.width + triangle.rightWidth
      y: 0
    }

    PathLine {
      x: mainContent.width + triangle.rightWidth
      y: triangle.notchHeight
    }

    PathArc {
      x: mainContent.width + (triangle.rightWidth * 2)
      y: 0
      radiusX: triangle.width
      radiusY: triangle.height
      useLargeArc: false
      direction: PathArc.Clockwise
    }
  }
}
