import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

import "../../components"

AnimatedPopup {
  id: wallpaperChanger

  isWindowVisible: WindowStates.wallpaperVisible
  focusable: true

  notchLeft: true
  notchRight: true

  anchors {
    top: true
  }

  IpcHandler {
    target: "wallpaperChanger"

    function toggle() {
      wallpaperChanger.toggle();
    }
  }

  function toggle() {
    WindowStates.wallpaperVisible = !WindowStates.wallpaperVisible;
  }

  Process {
    id: wallpaperProcess
    running: false
    command: ["hyprctl", "hyprpaper", "wallpaper", `DP-1,${WallpaperService.selectedUrl},cover`]
    stdout: StdioCollector {
      onStreamFinished: {
        console.log(this.text);
        console.log(WallpaperService.selectedUrl);
      }
    }
  }

  Item {
    focus: true

    width: contentLayout.width
    height: contentLayout.height

    anchors.centerIn: parent

    Keys.onPressed: event => {
      if (event.key === Qt.Key_H) {
        if ((WallpaperService.index - 1) <= 0) {
          WallpaperService.index = WallpaperService.pictures.count - 1;
          console.log('pressed');
        } else {
          WallpaperService.index--;
          wallpaperProcess.running = true;
        }
      } else if (event.key === Qt.Key_L) {
        if ((WallpaperService.index + 1) == WallpaperService.pictures.count) {
          WallpaperService.index = 0;
        } else {
          WallpaperService.index++;
          wallpaperProcess.running = true;
        }
      } else if (event.key === Qt.Key_Escape) {
        WindowStates.wallpaperVisible = false;
        event.accepted = true;
      } else if (event.key === Qt.Key_Return) {
        WindowStates.wallpaperVisible = false;
      }
    }

    RowLayout {
      id: contentLayout

      spacing: 10

      focus: true

      Repeater {
        model: 5

        delegate: Rectangle {
          width: 290
          height: 168

          border.width: 4
          border.color: index == 2 ? Colors.primary : "transparent"
          radius: 5

          color: "transparent"

          Loader {
            active: WallpaperService.pictures.count > 0
            anchors.centerIn: parent

            sourceComponent: Image {
              sourceSize.width: 280

              asynchronous: true
              source: {
                let rel_index = (index + WallpaperService.index) % WallpaperService.pictures.count;
                WallpaperService.getFileData(rel_index, "fileUrl").toString().replace("file://", "");
              }
            }
          }
        }
      }
    }
  }
}
