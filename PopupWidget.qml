import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: root
    visible: isWindowVisible
    color: "transparent"

    property bool isWindowVisible

    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay
}
