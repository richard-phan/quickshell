pragma Singleton

import QtQuick

QtObject {
  property bool dashboardVisible: false
  property bool bluetoothVisible: false
  property bool batteryVisible: false
  property bool volumeVisible: false
  property bool launcherVisible: false
  property bool mediaVisible: false
  property bool wallpaperVisible: false
  property bool networkVisible: false

  readonly property bool anyPopupVisible: dashboardVisible || bluetoothVisible || batteryVisible || volumeVisible || launcherVisible || mediaVisible || wallpaperVisible || networkVisible
}
