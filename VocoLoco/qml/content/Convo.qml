/****************************************************************************
 * Copyright (C) 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ****************************************************************************/

/**
  * Conversation focus screen (When user taps on a conversation from the main screen
  */
import QtQuick 1.1

Rectangle {

    property string convo_id

    anchors.bottom: parent.bottom
    anchors.top: parent.top
    anchors.topMargin: window.screenHeight * (1/10)
    anchors { right: parent.right; left: parent.left }

    Image {
        id: background
        anchors.fill: parent
        fillMode: Image.Tile
        source: ":/images/carbon_fibre.png"
    }

    MouseArea{
        anchors.fill: parent;
        onClicked: {
            changeHeader("Your Conversations")
            changeScreen(homeScreen)
        }
    }

    // All messages in the conversation rotated 180 degrees so that it is initalized to the bottom
    ListView { id: convo_messages

        rotation: 180;
        width: window.screenWidth
        height: parent.height - new_message_input.height
        maximumFlickVelocity: 2502
        clip: true;
        delegate: MessageDelegate {id: message_delegate}
        model: message_xml
    }

    ScrollBar {
        rotation: 180
        scrollArea: convo_messages; height: convo_messages.height; width:10;
        anchors.right: convo_messages.right; anchors.top: convo_messages.top;
    }

    // XML model for the message. The xml query gets the conversation messages and the
    // XML roles get the elements
    XmlListModel {

        id: message_xml
        query: "/conversation/child::element(messages)/message"

        XmlRole { name: "owner"; query: "sender/string()" }
        XmlRole { name: "userpic"; query: "userpic/string()" }
        XmlRole { name: "message_id"; query: "message_id/string()" }
        XmlRole { name: "message"; query: "message/string()"}
        XmlRole { name: "date"; query: "date/string()" }
        XmlRole { name: "is_audio"; query: "is_audio/string()" }
        XmlRole { name: "url"; query: "url/string()" }

    }

    // Beginning of the send new message object at the bottom of the screen
    Rectangle {
        id: new_message_input
        anchors.bottom: parent.bottom
        width: window.screenWidth
        height: window.screenHeight * (1/10)
        color: "grey"

        // Text input box
        SearchBox {
            id: message_input
            anchors { left: parent.left; leftMargin: 15; verticalCenter: parent.verticalCenter }
            width: parent.width * (3/4)
            height: parent.height * (5/6)
            default_text: ""
        }

        // Button to send
        Rectangle {
            id: send
            anchors { left: message_input.right; verticalCenter: parent.verticalCenter; leftMargin: 15 }
            width: parent.width * (1/5) - 15
            height: parent.height * (5/6) - 2
            border.color: "black"
            gradient: Gradient {
                GradientStop {
                    position: 0.00;
                    color: "#00e000";
                }
                GradientStop {
                    position: 1.00;
                    color: "#009914";
                }
            }
            Text {
                text: "Send"
                font.pixelSize: window.normalFont
                anchors.centerIn: parent
            }
            MouseArea {
                anchors.fill: parent;
                onClicked: postMessage()
            }
        }
    }

    BusySpinner {
        id: convoSpinner
        on: message_xml.status == XmlListModel.Loading
        anchors.centerIn: parent
    }

    // Call this function onClick in Home (when clicking on a conversation)
    function loadXML(){
        message_xml.source = "http://vocoloco.herokuapp.com/conversation/" + convo_id
        message_xml.reload()
    }

    // Sets the message content in the c++ object in httpManager
    function prepareMessage() {
        message_input.updateTitle()
        network.setNewMessageContent(message_input.title, convo_id)
    }

    // Post message to server
    function postMessage(){
        prepareMessage()
        network.postNewMessage();
        message_input.clear()
    }

    function playAudioDone() {
            convo_messages.currentItem.playStopped()
    }
}
