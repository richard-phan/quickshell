import QtQuick
import Quickshell

Rectangle {
  id: background
  width: btnWidth
  height: btnHeight

  property int btnWidth
  property int btnHeight

  property string btnText
  property color btnTextColor
  property int btnTextPointSize
  property alias hoverHandler: internalHoverHandler
  property alias tapHandler: internalTapHandler

  Behavior on color {
    ColorAnimation {
      duration: 200
      easing.type: Easing.Linear
    }
  }

  Behavior on btnTextColor {
    ColorAnimation {
      duration: 200
      easing.type: Easing.Linear
    }
  }

  Text {
    id: icon

    text: btnText
    color: btnTextColor
    font.pointSize: btnTextPointSize

    anchors.centerIn: parent
  }

  HoverHandler {
    id: internalHoverHandler

    enabled: true
    cursorShape: Qt.PointingHandCursor
    target: parent
  }

  TapHandler {
    id: internalTapHandler

    gesturePolicy: TapHandler.WithinBounds
  }
}
