import QtQuick 1.1

Rectangle {
    id: row
    width: parent.width
    height: 130
    color: "#ffffff"


    Image { // User profile picture thumbnail
        id: userthumb
        source:userImage
        width: 80; height: 80;
        fillMode: Image.PreserveAspectFit
        anchors.left: parent.left; anchors.top: parent.top; anchors.margins: 20
    }

    Text {  // Username of sender
        id: conversationUser
        width: 80
        text: user;
        font { bold: true; family: "Helvetica"; pixelSize: 16 }
        anchors.top: userthumb.bottom; anchors.left: userthumb.left;
        anchors.topMargin: 2;

    }

    Text {  // Message Title
        id: conversationTitle

        text: title_of_newest_message; width: parent.width; wrapMode: Text.WordWrap
        font { bold: true; family: "Helvetica"; pixelSize: 24 }
        anchors.left: userthumb.right; anchors.leftMargin: 50; anchors.top: userthumb.top;
    }

    Rectangle { // Linebreak
        width: parent.width; height: 1; color: "#cccccc"
        anchors.bottom: parent.bottom
    }


// ----------------------------- Clickable Interactivity Code -----------------------//
    MouseArea {
        anchors.fill: parent
        onPressed: parent.state = "pressed"
        onReleased: parent.state = "normal"

    }

    states: [
        State {
            name: "normal"
            PropertyChanges { target: row; color: "white"}
        },
        State {
            name: "pressed"
            PropertyChanges { target: row; color: "lightsteelblue"}
        }
    ]

    transitions: [
        Transition {
            from: "pressed"
            to: "normal"
            ColorAnimation { target: row; duration: 300}
        }
    ]
//-------------------------------End of Clickable code -----------------------------//

}
