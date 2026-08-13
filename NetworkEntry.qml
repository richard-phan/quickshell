import QtQuick
import QtQuick.Layouts
import Quickshell

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
      color: Theme.foreground
      font.bold: true
    }

    Item {
      Layout.fillWidth: true
    }

    BackgroundButton {
      btnWidth: 30
      btnHeight: btnWidth

      radius: 4

      color: Theme.primary

      btnText: true ? "" : ""
      btnTextPointSize: 16
    }

    BackgroundButton {
      btnWidth: 30
      btnHeight: btnWidth

      radius: 4

      color: Theme.red

      btnText: ""
      btnTextPointSize: 16
    }
  }
}
