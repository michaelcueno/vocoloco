
import QtQuick 1.1

XmlListModel {
    id: xml_conversations
    source: mainUrl + "conversations"
    query: "/conversations/child::element(conversation)"

 //   XmlRole { name: "number_new_messages"; query: "number_new_messages/string()" }
    XmlRole { name: "convo_id"; query: "id/string()" }
    XmlRole { name: "title"; query: "title/string()" }
    XmlRole { name: "createdby"; query: "createdby/string()" }
}
