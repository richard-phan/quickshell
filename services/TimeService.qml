pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  property string time: {
    Qt.formatDateTime(clock.date, "ddd MMM dd HH:mm")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
