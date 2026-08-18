import QtQuick
import QtQuick.Controls.Basic

Slider {
  id: root

  property color bgColor
  property color progressColor

  handle: Item {}

  background: Rectangle {
    radius: parent.height / 2

    color: root.bgColor

    Rectangle {
      y: parent.height - (root.value / 100 * parent.height)
      width: parent.width
      height: root.value / 100 * parent.height

      radius: width / 2

      color: root.progressColor
    }
  }
}
