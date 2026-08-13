import QtQuick
import Quickshell.Networking

Widget {
  bgColor: Theme.surface
  icon: iconForNetworkState(NetworkState.state)
  text: NetworkState.name
  textColor: Theme.foreground

  tapHandler.onTapped: WindowStates.networkVisible = !WindowStates.networkVisible

  function iconForNetworkState(state) {
    //console.log(wifi turned off 󱛅)
    switch (state) {
    case ConnectionState.Unknown:
      return "U";
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
