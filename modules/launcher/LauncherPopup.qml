import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

import "../.."
import "../../components"

AnimatedPopup {
  id: appLauncher

  isWindowVisible: WindowStates.launcherVisible

  focusable: true

  notchLeft: true
  notchRight: true

  anchors {
    top: true
  }

  IpcHandler {
    target: "appLauncher"

    function toggle() {
      appLauncher.toggle();
    }
  }

  function toggle() {
    WindowStates.launcherVisible = !WindowStates.launcherVisible;
  }

  onVisibleChanged: {
    if (!WindowStates.launcherVisible) {
      searchBox.searchTextBox.text = "";
    }
  }

  Item {
    id: mainContent

    width: contentLayout.width
    height: contentLayout.height

    anchors.centerIn: parent

    ColumnLayout {
      id: contentLayout

      spacing: 10

      property var results: LauncherService.findApp("").slice(0, 5)
      property var searchIndex: 0

      SearchBox {
        // FIX: search bar color needs to be independent
        id: searchBox
        searchBoxWidth: 400
        searchBoxHeight: 40

        searchTextBox.onTextChanged: {
          parent.searchIndex = 0;
          const res = LauncherService.findApp(searchTextBox.text);
          parent.results = res.slice(0, Math.min(res.length, 5));

          const result = DesktopEntries.heuristicLookup(searchTextBox.text);
        }

        searchTextBox.onAccepted: {
          if (parent.results.length > 0) {
            const appId = parent.results[parent.searchIndex].id;
            DesktopEntries.byId(appId).execute();

            searchTextBox.text = "";

            WindowStates.launcherVisible = false;
          }
        }
      }

      Repeater {
        id: searchResults

        model: parent.results

        delegate: Rectangle {
          id: contentEntry

          width: searchBox.searchBoxWidth
          height: 50

          radius: height / 2

          anchors.horizontalCenter: parent.horizontalCenter

          color: index == parent.searchIndex ? Colors.secondary : Colors.primary_container

          ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            width: parent.width - 100
            spacing: -5

            Text {
              id: appName

              text: modelData.name
              color: Colors.tertiary_container
              font.pointSize: 13
              font.bold: false

              Layout.fillWidth: true
              elide: Text.ElideRight
            }

            Text {
              id: appDesc
              text: modelData.comment
              color: Colors.tertiary

              Layout.fillWidth: true
              elide: Text.ElideRight
            }
          }
        }
      }
    }

    Keys.onPressed: event => {
      if (event.key === Qt.Key_Down) {
        if (contentLayout.searchIndex + 1 < contentLayout.results.length)
          contentLayout.searchIndex++;
      } else if (event.key === Qt.Key_Up) {
        if (contentLayout.searchIndex - 1 >= 0)
          contentLayout.searchIndex--;
      } else if (event.key === Qt.Key_Escape) {
        WindowStates.launcherVisible = false;
      }
    }
  }
}
