import QtQuick
import Quickshell.Bluetooth

import "../../components"

// FIX: better way to handle bluetooth service?

Widget {
  bgColor: Colors.primary_container
  icon: iconForBluetoothState(Bluetooth.defaultAdapter.state)
  text: {
    let connected = []
    for (const device of Bluetooth.devices.values)
      if (device.connected) connected.push(device.name)

    if (connected.length == 0) return "Not Connected"
    if (connected.length == 1) return connected[0]
    return connected.length + " Connected"
  }
  textColor: Colors.on_primary_container

	function iconForBluetoothState(state) {
			if (BluetoothStates.numConnected > 0) return "󰂱"

      switch (state) {
          case BluetoothAdapterState.Enabled:   return "󰂯"
          case BluetoothAdapterState.Enabling:  return "󰂯" 
          case BluetoothAdapterState.Disabling: return "󰂲"
          case BluetoothAdapterState.Disabled:  return "󰂲"
          case BluetoothAdapterState.Blocked:   return "󰂲"
          default: return ""
    }
}
MouseArea {
         anchors.fill: parent
        onClicked: WindowStates.bluetoothVisible = !WindowStates.bluetoothVisible
    }
}
