import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import "."

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData
      color: Theme.background
      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 30

      RowLayout {
        id: leftLayout
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 5

        DashboardWidget {}

        WorkspaceWidget {}

        Media {}

        WindowWidget {}
      }

      RowLayout {
        id: centerLayout
        anchors.centerIn: parent
        anchors.verticalCenter: parent.verticalCenter

        ClockWidget {}
      }

      RowLayout {
        id: rightLayout
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 5

        BluetoothWidget {}

        NetworkWidget {}

        AudioWidget {}

        BatteryWidget {}

        NotificationWidget {}
      }
    }
  }
}
