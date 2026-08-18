pragma Singleton
pragma Singleton

import Qt.labs.folderlistmodel

import QtQuick
import Quickshell
import Quickshell.Io

Item {
  readonly property string wallpaperFolderPath: "/home/richard/Pictures/avengers"
  readonly property FolderListModel pictures: picturesModel
  readonly property string selectedUrl: {
    let rel_index = (index + 2) % WallpaperService.pictures.count;
    WallpaperService.getFileData(rel_index, "fileUrl").toString().replace("file://", "");
  }

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

  function getFileData(fileIndex, roleName) {
    if (picturesModel.status === FolderListModel.Ready && fileIndex < picturesModel.count) {
      return picturesModel.get(fileIndex, roleName);
    }
    return;
  }
}
