import QtQuick
import Quickshell.Services.Pipewire

Widget {
    bgColor: Theme.surface
    icon: iconForVolume(Audio.muted, Audio.volume)
    text: Audio.volume + "%"
    textColor: Theme.foreground

    function iconForVolume(muted, volume) {
        if (muted) return ""
        else {
            switch (true) {
                case volume > 66: return ""
                case volume > 33: return ""
                case volume >  0: return ""
                case volume == 0: return ""
                default: return ""
            }
        }
    }
}

