Widget {
    minWidth: 30
    bgColor: Theme.surface
    icon: ""
    text: {
        const maxLength = 40
        const title = MediaService.activePlayer.trackTitle

        return (title.length <= maxLength)
            ? title
            : title.substring(0, maxLength) + "..."
    }
    textColor: Theme.foreground
}
