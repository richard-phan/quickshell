import "../../"
import "../../components"

Widget {
    bgColor: Colors.primary_container
    icon: ""
    text: TimeService.time
    textColor: Colors.on_primary_container

    tapHandler.onTapped: WindowStates.mediaVisible = !WindowStates.mediaVisible
}
