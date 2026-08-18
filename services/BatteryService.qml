pragma Singleton

import QtQuick
import Quickshell.Services.UPower

QtObject {
    readonly property bool isReady: UPower.displayDevice.ready
    readonly property string powerMode: {
        switch (UPower.displayDevice.state) {
            case UPowerDevice.Unknown: return "Unknown"
            case UPowerDevice.Charging: return "Charging"
            case UPowerDevice.Discharging: return "Discharging"
            case UPowerDevice.Empty: return "Empty"
            case UPowerDevice.FullyCharged: return "Fully Charged"
            case UPowerDevice.PendingCharge: return "Pending Charge"
            case UPowerDevice.PendingDischarge: return "Pending Discharge"
            default: return "Unknown"
        }
    }
    readonly property int batteryPercentage: isReady ? Math.round(UPower.displayDevice.percentage * 100) : 0
    property string powerProfile: {
        switch (PowerProfiles.profile) {
            case PowerProfile.PowerSaver:  return "Power Saving"
            case PowerProfile.Balanced:    return "Balanced"
            case PowerProfile.Performance: return "Performance"
            default: return "Unknown"
        }
    }
}
