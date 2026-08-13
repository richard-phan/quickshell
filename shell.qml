import QtQuick
import Quickshell

import "."

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
    margins.top: 30
  }

  //    SystemPopup {}

  MediaPopup {}

  BluetoothPopup {}

  BatteryPopup {}

  VolumePopup {}

  RealDashboard {}
  NetworkPopup {}

  BatteryPopup {}

  VolumePopup {}
}
