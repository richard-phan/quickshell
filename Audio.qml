pragma Singleton

import QtQuick
import Quickshell.Services.Pipewire

QtObject {
    readonly property PwNodeAudio audio: Pipewire.defaultAudioSink?.audio
    readonly property bool muted: audio?.muted
    readonly property int volume: Math.round(audio?.volume * 100)
    property PwObjectTracker tracker: PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
}
