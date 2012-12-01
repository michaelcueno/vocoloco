import QtQuick 1.1

Rectangle {

    rotation: 180

    height: 200; width: window.width
    id: messageDelegate

    color: "#dce2ee"

    /*
    Image {
        anchors.fill: parent
        id: list_background
        source: ":/images/navy_blue.png"
        fillMode: Image.Tile
    }
    */


    Image {
        id: user_img
        source: "http://vocoloco.herokuapp.com/" + userpic
        width: 105; height: 105
        x: owner === network.username ? (window.screenWidth - (user_img.width + 30)) : 30
        y: 35;
    }



    Text {
        id: sender
        text:owner
        font.pixelSize: window.smallFont
        anchors {top: user_img.bottom; topMargin: 5; horizontalCenter: user_img.horizontalCenter }
    }


    BorderImage {
        id: user_message_background
        source: ":/images/iphone-sms-2.jpg"
        width: content.width + 25; height: 120
        border { left: 30; top: 23; right: 30; bottom: 23 }
        horizontalTileMode: BorderImage.Stretch
        verticalTileMode: BorderImage.Stretch
        anchors.centerIn: content
        visible: owner === network.username ? true : false;
    }

    BorderImage {
        id: other_message_background
        source: ":/images/iphone-sms-1.jpg"
        width: content.width + 30; height: 120
        border { left: 30; top: 23; right: 30; bottom: 23 }
        horizontalTileMode: BorderImage.Stretch
        verticalTileMode: BorderImage.Stretch
        anchors.centerIn: content
        visible: owner === network.username ? false : true;
    }


    Text {
        id: content;
        anchors.margins: 40;
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
        anchors.margins: 18
        anchors.right: owner === network.username ? undefined : parent.right;
        anchors.left: owner === network.username ? parent.left : undefined;
        text:date
    }

    Rectangle {
        id: linebreak
        width: parent.width
        height: 2;
        color: "grey"
        anchors.bottom: parent.bottom
    }

}
