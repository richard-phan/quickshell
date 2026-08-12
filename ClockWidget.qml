import QtQuick

Widget {
    bgColor: Theme.surface
    icon: ""
    text: Time.time
    textColor: Theme.foreground

    tapHandler.onTapped: WindowStates.mediaVisible = !WindowStates.mediaVisible
}
