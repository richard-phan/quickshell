import QtQuick
import QtQuick.Layouts

import "../"

// color shouldnt be here

Rectangle {
  id: background
  implicitWidth: content.implicitWidth + (2 * horizontalPadding)
  implicitHeight: content.implicitHeight
  color: hoverHandler.hovered && hoverEnabled ? Colors.inverse_primary : bgColor
  radius: 4

  property int minWidth: 5
  property int horizontalPadding: 5
  property color bgColor
  property string icon
  property int iconSize: 12

  property string text
  property color textColor
  property bool hoverEnabled: true

  property alias tapHandler: internalTapHandler
  property alias hoverHandler: internalHoverHandler

  RowLayout {
    id: content
    spacing: icon && text ? 5 : 0
    anchors.centerIn: parent

    Text {
      text: background.icon
      color: background.textColor
      font.family: "JetBrainsMono Nerd Font"
      font.pointSize: background.iconSize
      Layout.alignment: Qt.AlignVCenter
      font.bold: true
    }

    Text {
      text: background.text
      color: background.textColor
      Layout.alignment: Qt.AlignVCenter
      font.family: "Inter"
      font.bold: true
    }
  }

  HoverHandler {
    id: internalHoverHandler
    cursorShape: Qt.PointingHandCursor
  }

  TapHandler {
    id: internalTapHandler
  }
}
