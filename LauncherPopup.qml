import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

PopupWidget {
    id: appLauncher
    implicitWidth: mainContent.width
    implicitHeight: mainContent.height

    isWindowVisible: WindowStates.launcherVisible
    focusable: true

    anchors {
        top: true
    }
    
    IpcHandler {
        target: "appLauncher"

        function toggle() {
            appLauncher.toggle()
        }
    }

    function toggle() {
        WindowStates.launcherVisible = !WindowStates.launcherVisible
    }

    Rectangle {
        id: mainContent

        property var padding: 40
        bottomLeftRadius: 20
        bottomRightRadius: 20

        implicitWidth: contentLayout.implicitWidth + padding
        implicitHeight: contentLayout.implicitHeight + padding

        color: Theme.background

        Column {
            id: contentLayout
            anchors.centerIn: parent
            spacing: 10
            
            property var results: LauncherService
                                    .findApp("")
                                    .slice(0, 5)
            property var searchIndex: 0

            SearchBox {
                id: searchBox
                searchBoxWidth: 400
                searchBoxHeight: 40

                searchTextBox.onTextChanged: {
                    parent.searchIndex = 0
                    const res = LauncherService.findApp(searchTextBox.text)
                    parent.results = res.slice(0, Math.min(res.length, 5))

                    const result = DesktopEntries.heuristicLookup(searchTextBox.text)
                }

                searchTextBox.onAccepted: {
                    if (parent.results.length > 0) {
                        const appId = parent.results[parent.searchIndex].id
                        DesktopEntries.byId(appId).execute()

                        WindowStates.launcherVisible = false
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

                    color: index == parent.searchIndex 
                        ? Theme.elevated
                        : Theme.background
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 20
                        anchors.rightMargin: 20
                        width: parent.width - 100
                        spacing: -5
                        
                        Text {
                            id: appName

                            text: modelData.name
                            color: Theme.foreground
                            font.pointSize: 13
                            font.bold: false

                            Layout.fillWidth: true
                            elide: Text.ElideRight
                        }

                        Text {
                            id: appDesc
                            text: modelData.comment
                            color: Theme.mutedForeground

                            Layout.fillWidth: true
                            elide: Text.ElideRight
                        }
                    }
                }
            }
        }

        Keys.onPressed: (event) => {
            if (event.key === Qt.Key_Down) {
                if (contentLayout.searchIndex + 1 < contentLayout.results.length)
                    contentLayout.searchIndex++;
            }
            else if (event.key === Qt.Key_Up) {
                if (contentLayout.searchIndex - 1 >= 0)
                    contentLayout.searchIndex--;
            }
        }
    }
}
