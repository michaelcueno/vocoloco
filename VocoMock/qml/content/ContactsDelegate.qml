import QtQuick 1.1

Rectangle {
    id: row
    width: parent.width
    height: 180
    color: "#ffffff"

    Image {
        id: user_img
        source: "http://vocoloco.herokuapp.com/" + image
        anchors.margins: 30;
    }

    Text {  // Contact Name
        text: "name";
        font { bold: true; family: "Helvetica"; pixelSize: 25 }
    }

}
