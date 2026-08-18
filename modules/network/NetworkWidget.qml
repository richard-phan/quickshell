import QtQuick
import Quickshell.Networking

import "../../components"

Widget {
  bgColor: Colors.primary_container
  icon: iconForNetworkState(NetworkState.state)
  text: NetworkState.name
  textColor: Colors.on_primary_container

  tapHandler.onTapped: WindowStates.networkVisible = !WindowStates.networkVisible

  function iconForNetworkState(state) {
    switch (state) {
    case ConnectionState.Unknown:
      return "?";
    case ConnectionState.Connecting:
      return "󱛆";
    case ConnectionState.Disconnecting:
      return "󱛆";
    case ConnectionState.Connected:
      return "󰖩";
    case ConnectionState.Disconnected:
      return "󰖪";
    }
  }
}
