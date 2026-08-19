import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

import "../../"
import "../../components"

AnimatedPopup {
  id: root

  isWindowVisible: WindowStates.powerVisible

  expectedMaxHeight: 150

  notchLeft: true
  notchRight: true

  anchors {
    top: true
    right: true
  }

  Process {
    id: powerProcess
  }

  RowLayout {
    id: contentLayout

    height: 40

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 20

    spacing: 15

    Repeater {
      model: ListModel {
        ListElement {
          icon: ""
          pointSize: 15
          command: "systemctl suspend"
        }
        ListElement {
          icon: "󰜉"
          pointSize: 20
          command: "systemctl reboot"
        }
        ListElement {
          icon: "⏻"
          pointSize: 28
          command: "systemctl poweroff"
        }
      }

      delegate: BackgroundButton {
        btnWidth: 40
        btnHeight: 40
        color: hoverHandler.hovered ? Colors.on_tertiary : Colors.tertiary

        radius: 8

        btnText: model.icon
        btnTextColor: hoverHandler.hovered ? Colors.tertiary : Colors.on_tertiary
        btnTextPointSize: model.pointSize

        tapHandler.onTapped: {
          powerProcess.command = model.command.split(" ");
          powerProcess.running = true;
        }
      }
    }
  }
}
