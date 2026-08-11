import QtQuick
import Quickshell.Hyprland

Rectangle {
    id: widgetRoot

    implicitWidth: workspaceRow.width
    implicitHeight: workspaceRow.height

    width: implicitWidth
    height: implicitHeight

    color: Theme.surface
    radius: 4

    Row {
        id: workspaceRow
        spacing: 0

        Repeater {
            model: 5

            delegate: Widget {
                horizontalPadding: 7

                bgColor: Hyprland.focusedWorkspace.id === (index + 1)
                    ? Theme.primary
                    : Theme.surface

                icon: ""
                text: index + 1

                textColor: Hyprland.focusedWorkspace.id === (index + 1)
                    ? Theme.background
                    : Theme.foreground

                hoverEnabled: !(Hyprland.focusedWorkspace.id === (index + 1))
                tapHandler.onTapped: Hyprland.dispatch(
                    `hl.dsp.focus({ workspace = ${(index + 1)} })`
                )
            }
        }
    }
}
