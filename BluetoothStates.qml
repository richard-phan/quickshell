import QtQuick
import Quickshell.Bluetooth

pragma Singleton

QtObject {
    readonly property var state: Bluetooth.defaultAdapter.enabled
    readonly property var enabled: state == BluetoothAdapterState.Enabled
    readonly property var devices: Bluetooth.devices.values
		readonly property var connected: devices.filter(device => device.connected)
		readonly property var numConnected: {
				let counter = 0
				for (const device of devices) {
						if (device.connected) {
								counter++;
						}
				}
				return counter;
		}
}
