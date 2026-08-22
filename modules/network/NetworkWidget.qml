import QtQuick
import Quickshell.Networking

import "../../"
import "../../components"

Widget {
  bgColor: Colors.primary
  icon: iconForNetworkService(NetworkService.state)
  text: NetworkService.name
  textColor: Colors.on_primary

  tapHandler.onTapped: WindowStates.networkVisible = !WindowStates.networkVisible

  function iconForNetworkService(state) {
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
