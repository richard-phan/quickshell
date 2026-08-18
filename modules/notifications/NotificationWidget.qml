import QtQuick
import Quickshell.Services.Notifications

import "../../components"

// FIX: Better way to handl enotifications??

Widget {
  bgColor: Colors.primary_container
  icon: ""
  text: NotificationService.count ? NotificationService.count + "" : "0"
  textColor: Colors.on_primary_container

  tapHandler.onTapped: WindowStates.notificationVisible = !WindowStates.notificationVisible
}
