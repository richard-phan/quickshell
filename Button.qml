import QtQuick
import Quickshell

Rectangle {
    id: background

    width: btnWidth
    height: btnHeight

    color: btnColor

    property int btnWidth
    property int btnHeight
    property string btnColor
    property alias icon: icon
    property alias tapHandler: internalTapHandler

    Text {
        id: icon
        anchors.centerIn: parent
    }

    TapHandler {
        id: internalTapHandler
    }
}
