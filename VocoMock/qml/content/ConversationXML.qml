
import QtQuick 1.1

XmlListModel {

    id: xml_conversations
    source: network.path // ":/xml/conversations.xml"  // mainUrl + "conversations"
    query: "/conversations/child::element(conversation)"

   // XmlRole { name: "new_messages"; query: "number_new_messages/string()" }
    XmlRole { name: "convo_id"; query: "id/string()" }
    XmlRole { name: "title"; query: "title/string()" }
    XmlRole { name: "createdby"; query: "createdby/string()" }
    XmlRole { name: "date"; query: "date/string()" }

}
