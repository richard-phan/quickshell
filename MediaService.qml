pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Mpris

QtObject {
    readonly property list<MprisPlayer> playerList: Mpris.players.values
    readonly property MprisPlayer activePlayer: playerList.find(p => p.isPlaying) ?? playerList[0]
}