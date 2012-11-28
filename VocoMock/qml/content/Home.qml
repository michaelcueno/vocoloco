/*
 * This is the view of the conversations, I called it "home" since it is the first screen a user
 * will see when they log in, also all screens are one away from this screen and they all go back
 * to this screen.
 *
 * CONTAINED IN THIS FILE:
 *  1. All conversations beloging to the logged in user in a list view
 *  2. The delete Conversation button, when a conversation is pressed and held this will become visible
 */

import QtQuick 1.1

Item{

    id: container
    x: 0; y:window.screenHieght * (1/10); width: window.screenWidth; height: window.screenHieght * (9/10)  // Posistioning

    Image {
        id: background
        anchors.fill: parent
        fillMode: Image.Tile
        source: ":/images/carbon_fibre.png"
    }

    ListView {
        id: allConversations
        x: 0; y:0; width: window.width; height: parent.height  // Posistioning
        maximumFlickVelocity: 2502
        clip: true;
        delegate: ConversationDelegate {}
        model: xml_conversations
    }


    ScrollBar {
        scrollArea: allConversations; height: allConversations.height; width:10;
        anchors.right: allConversations.right; anchors.top: allConversations.top;
    }

    XmlListModel { // Provides data for conversation listmodel

        id: xml_conversations

        query: "/conversations/conversation"

        XmlRole { name: "new_messages"; query: "msg_count/string()" }
        XmlRole { name: "convo_id"; query: "string(@id)" }
        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "createdby"; query: "createdby/string()" }
        XmlRole { name: "date"; query: "date/string()" }
    }

    Image {  // Shader for when delete button comes up
        id: shader
        source: ":/images/shade.png"
        anchors.fill: parent
        fillMode: Image.Tile
        visible: false
    }

    BusySpinner {
        id: homeSpinner
        on: xml_conversations.status == XmlListModel.Loading
        anchors.centerIn: parent

    }

    Rectangle {     // -------------------- Delete Button that pops up on conversation pressed -------|
        id: deleteConvo
        anchors.centerIn: parent
        color: "#1a7fdd"
        width: screenWidth * 2/3
        height: screenHieght * 1/4
        visible: false

        Text {
            id: you_sure
            style: Text.Raised; font.pointSize: 30
            text: "Do you want to delete"
            anchors.leftMargin: 10
        }
        Text {
            anchors.top: you_sure.bottom;
            text: convoToDelete_title
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 30
            anchors.leftMargin: 10
        }

        Rectangle {
            id: deleteBtn
            width: parent.width * .45
            height: 70;
            color: "#d32020"

            anchors { left: parent.left; leftMargin: 10; bottom: parent.bottom; bottomMargin: 10}
            Text {
                anchors.centerIn: parent
                text: "Delete"
                font.pixelSize: 30
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    network.deleteConvo(convoToDelete_id)
                    shader.visible = false
                    deleteConvo.visible = false
                }
            }
        }

        Rectangle {
            id: cancle
            width: parent.width * .45
            height: 70;
            color: "#b1c0c8"
            anchors { right: parent.right; rightMargin: 10; bottom: parent.bottom; bottomMargin: 10}
            Text {
                anchors.centerIn: parent
                text: "Cancle"
                font.pixelSize: 30
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    shader.visible = false
                    deleteConvo.visible = false
                }
            }
        }


    }

    /**
      This function darkens the covo view and brings up the delete button
      TODO: Should make all functionality of normal homescreen inactive.
    */
    function pressed_convo(convo_id, convo_title){
        shader.visible = true
        deleteConvo.visible = true
        convoToDelete_id = convo_id
        convoToDelete_title = convo_title
    }

    property string convoToDelete_id   // needed so that convo_id can be passed along to the mouse area on the delete button
    property string convoToDelete_title

    function loadXML(){
        xml_conversations.source = mainUrl + "conversations"
        xml_conversations.reload()
    }
}
