import QtQuick 1.1

Item {

    rotation: 180

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
        x: owner === network.username ? (window.screenWidth - (user_img.width + 30)) : 30
        y: 22;
    }

    Text {
        id: sender
        text:owner
        font.pixelSize: window.smallFont
        anchors {top: user_img.bottom; topMargin: 5; horizontalCenter: user_img.horizontalCenter }
    }

    Text {
        id: content;
        anchors.leftMargin: 20;
        height: parent.height
        anchors.right: owner === network.username ? user_img.left : undefined;
        anchors.left: owner === network.username ? undefined : user_img.right;
        text: message
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        font.pixelSize: window.normalFont
    }

    Text {
        id: timestamp
        anchors.bottom: parent.bottom;
        anchors.margins: 30
        anchors.right: owner === network.username ? undefined : parent.right;
        anchors.left: owner === network.username ? parent.left : undefined;
        text:date
    }
}
