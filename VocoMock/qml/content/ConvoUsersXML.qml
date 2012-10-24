import QtQuick 1.1

XmlListModel {

    property string conversationId
    id: xml_convoUsers
    source: mainUrl + "conversations"
    query: "/conversations/child::element(conversation)[contains(id,'" + conversationId + "')]/user"

    XmlRole { name: "name"; query: "name/string()" }
    XmlRole { name: "image"; query: "url/string()" }

}
