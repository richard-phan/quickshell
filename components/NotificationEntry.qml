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
  property bool expanded: false

  signal closeDelayTriggered()

  Behavior on height {
    NumberAnimation {
      duration: 100
      easing.type: Easing.OutCubic
    }
  }

  Behavior on opacity {
    NumberAnimation {
      duration: 50
      easing.type: Easing.OutCubic
    }
  }


  ColumnLayout {
    id: contentLayout

    width: entryWidth - root.notificationPadding

    anchors.centerIn: parent

    spacing: 3

    RowLayout {

      width: contentLayout.width - root.notificationPadding

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

          btnText: ""
          // FIX: change this to be a property
          btnTextColor: "black"

          tapHandler.onTapped: {
            root.height = 0
            root.opacity = 0
            closeDelay.running =  true
          }
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

  Timer {
    id: closeDelay

    running: false
    interval: 100

    onTriggered: root.onCloseDelayTriggered()
  }
}
