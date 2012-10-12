// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

XmlListModel {
    id: xml_conversations
    source: "http://vocoloco.herokuapp.com/friends"
    query: "/conversations/conversation"

    XmlRole { name: "title_of_newest_message"; query: "title_of_newest_message/string()" }
    XmlRole { name: "user"; query: "user/name/string()" }
    XmlRole { name: "number_new_messages"; query: "number_new_messages/string()" }
    XmlRole { name: "userImage"; query: "user/image/string()" }
}
