import QtQuick
import QtQuick.Layouts
import Quickshell

AnimatedPopup {
  id: root

  isWindowVisible: WindowStates.notificationVisible

  notchLeft: true
  notchRight: true

  anchors {
    top: true
    right: true
  }

  ColumnLayout {
    id: contentLayout

    width: 250

    anchors.centerIn: parent

    spacing: 15

    RowLayout {
      width: parent.width

      Text {
        text: "Notifications"
        font.bold: true
        color: Colors.on_primary
      }

      Item {
        Layout.fillWidth: true
      }

      BackgroundButton {
        btnWidth: 60
        btnHeight: 25

        radius: 5

        color: hoverHandler.hovered ? Colors.inverse_primary : "transparent"

        btnText: "Clear all"
        btnTextColor: hoverHandler.hovered ? Colors.primary : Colors.on_primary

        tapHandler.onTapped: NotificationService.clearAll()
      }
    }

    ColumnLayout {
      id: notifications
      width: 250
      spacing: 10

      Rectangle {
        width: parent.width
        height: 50
        color: Colors.on_primary_container
        radius: 10

        visible: NotificationService.count == 0

        Text {
          text: "No notifications"
          color: "black"
          anchors.centerIn: parent
          font.bold: true
        }
      }

      Repeater {
        id: notificationApp
        model: [...NotificationService.notificationsByApp.keys()]

        delegate: Column {
          spacing: 0

          NotificationEntry {
            entryWidth: 250
            entryHeight: 50
            topLeftRadius: 10
            topRightRadius: 10

            entryColor: Colors.on_primary_container

            notificationDesc: modelData

            closeBtnTapHandler.onTapped: NotificationService.removeAppNotifications(modelData)
          }

          Repeater {
            id: notificationAppContent

            model: NotificationService.notificationsByApp.get(modelData)

            delegate: NotificationEntry {
              entryWidth: 250
              entryHeight: 50
              entryColor: Colors.on_primary_container

              notificationDesc: modelData.summary

              closeBtnTapHandler.onTapped: NotificationService.removeNotification(modelData, index)
            }
          }
        }
      }
    }
  }
}
