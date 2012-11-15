import QtQuick 1.1

Item {

    height: 200; width: window.width
    id: messageDelegate

    Image {
        id: list_background
        source: ":/images/list_background.gif"
    }

    Image {
        id: user_img
        source: "http://vocoloco.herokuapp.com/" + userpic
        width: 105; height: 105
        x: 30; y: 22;
    }

    Text {
        id: sender
        text:owner
        font.pixelSize: window.smallFont
        anchors {top: user_img.bottom; topMargin: 5; horizontalCenter: user_img.horizontalCenter }
    }

    Text {
        id: content;
     anchors { left: user_img.right; leftMargin: 20; }
        text:message
        wrapMode: Text.WordWrap
        font.pixelSize: window.normalFont
    }

    Text {
        id: timestamp
        anchors{ bottom: parent.bottom; right: parent.right; margins: 30 }
        text:date
    }

}
