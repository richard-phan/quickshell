import QtQuick
import Quickshell.Bluetooth

Widget {
  bgColor: Theme.surface
  icon: iconForBluetoothState(Bluetooth.defaultAdapter.state)
  text: {
    let connected = []
    for (const device of Bluetooth.devices.values)
      if (device.connected) connected.push(device.name)

    if (connected.length == 0) return "Not Connected"
    if (connected.length == 1) return connected[0]
    return connected.length + " Connected"
  }
  textColor: Theme.foreground

  function iconForBluetoothState(state) {
      switch (state) {
          case BluetoothAdapterState.Enabled:   return "󰂯"
          case BluetoothAdapterState.Enabling:  return "󰂯" 
          case BluetoothAdapterState.Disabling: return "󰂲"
          case BluetoothAdapterState.Disabled:  return "󰂲"
          case BluetoothAdapterState.Blocked:   return "󰂲"
          default: return ""
    }
  }
}
