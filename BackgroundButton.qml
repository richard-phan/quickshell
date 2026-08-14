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
  }
}
