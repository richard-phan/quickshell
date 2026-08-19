import "../../"
import "../../components"

Widget {
  bgColor: Colors.primary
  icon: ""
  text: TimeService.time
  textColor: Colors.on_primary

  tapHandler.onTapped: WindowStates.mediaVisible = !WindowStates.mediaVisible
}
