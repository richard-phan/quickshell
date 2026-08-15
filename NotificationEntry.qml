import QtQuick
import QtQuick.Layouts
import Quickshell

Rectangle {
  id: root

  width: entryWidth
  height: entryHeight
  color: entryColor

  property real entryWidth
  property real entryHeight
  property color entryColor

  property string notificationTitle
  property string notificationDesc
  property TapHandler closeBtnTapHandler: closeButton.tapHandler

  Column {
    anchors.centerIn: parent
    width: entryWidth - 25

    spacing: 3

    RowLayout {
      width: parent.width

      Text {
        text: root.notificationTitle
        font.pointSize: 11
        font.bold: true
        elide: Text.ElideRight
        color: "black"
      }

      Item {
        Layout.fillWidth: true
      }

      BackgroundButton {
        id: closeButton

        btnWidth: 20
        btnHeight: 20
        radius: 4

        btnText: "X"
        // FIX: change this to be a property
        btnTextColor: "black"
      }
    }

    Text {
      text: root.notificationDesc
      font.pointSize: 9
      elide: Text.ElideRight
      color: "black"
    }
  }
}
