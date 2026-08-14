pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Mpris

QtObject {
  readonly property list<MprisPlayer> playerList: Mpris.players.values

  readonly property MprisPlayer activePlayer: playerList.find(p => p.isPlaying) ?? playerList[0]

  readonly property bool isPlaying: activePlayer?.playbackState === MprisPlaybackState.Playing

  readonly property string trackTitle: activePlayer?.trackTitle

  readonly property string duration: {
    if (!activePlayer)
      return "0:00";
    const minutes = Math.floor(activePlayer?.length / 60);
    const seconds = Math.floor(activePlayer?.length % 60);
    return minutes + ":" + String(seconds).padStart(2, '0');
  }

  readonly property string position: {
    if (!activePlayer)
      return "0:00";
    const minutes = Math.floor(activePlayer?.position / 60);
    const seconds = Math.floor(activePlayer?.position % 60);
    return minutes + ":" + String(seconds).padStart(2, '0');
  }

  readonly property real durationPercent: {
    if (!activePlayer)
      return 0;
    return activePlayer?.position / activePlayer?.length;
  }

  readonly property Timer positionTimer: Timer {
    running: isPlaying
    interval: 1000
    repeat: true

    onTriggered: {
      activePlayer?.positionChanged();
    }
  }
}
