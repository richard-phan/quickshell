import QtQuick
import QtQuick.Layouts
import Quickshell

AnimatedPopup {
  id: root

  isWindowVisible: !WindowStates.notificationVisible

  notchLeft: true
  notchRight: true

  anchors {
    top: true
    right: true
  }

  ColumnLayout {
    id: contentLayout

    width: 300

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 20

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
      width: contentLayout.width
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
          spacing: 2

          readonly property string appName: modelData

          Behavior on height {
            NumberAnimation {
              duration: 100
              easing.type: Easing.Linear
            }
          }

          NotificationEntry {
            entryWidth: contentLayout.width
            entryHeight: 35
            topLeftRadius: 10
            topRightRadius: 10

            entryColor: Colors.on_primary_container

            notificationDesc: appName
            notificationPadding: 25

            closeBtnTapHandler.onTapped: NotificationService.removeAppNotifications(modelData)
          }

          Repeater {
            id: notificationAppContent

            model: NotificationService.notificationsByApp.get(modelData)

            delegate: NotificationEntry {
              entryWidth: contentLayout.width
              entryHeight: 50

              Behavior on height {
                NumberAnimation {
                  duration: 100
                  easing.type: Easing.Linear
                }
              }

              bottomLeftRadius: {
                const count = NotificationService.notificationsByApp.get(appName).length;
                return index == count - 1 ? 10 : 0;
              }

              bottomRightRadius: {
                const count = NotificationService.notificationsByApp.get(appName).length;
                return index == count - 1 ? 10 : 0;
              }

              entryColor: Colors.on_primary_container

              notificationDesc: modelData.summary
              notificationPadding: 25

              closeBtnTapHandler.onTapped: NotificationService.removeNotification(modelData, index)
            }
          }
        }
      }
    }
  }
}
