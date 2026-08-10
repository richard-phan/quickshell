pragma Singleton

import QtQuick
import Quickshell.Networking

QtObject {
    readonly property Network connectedNetwork: {
        for (const device of Networking.devices.values)
          for (const network of device.networks.values)
            if (network.connected) return network
        return null
    }

    readonly property string name: connectedNetwork ? connectedNetwork.name : "Disconnected"
    readonly property int state: connectedNetwork? connectedNetwork.state : ConnectionState.Disconnected
}
