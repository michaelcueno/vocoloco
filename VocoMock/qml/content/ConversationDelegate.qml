import QtQuick 1.1

Rectangle {
    id: delegate
    height: row.height + 40
    color: "#ffffff"
    width: delegate.ListView.view.width

    Row {
        id: row
        x: 20; y: 20
        width: parent.width

        Column {
            Image {
                id: userthumb
                source:userImage
            }
            Text {
                id: conversationUser
                text: user; width: parent.width; wrapMode: Text.WordWrap
                font { bold: true; family: "Helvetica"; pixelSize: 12 }
            }
            Text {
                id: userimageurl
                text: userImage; width: parent.width; wrapMode: Text.WordWrap
                font { bold: true; family: "Helvetica"; pixelSize: 12 }
            }

        }

        Text {
            id: conversationTitle
            text: title_of_newest_message; width: parent.width; wrapMode: Text.WordWrap
            font { bold: true; family: "Helvetica"; pixelSize: 16 }
        }


    }

    Rectangle {
        width: parent.width; height: 1; color: "#cccccc"
        anchors.bottom: parent.bottom
    }



}
