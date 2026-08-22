import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Networking

import "../../"
import "../../components"

Rectangle {
  width: entryWidth
  height: entryHeight

  color: entryColor

  property int entryWidth
  property int entryHeight
  property int entryPadding
  property color entryColor
  property color textColor

  property Network network

  RowLayout {
    width: parent.width - entryPadding
    anchors.centerIn: parent

    Text {
      text: network.name
      color: textColor
      font.bold: true
    }

    Item {
      Layout.fillWidth: true
    }

    BackgroundButton {
      btnWidth: 30
      btnHeight: btnWidth

      radius: 4

      color: Colors.tertiary

      btnText: network.connected ? "" : ""
      btnTextPointSize: 16

      tapHandler.onTapped: network.connect()
    }

    BackgroundButton {
      btnWidth: 30
      btnHeight: btnWidth

      radius: 4

      color: Colors.error

      btnText: ""
      btnTextPointSize: 16
    }
  }
}
