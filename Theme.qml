pragma Singleton

import QtQuick

QtObject {
  // Backgrounds
  readonly property color background: "#282c34"  // editor bg
  readonly property color surface: "#2c313a"  // widget/bg surfaces
  readonly property color elevated: "#3b4048"  // popovers, hovers
  // Foregrounds
  readonly property color foreground: "#abb2bf"  // main text
  readonly property color mutedForeground: "#5c6370"  // comments/secondary text
  // Accents
  readonly property color primary: "#61afef"  // blue
  readonly property color red: "#e06c75"
  readonly property color yellow: "#d19a66"
  readonly property color green: "#98c379"
  readonly property color blue: "#61afef"
  readonly property color purple: "#c678dd"
  readonly property color cyan: "#56b6c2"
  readonly property color orange: "#d19a66"
}
