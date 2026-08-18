import "../../"
import "../../components"

Widget {
  minWidth: 30
  bgColor: Colors.primary_container
  icon: ""
  text: {
    const maxLength = 40;
    const title = MediaService.activePlayer.trackTitle;

    return (title.length <= maxLength) ? title : title.substring(0, maxLength) + "...";
  }
  textColor: Colors.on_primary_container
}
