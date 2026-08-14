import QtQuick
import QtQuick.Shapes
import Quickshell

Shape {
  id: triangle

  width: notchWidth
  height: notchHeight

  property Rectangle mainContent
  property int notchWidth
  property int notchHeight

  property color notchColor

  preferredRendererType: Shape.CurveRenderer

  ShapePath {
    fillColor: triangle.notchColor
    strokeWidth: 0

    // away from shape
    startX: 0
    startY: 0

    // next to shape top
    PathLine {
      x: triangle.notchWidth
      y: 0
    }

    PathLine {
      x: triangle.notchWidth
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
    fillColor: triangle.notchColor
    strokeWidth: 0

    // away from shape
    startX: mainContent.width + (triangle.notchWidth * 2)
    startY: 0

    // next to shape top
    PathLine {
      x: mainContent.width + triangle.notchWidth
      y: 0
    }

    PathLine {
      x: mainContent.width + triangle.notchWidth
      y: triangle.notchHeight
    }

    PathArc {
      x: mainContent.width + (triangle.notchWidth * 2)
      y: 0
      radiusX: triangle.width
      radiusY: triangle.height
      useLargeArc: false
      direction: PathArc.Clockwise
    }
  }
}
