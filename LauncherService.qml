pragma Singleton

import QtQuick
import Quickshell

QtObject {
    readonly property var apps: DesktopEntries.applications
    readonly property var appsSorted: [...apps.values]
    .sort((a, b) => a.name.localeCompare(b.name))

    function findApp(text) {
        if (text.length == 0) return appsSorted
        const query = text.toLowerCase()

        return apps.values.filter(app => 
            app.name.toLowerCase().includes(query))
    } 
}
