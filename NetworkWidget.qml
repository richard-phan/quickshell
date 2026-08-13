import QtQuick
import Quickshell.Networking

Widget {
  bgColor: Theme.surface
  icon: iconForNetworkState(NetworkState.state)
  text: NetworkState.name
  textColor: Theme.foreground

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
