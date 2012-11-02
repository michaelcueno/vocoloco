// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item{
    ListView {
        id: allConversations
        x: 0; y:window.height * (1/10); width: window.width; height: window.height * (9/10)  // Posistioning
        maximumFlickVelocity: 2502
        clip: true;
        delegate: ConversationDelegate {id: conversationDelegate}
        model: xml_conversations
    }

    ScrollBar {
        scrollArea: allConversations; height: allConversations.height; width:10;
        anchors.right: allConversations.right; anchors.top: allConversations.top;
    }

    function reload(){
        xml_conversations.reload()
        conversationDelegate.reloadUsersXml()
    }

    XmlListModel {

        id: xml_conversations
        source: network.path //  // mainUrl + "conversations"
        query: "/conversations/child::element(conversation)"

       // XmlRole { name: "new_messages"; query: "number_new_messages/string()" }
        XmlRole { name: "convo_id"; query: "id/string()" }
        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "createdby"; query: "createdby/string()" }
        XmlRole { name: "date"; query: "date/string()" }

    }

}