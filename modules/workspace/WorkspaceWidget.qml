import QtQuick
import Quickshell.Hyprland

import "../../"
import "../../components"

Rectangle {
  id: widgetRoot

  implicitWidth: workspaceRow.width
  implicitHeight: workspaceRow.height

  width: implicitWidth
  height: implicitHeight

  color: Colors.primary
  radius: 4

  Row {
    id: workspaceRow
    spacing: 0

    Repeater {
      model: 5

      delegate: Widget {
        horizontalPadding: 7

        bgColor: Hyprland.focusedWorkspace.id === (index + 1) ? Colors.tertiary_container : Colors.primary

        icon: ""
        text: index + 1

        textColor: Hyprland.focusedWorkspace.id === (index + 1) ? Colors.on_tertiary_container : Colors.on_primary

        hoverEnabled: !(Hyprland.focusedWorkspace.id === (index + 1))
        tapHandler.onTapped: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${(index + 1)} })`)
      }
    }
  }
}
