import QtQuick

Widget {
    bgColor: Colors.primary_container
    icon: ""
    text: Time.time
    textColor: Colors.on_primary_container

    tapHandler.onTapped: WindowStates.mediaVisible = !WindowStates.mediaVisible
}
