import QtQuick 1.1

XmlListModel {

    property string conversationId
    id: xml_convoUsers

    query: "/conversations/conversation[@id=\"" + conversationId + "\"]/members/member"

    XmlRole { name: "name"; query: "name/string()" }
    XmlRole { name: "image"; query: "url/string()" }

    function loadXML(){
        xml_convoUsers.source = mainUrl + "conversations"
        xml_convoUsers.reload()
    }
}
