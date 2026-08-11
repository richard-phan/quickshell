import QtQuick
import Quickshell.Services.UPower

Widget {
  bgColor: Theme.surface
  icon: {
      switch (BatteryService.powerMode) {
          case "Unknown": return ""
          case "Charging": return "󰂄"
          case "Discharging": {
              const percent = BatteryService.batteryPercentage
              switch (true) {
                  case percent > 90: return "󰁹"
                  case percent > 80: return "󰂂"
                  case percent > 70: return "󰂀"
                  case percent > 60: return "󰂀"
                  case percent > 50: return "󰁿"
                  case percent > 40: return "󰁾"
                  case percent > 30: return "󰁽"
                  case percent > 20: return "󰁻"
                  case percent > 10: return "󰁻"
                  case percent >  0: return "󱃍"
              }
          }
          case "Empty":             return "󱃍"
          case "Fully Charged":     return "󰁹"
          case "Pending Charge":    return "󱃍"
          case "Pending Discharge": return "󱃌"
          default: return "󰂑"
    }
  }
  text: BatteryService.batteryPercentage + "%"
  textColor: Theme.foreground

  MouseArea {
      anchors.fill: parent
      onClicked: WindowStates.batteryVisible = !WindowStates.batteryVisible
  }
}
