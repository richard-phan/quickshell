pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Networking

Item {
  property WifiDevice wifiDevice: {
    for (const device of Networking.devices.values) {
      if (device.type === NetworkDevice.Wifi) {
        return device;
      }
    }
    return null;
  }

  ListModel {
    id: savedNetworksModel
  }

  readonly property var availableNetworks: savedNetworksModel

  readonly property Network connectedNetwork: {
    for (const device of Networking.devices.values)
      for (const network of device.networks.values)
        if (network.connected)
          return network;
    return null;
  }

  readonly property string name: connectedNetwork ? connectedNetwork.name : "Disconnected"
  readonly property int state: connectedNetwork ? connectedNetwork.state : ConnectionState.Disconnected

  property bool isScanning: false

  Timer {
    id: scanTimer

    interval: 5000
    repeat: false

    onRunningChanged: {
      isScanning = running;

      if (!running && parent.wifiDevice) {
        parent.wifiDevice.scannerEnabled = false;
      }
    }
  }

  Timer {
    id: updateNetworksInterval
    property int repeatsRemaining: 5

    interval: 1000

    onTriggered: {
      repeatsRemaining--;
      if (repeatsRemaining > 0) {
        parent.updateSavedNetworks();
        restart();
      } else {
        repeatsRemaining = 5;
      }
    }
  }

  function scanNetwork() {
    if (wifiDevice && !scanTimer.running) {
      wifiDevice.scannerEnabled = true;
      scanTimer.running = true;
      updateNetworksInterval.running = true;
    }
  }

  function updateSavedNetworks() {
    savedNetworksModel.clear();

    if (!wifiDevice)
      return;

    for (let network of wifiDevice.networks.values) {
      if (network.name !== name) {
        savedNetworksModel.append({
          network
        });
      }
    }
  }

  function clearSavedNetworks() {
    savedNetworksModel.clear();
  }

  function toggleWifi() {
    Networking.wifiEnabled = !Networking.wifiEnabled;
  }
}
