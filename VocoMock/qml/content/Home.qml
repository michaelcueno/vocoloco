// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item{

    x: 0; y:window.height * (1/10); width: window.width; height: window.height * (9/10)  // Posistioning

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

    function load(){
        xml_conversations.source = mainUrl + "conversations"
        xml_conversations.reload()     
    }

    XmlListModel {

        id: xml_conversations

        query: "/conversations/child::element(conversation)"

        // XmlRole { name: "new_messages"; query: "number_new_messages/string()" }
        XmlRole { name: "convo_id"; query: "id/string()" }
        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "createdby"; query: "createdby/string()" }
        XmlRole { name: "date"; query: "date/string()" }
    }
}
