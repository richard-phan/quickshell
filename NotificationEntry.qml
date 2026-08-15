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

  property string notificationDesc
  property real notificationPadding
  property TapHandler closeBtnTapHandler: closeButton.tapHandler
  property bool expanded: false

  Column {
    id: contentLayout

    anchors.centerIn: parent
    width: entryWidth - notificationPadding

    spacing: 3

    RowLayout {
      width: contentLayout.width

      Text {
        id: notificationContent
        Layout.fillWidth: true
        text: root.notificationDesc
        font.pointSize: 9
        elide: Text.ElideRight
        color: "black"
      }

      Item {
        Layout.fillWidth: true
      }

      RowLayout {
        Layout.alignment: Qt.AlignRight | Qt.AlignTop
        Text {
          id: expandedIcon
          text: {
            if (notificationContent.truncated)
              return "";
            else if (root.expanded)
              return "";
          }
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
    }
  }

  TapHandler {
    id: notificationTapHandler

    property bool expandable: notificationContent.truncated || root.expanded == true

    onTapped: {
      if (!expandable)
        return;
      root.expanded = !root.expanded;

      if (root.expanded) {
        notificationContent.wrapMode = Text.Wrap;

        root.height = Math.max(root.entryHeight, notificationContent.implicitHeight + root.notificationPadding);
      } else {
        notificationContent.wrapMode = false;

        root.height = root.entryHeight;
      }
    }
  }
}
