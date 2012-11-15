/*
 * This is the view of the conversations, I called it "home" since it is the first screen a user
 * will see when they log in, also all screens are one away from this screen and they all go back
 * to this screen.
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

    XmlListModel {

        id: xml_conversations

        query: "/conversations/conversation"

        // XmlRole { name: "new_messages"; query: "number_new_messages/string()" }
        XmlRole { name: "convo_id"; query: "string(@id)" }
        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "createdby"; query: "createdby/string()" }
        XmlRole { name: "date"; query: "date/string()" }
    }


    Image {
        id: shader
        source: ":/images/shade.png"
        anchors.fill: parent
        fillMode: Image.Tile
        visible: false
    }

    Rectangle {
        id: deleteConvo
        anchors.centerIn: parent
        color: "red"
        width: 100
        height: 50
        Text{ text: "delete?" }
        visible: false

        MouseArea {
            anchors.fill: parent
            onClicked: {
                network.deleteConvo(convoToDelete)
                shader.visible = false
                deleteConvo.visible = false
            }
        }
    }

    function pressed_convo(convo_id){
        shader.visible = true
        deleteConvo.visible = true
        convoToDelete = convo_id
    }

    property string convoToDelete   // needed so that convo_id can be passed along to the mouse area on the delete button

    function loadXML(){
        xml_conversations.source = mainUrl + "conversations"
        xml_conversations.reload()
        console.log(network.username)
    }
}
