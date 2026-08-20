pragma Singleton

import Qt.labs.folderlistmodel

import QtQuick
import Quickshell
import Quickshell.Io

Item {
  readonly property string wallpaperFolderPath: "/home/richard/Pictures/Wallpapers/ultrawide"
  readonly property FolderListModel pictures: picturesModel

  property int index

  FolderListModel {
    id: picturesModel
    folder: "file://" + wallpaperFolderPath
    showFiles: true
    showDirs: false
    nameFilters: ["*.png", "*.jpg", "*.jpeg"]

    onStatusChanged: {
      if (status === FolderListModel.Ready) {
        console.log("Wallpaper Service Ready");
      }
    }
  }

  Process {
    id: wallpaperProcess
  }

  function getFileData(fileIndex, roleName) {
    if (picturesModel.status === FolderListModel.Ready && fileIndex < picturesModel.count) {
      return picturesModel.get(fileIndex, roleName);
    }
    return;
  }

  function updateWallpaper() {
    const rel_index = (index + 2) % WallpaperService.pictures.count;
    const path = WallpaperService.getFileData(rel_index, "fileUrl").toString().replace("file://", "");

    wallpaperProcess.command = [Quickshell.env("HOME") + "/.config/quickshell/services/theme_switcher.sh", "-p", path, "-w"];
    wallpaperProcess.running = true;
  }

  function updateTheme() {
    const rel_index = (index + 2) % WallpaperService.pictures.count;
    const path = WallpaperService.getFileData(rel_index, "fileUrl").toString().replace("file://", "");

    wallpaperProcess.command = [Quickshell.env("HOME") + "/.config/quickshell/services/theme_switcher.sh", "-p", path, "-t"];
    wallpaperProcess.running = true;
  }
}
