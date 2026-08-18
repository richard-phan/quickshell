import QtQuick
import Quickshell.Services.Pipewire

import "../../"
import "../../components"
import "../../services"

Widget {
    bgColor: Colors.primary_container
    icon: iconForVolume(AudioService.muted, AudioService.volume)
    text: AudioService.volume + "%"
    textColor: Colors.on_primary_container

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

    tapHandler.onTapped: WindowStates.volumeVisible = !WindowStates.volumeVisible
}

