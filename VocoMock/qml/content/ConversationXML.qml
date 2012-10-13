
import QtQuick 1.1

XmlListModel {
    id: xml_conversations
    source: mainUrl + "/friends"
    query: "/conversations/conversation"

    XmlRole { name: "title_of_newest_message"; query: "title_of_newest_message/string()" }
    XmlRole { name: "user"; query: "user/name/string()" }
    XmlRole { name: "number_new_messages"; query: "number_new_messages/string()" }
    XmlRole { name: "userImage"; query: "user/image/string()" }
}
