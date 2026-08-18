pragma Singleton

import QtQuick

QtObject {
  // Popups
  property bool dashboardVisible: false
  property bool bluetoothVisible: false
  property bool batteryVisible: false
  property bool volumeVisible: false
  property bool launcherVisible: false
  property bool mediaVisible: false
  property bool wallpaperVisible: false
  property bool networkVisible: false
  property bool notificationVisible: false
  property bool powerVisible: false

  // OSD
  property bool mediaToastVisible: false

  readonly property bool anyPopupVisible: dashboardVisible || bluetoothVisible || batteryVisible || volumeVisible || launcherVisible || mediaVisible || wallpaperVisible || networkVisible || notificationVisible || powerVisible
}
