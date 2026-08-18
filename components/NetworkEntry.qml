import QtQuick
import QtQuick.Layouts
import Quickshell

import "../"

Rectangle {
  width: entryWidth
  height: entryHeight

  color: entryColor

  property int entryWidth
  property int entryHeight
  property int entryPadding
  property color entryColor

  property string networkName

  RowLayout {
    width: parent.width - entryPadding
    anchors.centerIn: parent

    Text {
      text: networkName
      color: Colors.on_primary_container
      font.bold: true
    }

    Item {
      Layout.fillWidth: true
    }

    BackgroundButton {
      btnWidth: 30
      btnHeight: btnWidth

      radius: 4

      color: Colors.on_primary_container

      btnText: true ? "" : ""
      btnTextPointSize: 16
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
