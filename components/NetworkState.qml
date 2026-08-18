pragma Singleton

import QtQuick
import Quickshell.Networking

QtObject {
  property bool enableScan: false
  property WifiDevice wifiDevice: null
  Binding on wifiDevice {
    value: {
      // Safely convert the ObjectModel to a JS array
      let devArray = Array.from(Networking.devices);
      for (let device of devArray) {
        // DeviceType 2 or presence of scannerEnabled marks a wireless card
        if (device && device.hasOwnProperty("scannerEnabled")) {
          return device;
        }
      }
      return null;
    }
  }

  readonly property Network connectedNetwork: {
    for (const device of Networking.devices.values)
      for (const network of device.networks.values)
        if (network.connected)
          return network;
    return null;
  }
  readonly property string name: connectedNetwork ? connectedNetwork.name : "Disconnected"
  readonly property int state: connectedNetwork ? connectedNetwork.state : ConnectionState.Disconnected
  readonly property Timer scanTimer: Timer {
    running: enableScan
    interval: 5000

    onTriggered: {
      enableScan = false;
      wifiDevice.scannerEnabled = false;
      console.log("Scan Complete");
    }
  }

  function findWifiDevice() {
    // Loop through the ObjectModel of devices exposed by Quickshell
    for (let i = 0; i < Networking.devices.count; i++) {
      let device = Networking.devices.get(i);

      // Quickshell objects have a class name or properties we can check
      if (device && device.hasOwnProperty("scannerEnabled")) {
        console.log(device);
        return device;
      }
    }
    return null;
  }
}
