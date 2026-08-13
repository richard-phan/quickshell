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

  // left or ride side
  property bool leftSide

  preferredRendererType: Shape.CurveRenderer

  ShapePath {
    fillColor: triangle.notchColor
    strokeWidth: 0

    // away from shape
    startX: leftSide ? 0 : mainContent.width + (triangle.notchWidth * 2)
    startY: 0

    // next to shape top
    PathLine {
      x: leftSide ? triangle.notchWidth : mainContent.width + triangle.notchWidth
      y: 0
    }

    PathLine {
      x: leftSide ? triangle.notchWidth : mainContent.width + triangle.notchWidth
      y: leftSide ? triangle.notchHeight : triangle.notchHeight
    }

    PathArc {
      x: leftSide ? 0 : mainContent.width + (triangle.notchWidth * 2)
      y: 0
      radiusX: triangle.width
      radiusY: triangle.height
      useLargeArc: false
      direction: leftSide ? PathArc.Counterclockwise : PathArc.Clockwise
    }
  }
}
