import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: root
    visible: isWindowVisible
    color: "transparent"

    property bool isWindowVisible

    WlrLayershell.layer: WlrLayer.Overlay
}
