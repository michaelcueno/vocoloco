import QtQuick 1.1

XmlListModel {

    property string conversationId
    id: xml_convoUsers

    query: "/conversations/child::element(conversation)[contains(id,'" + conversationId + "')]/members/member"

    XmlRole { name: "name"; query: "name/string()" }
    XmlRole { name: "image"; query: "url/string()" }

    function load(){
        xml_convoUsers.source = mainUrl + "conversations"
        xml_convoUsers.reload()
    }
}
