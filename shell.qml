import QtQuick
import Quickshell

import qs.modules.audio
import qs.modules.backdrop
import qs.modules.battery
import qs.modules.bar
import qs.modules.bluetooth
import qs.modules.dashboard
import qs.modules.launcher
import qs.modules.media
import qs.modules.network
import qs.modules.notifications
import qs.modules.power
import qs.modules.system
import qs.modules.volume
import qs.modules.wallpaper
import qs.modules.window
import qs.modules.workspace

Scope {
  Backdrop {
    id: backdrop
    visible: WindowStates.anyPopupVisible
    onClosePopup: {
      if (WindowStates.dashboardVisible)
        WindowStates.dashboardVisible = false;
      if (WindowStates.bluetoothVisible)
        WindowStates.bluetoothVisible = false;
      if (WindowStates.batteryVisible)
        WindowStates.batteryVisible = false;
      if (WindowStates.volumeVisible)
        WindowStates.volumeVisible = false;
      if (WindowStates.launcherVisible)
        WindowStates.launcherVisible = false;
      if (WindowStates.mediaVisible)
        WindowStates.mediaVisible = false;
      if (WindowStates.wallpaperVisible)
        WindowStates.wallpaperVisible = false;
      if (WindowStates.networkVisible)
        WindowStates.networkVisible = false;
      if (WindowStates.notificationVisible)
        WindowStates.notificationVisible = false;
      if (WindowStates.powerVisible)
        WindowStates.powerVisible = false;
    }
  }

  WallpaperPopup {
    id: wallpaperChanger
  }

  Bar {
    id: bar
  }

  LauncherPopup {
    id: appLauncher
  }

  MediaPopup {}

  MediaToast {}

  BluetoothPopup {}

  BatteryPopup {}

  VolumePopup {}

  NetworkPopup {}

  BatteryPopup {}

  VolumePopup {}

  NotificationPopup {}

  PowerPopup {}
}
