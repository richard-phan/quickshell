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
    }

    Item {
      Layout.fillWidth: true
    }

    BackgroundButton {
      btnWidth: 30
      btnHeight: btnWidth

      radius: 5

      color: Theme.primary

      btnText: "C"
    }

    BackgroundButton {
      btnWidth: 30
      btnHeight: btnWidth

      radius: 4

      color: Theme.mutedForeground
    }
  }
}
