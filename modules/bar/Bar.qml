import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import "../../"
import "../../components"
import "../audio"
import "../battery"
import "../bluetooth"
import "../dashboard"
import "../launcher"
import "../media"
import "../network"
import "../notifications"
import "../power"
import "../system"
import "../volume"
import "../wallpaper"
import "../window"
import "../workspace"

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      color: Colors.surface_bright

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

        MediaWidget {}

        // WindowWidget {}
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

        PowerWidget {}
      }
    }
  }
}
