pragma Singleton

import QtQuick
import Quickshell.Services.Notifications

QtObject {
  //killall dunst
  readonly property NotificationServer server: NotificationServer {
    id: server
    keepOnReload: true
    bodySupported: true

    onNotification: n => {
      n.tracked = true;

      addNotification(n);
    }
  }

  property var notificationsByApp: new Map()

  readonly property var notifications: server.trackedNotifications
  readonly property int count: notifications ? notifications.values.length : 0

  function clearAll() {
    let list = notifications.values;
    for (let i = list.length - 1; i >= 0; i--) {
      list[i].tracked = false;
    }

    notificationsByApp = new Map();
  }

  function addNotification(notification) {
    const app = notification.appName;

    if (!notificationsByApp.has(app)) {
      notificationsByApp.set(app, []);
    }

    notificationsByApp.get(app).unshift(notification);

    notificationsByApp = new Map(notificationsByApp);
  }

  function removeNotification(notification, index) {
    const app = notificationsByApp.get(notification.appName);

    app.splice(index, 1);

    notification.tracked = false;

    if (app.length == 0) {
      notificationsByApp.delete(notification.appName);
    }

    // emit the signal to update the UI
    notificationsByApp = new Map(notificationsByApp);
  }

  function removeAppNotifications(appName) {
    for (const n of notificationsByApp.get(appName)) {
      n.tracked = false;
    }

    notificationsByApp.delete(appName);

    // emit the signal to update the UI
    notificationsByApp = new Map(notificationsByApp);
  }
}
