pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
  id: root

  signal dataChanged

  property int cpu: 5
  property int memory: 0
  property int storage: 0

  property Process sysProc: Process {
    command: [Quickshell.env("HOME") + "/.config/quickshell/SystemMonitor"]

    running: true

    stdout: SplitParser {
      onRead: data => {
        const columns = data.trim().split(/\s+/);
        root.cpu = parseInt(columns[0]);
        root.memory = parseInt(columns[1]);
        root.storage = parseInt(columns[2]);

        root.dataChanged();
      }
    }
  }
}
