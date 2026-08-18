import QtQuick

Rectangle {
  id: maxBar

  width: sliderWidth
  height: sliderHeight

  required property string orientation

  property real sliderWidth
  property real sliderHeight

  property real progress
}
