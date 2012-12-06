/****************************************************************************
 * Copyright (C) 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ****************************************************************************/
/**
  * Formatting for the messages
  * This file contains:
  *   o Logic for the which side of the screen to put the messages (based on if the message was sent by the current user
  *   o Logic for determining and implementing messages that contain audio
  *   o All other formatting needed to make messages look pretty
  */
import QtQuick 1.1

Item {

    id: messageDelegate
    rotation: 180

    property string tr: "true"
    property string fl: "false"

    property int textWidth

    height: 200; width: window.screenWidth

    // Main background color for the message
    Rectangle {
        width: parent.width
        height: 190
        color: owner === network.username ? "#c8e2bf" : "#d6e0e2"

    Image {
        id: user_img
        source: "http://vocoloco.herokuapp.com/" + userpic
        width: 105; height: 105
        x: owner === network.username ? (window.screenWidth - (user_img.width + 30)) : 30
        y: 35;
    }

    // Username of sender
    Text {
        id: sender
        text:owner
        font.pixelSize: window.smallFont
        anchors {top: user_img.bottom; topMargin: 5; horizontalCenter: user_img.horizontalCenter }
    }

    // Apple ios style message border
    BorderImage {
        id: user_message_background
        source: ":/images/iphone-sms-2.jpg"
        width: content.width + 30; height: content.height + 30
        border { left: 30; top: 23; right: 30; bottom: 23 }
        horizontalTileMode: BorderImage.Stretch
        verticalTileMode: BorderImage.Stretch
        anchors.right: content.right; anchors.rightMargin: -20; anchors.top: content.top; anchors.topMargin: -15
        visible: owner === network.username && isText() ? true : false;
    }

    // Same as above but for when message is sent by someone else
    BorderImage {
        id: other_message_background
        source: ":/images/iphone-sms-1.jpg"
        width: content.width + 36; height: content.height + 30
        border { left: 30; top: 23; right: 30; bottom: 23 }
        horizontalTileMode: BorderImage.Stretch
        verticalTileMode: BorderImage.Stretch
        anchors.left: content.left; anchors.leftMargin: -24; anchors.top: content.top; anchors.topMargin: -15
        visible: owner !== network.username && isText() ? true : false;
    }


    // If the item is a text item this will show up
    Text {
        id: content;
        anchors.margins: 40;
        anchors.right: owner === network.username ? user_img.left : undefined;
        anchors.left: owner === network.username ? undefined : user_img.right;
        text: message
        width: textWidth
        anchors.verticalCenter: parent.verticalCenter
        wrapMode: "WordWrap"
        font.pixelSize: window.normalFont
        visible: is_audio === fl
    }


    // If item is an audio file this shows instead
    Image {
        id: playBtn
        source: ":/images/play-button_black.png"
        width: 157
        height: 126
        anchors.top: user_img.top
        anchors.right: owner === network.username ? user_img.left : undefined;
        anchors.left: owner === network.username ? undefined : user_img.right;
        anchors.rightMargin: 100
        visible: is_audio === tr
        MouseArea {
            anchors.fill: parent
            onClicked: {
                network.downloadAudio(url)
                timer.start()
                swapPlayBtn()
            }
        }
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

    // Used to return play button to black state after a short delay
    Timer {
        id: timer
        interval: 500;
        running: false
        onTriggered: playStopped()
    }

    }

    // Needed to set the text width (if text is too long we don't want it to run off the screen)
    // Basically accomplishes the functionality of a max width for the text content
    Component.onCompleted: {

        if (content.paintedWidth > 500) {
            textWidth = 500
        } else {
            textWidth = content.paintedWidth
        }
    }

    // Make playbutton blue
    function swapPlayBtn() {
        playBtn.source = ":/images/play-button.png"
    }

    function playStopped() {
        playBtn.source = ":/images/play-button_black.png"
        console.log(owner)
    }

    // for use in determining if the message is audio or text
    function isText() {
        var tr =  /^false/;

        if(tr.test(is_audio))
            return true
        else
            return false
    }

    // inverse of above
    function isAudio() {
        var tr =  /^true/;

        if(tr.test(is_audio))
            return true
        else
            return false
    }
}
