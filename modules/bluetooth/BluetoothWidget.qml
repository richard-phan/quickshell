// FIX: better way to handle bluetooth service?

import "../../"
import "../../components"
import QtQuick
import Quickshell.Bluetooth

Widget {
  function iconForBluetoothState(state) {
    if (BluetoothService.numConnected > 0)
      return "󰂱";

    switch (state) {
    case BluetoothAdapterState.Enabled:
      return "󰂯";
    case BluetoothAdapterState.Enabling:
      return "󰂯";
    case BluetoothAdapterState.Disabling:
      return "󰂲";
    case BluetoothAdapterState.Disabled:
      return "󰂲";
    case BluetoothAdapterState.Blocked:
      return "󰂲";
    default:
      return "UNKNOWN";
    }
  }

  bgColor: Colors.primary_container
  icon: iconForBluetoothState(Bluetooth.defaultAdapter.state)
  text: {
    let connected = [];
    for (const device of Bluetooth.devices.values)
      if (device.connected) {
        connected.push(device.name);
      }
    if (connected.length == 0)
      return "Not Connected";

    if (connected.length == 1)
      return connected[0];

    return connected.length + " Connected";
  }
  textColor: Colors.on_primary_container

  MouseArea {
    anchors.fill: parent
    onClicked: WindowStates.bluetoothVisible = !WindowStates.bluetoothVisible
  }
}
