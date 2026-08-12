import QtQuick
import Quickshell

import "."

Scope {
    Backdrop {
        id: backdrop
        visible: WindowStates.anyPopupVisible
        onClosePopup: {
            if (WindowStates.dashboardVisible)
                WindowStates.dashboardVisible = false
            if (WindowStates.bluetoothVisible)
                WindowStates.bluetoothVisible = false
            if (WindowStates.batteryVisible)
                WindowStates.batteryVisible = false
            if (WindowStates.volumeVisible)
                WindowStates.volumeVisible = false
            if (WindowStates.launcherVisible)
                WindowStates.launcherVisible = false
        }
    }

    Bar {
        id: bar
    }

    LauncherPopup {
        id: appLauncher
        margins.top: 30
    }

//    SystemPopup {}

    BluetoothPopup {}

    BatteryPopup {}

    VolumePopup {}
}
