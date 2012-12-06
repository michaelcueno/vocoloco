import QtQuick 1.1

Rectangle {
    id: delegate
    height: column.height + 40
    color: "#ffffff"
    width: delegate.ListView.view.width

    Column {
        id: column
        x: 20; y: 20
        width: parent.width - 40

        Text {
            id: conversationTitle
            text: title; width: parent.width; wrapMode: Text.WordWrap
            font { bold: true; family: "Helvetica"; pixelSize: 16 }
        }

        Text {
            id: descriptionText
            width: parent.width; text: description
            wrapMode: Text.WordWrap; font.family: "Helvetica";
            font.pixelSize: 11;
        }
    }

    Rectangle {
        width: parent.width; height: 1; color: "#cccccc"
        anchors.bottom: parent.bottom
    }



}
