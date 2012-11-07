Page {
    id: mainPage

    Button {
        id: button1
        x: 16
        y: 324
        width: 100
        height: 42
        text: "Play"
        onClicked:
            AudioToggle.play()
    }

    Button {
        id: button2
        x: 126
        y: 324
        width: 100
        height: 42
        text: "Stop"
        onClicked:
            AudioToggle.stop()
    }
     Button {
        id: button3
        x: 247
        y: 324
        width: 100
        height: 42
        text: "Record"
        onClicked:
            AudioToggle.record()
 }

}
