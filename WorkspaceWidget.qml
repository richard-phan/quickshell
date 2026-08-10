import QtQuick
import Quickshell.Hyprland

Rectangle {
    id: widgetRoot

    implicitWidth: workspaceRow.width
    implicitHeight: workspaceRow.height

    width: implicitWidth
    height: implicitHeight

    color: Theme.surface

    Row {
        id: workspaceRow
        spacing: 0

        Repeater {
            model: Hyprland.workspaces

            delegate: Widget {
                horizontalPadding: 7

                bgColor: modelData.focused
                    ? Theme.primary
                    : Theme.surface

                icon: ""
                text: modelData.id

                textColor: modelData.focused
                    ? Theme.background
                    : Theme.foreground

                hoverEnabled: !modelData.focused
                tapHandler.onTapped: modelData.activate()
            }
        }
    }
}
