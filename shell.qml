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
        }
    }

    SystemPopup {}

    BluetoothPopup {}

    BatteryPopup {}

    VolumePopup {}

    Bar {}
}
