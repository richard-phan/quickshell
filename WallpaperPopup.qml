import QtQuick
import Quickshell
import Quickshell.Io

PopupWidget {
        id: wallpaperChanger

		implicitWidth: mainContent.implicitWidth
		implicitHeight: mainContent.implicitHeight

		isWindowVisible: WindowStates.wallpaperVisible
		focusable: true

		anchors {
				top: true
		}

        margins.top: 30

        IpcHandler {
            target: "wallpaperChanger"

            function toggle() {
                wallpaperChanger.toggle()
            }
        }

        function toggle() {
            console.log('togglajd')
            WindowStates.wallpaperVisible = !WindowStates.wallpaperVisible
        }

        Process {
            id: wallpaperProcess
            running: false
            command: ["hyprctl", "hyprpaper", "wallpaper", `DP-1,${WallpaperService.selectedUrl},cover`]
            stdout: StdioCollector {
                onStreamFinished: {
                    console.log(this.text)
                    console.log(WallpaperService.selectedUrl)
                }
            }
        }

		Rectangle {
				id: mainContent

				property var padding: 40

				implicitWidth: contentLayout.implicitWidth + padding
				implicitHeight: contentLayout.implicitHeight + padding

				bottomLeftRadius: 20
				bottomRightRadius: 20

				color: Theme.background

				focus: true
				
				Keys.onPressed: (event) => {
						if (event.key === Qt.Key_Left) {
								if ((WallpaperService.index - 1) <= 0)
										WallpaperService.index = WallpaperService.pictures.count - 1
								else
										WallpaperService.index--
						}
                        else if (event.key === Qt.Key_Right) {
								if ((WallpaperService.index + 1) == WallpaperService.pictures.count)
										WallpaperService.index = 0 
								else
										WallpaperService.index++
						}

                        else if (event.key === Qt.Key_Escape) {
								WindowStates.wallpaperVisible = false
								event.accepted = true
                            }
                        else if (event.key === Qt.Key_Return) {
                            console.log('attempting to run')
                            wallpaperProcess.running = true
                            event.accepted = true
                        }
				}

				Row {
						id: contentLayout

						anchors.centerIn: mainContent
						spacing: 10

						Repeater {
								model: 5

								delegate: Rectangle {
										width: 290
										height: 168

										border.width: 4
										border.color: index == 2 ? Theme.primary : "transparent"
										radius: 5

										color: "transparent"
										
										Loader {
												active: WallpaperService.pictures.count > 0
												anchors.centerIn: parent

												sourceComponent: Image {
														sourceSize.width: 280

														asynchronous: true
														source: {
				let rel_index = (index + WallpaperService.index) % WallpaperService.pictures.count
				WallpaperService.getFileData(rel_index, "fileUrl").toString().replace("file://", "")
		}
												}
										}
								}
						}
				}
		}
}
