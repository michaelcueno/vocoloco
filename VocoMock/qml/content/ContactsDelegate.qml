import QtQuick 1.1

Rectangle {
    id: row
    width: parent.width
    height: 180
    color: "#ffffff"

    Image {
        id: list_background
        source: ":/images/list_background.gif"
    }

    Image {
        id: user_img
        source: "http://vocoloco.herokuapp.com/" + image
        width: 105; height: 105
        x: 30; y: 38;
    }

    Text {  // Contact Name
        id: contact_name
        text: name;
        font { bold: true; family: "Helvetica"; pixelSize: 35 }
        anchors { left: user_img.right; leftMargin: 40;}
        color: "#46433a"
        y: 70;
    }

    Image {
        id: check_box
        source: ":/images/un_checked_box.gif"
        anchors { right: parent.right; }
        y: 38; x: parent.width - 56;
    }

}
