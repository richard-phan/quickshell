import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell

AnimatedPopup {
  id: root

  isWindowVisible: WindowStates.notificationVisible

  expectedMaxHeight: 380

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

    ScrollView {
      id: notificationScrollView

      width: parent.width
      Layout.preferredHeight: notifications.implicitHeight >= 300 ? 300 : notifications.implicitHeight

      contentWidth: availableWidth
      contentHeight: notifications.implicitHeight

      clip: true

      Binding {
        target: notificationScrollView.contentItem
        property: "boundsBehavior"
        value: Flickable.StopAtBounds
      }

      ColumnLayout {
        id: notifications

        width: parent ? parent.width : 300

        spacing: 10

        Rectangle {
          Layout.fillWidth: true
          Layout.preferredHeight: visible ? 50 : 0

          Layout.alignment: Qt.AlignHCenter

          color: Colors.on_primary_container
          radius: 10

          visible: NotificationService.count == 0

          Text {
            text: "No notifications"
            font.bold: true

            color: "black"

            anchors.centerIn: parent
          }
        }

        Repeater {
          id: notificationApp

          model: [...NotificationService.notificationsByApp.keys()]

          delegate: Column {
            width: parent ? parent.width : 0
            spacing: 2

            readonly property string appName: modelData
            property bool collapsed: false

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
              notificationPadding: 5

              closeBtnTapHandler.onTapped: NotificationService.removeAppNotifications(modelData)
            }

            Repeater {
              id: notificationAppContent

              model: NotificationService.notificationsByApp.get(modelData)

              delegate: NotificationEntry {
                entryWidth: contentLayout.width
                entryHeight: 50

                visible: notificationApp.collapsed

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
}
