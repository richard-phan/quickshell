import QtQuick
import Quickshell.Bluetooth

pragma Singleton

QtObject {
    readonly property var state: Bluetooth.defaultAdapter.enabled
    readonly property var enabled: state == BluetoothAdapterState.Enabled
    readonly property var devices: Bluetooth.devices.values
    readonly property var connected: devices.filter(device => device.connected)
}
