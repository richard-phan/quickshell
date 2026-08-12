import QtQuick
import QtQuick.Controls
import Quickshell

Item {
    id: searchBox
    width: searchBoxWidth
    height: searchBoxHeight

    property TextField searchTextBox: searchText
    property int searchBoxWidth: 300
    property int searchBoxHeight: 40

    Rectangle {
        id: searchBackground
        width: parent.searchBoxWidth
        height: parent.searchBoxHeight

        color: Theme.elevated
        radius: height
    }

    TextField {
        id: searchText
        width: parent.width - 40

        anchors.horizontalCenter: parent.horizontalCenter

        color: Theme.foreground
        font.pointSize: 18
        placeholderText: "Search"
        placeholderTextColor: Theme.mutedForeground

        Component.onCompleted: forceActiveFocus()
        
        background: null

        cursorVisible: false

        cursorDelegate: Item {}
    }
}
