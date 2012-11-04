// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {

    property string convo_id

    x: 0; y:window.height * (1/10); width: window.width; height: window.height * (9/10)  // Posistioning

    Text{
        text: "this is the conversations page"
    }

    MouseArea{
        anchors.fill: parent;
        onClicked: {
            changeHeader("Your Conversations")
            changeScreen(homeScreen)
        }
    }

    ListView {
        id: convo_messages
        anchors.fill: parent  // Posistioning
        maximumFlickVelocity: 2502
        clip: true;
        delegate: MessageDelegate {}
        model: message_xml
    }

    ScrollBar {
        scrollArea: convo_messages; height: convo_messages.height; width:10;
        anchors.right: convo_messages.right; anchors.top: convo_messages.top;
    }


    XmlListModel {

        id: message_xml
        query: "/conversation/child::element(messages)/message"

        XmlRole { name: "owner"; query: "sender/string()" }
        XmlRole { name: "userpic"; query: "userpic/string()" }
        XmlRole { name: "message_id"; query: "message_id/string()" }
        XmlRole { name: "message"; query: "message/string()"}
        XmlRole { name: "date"; query: "date/string()" }
    }

    // Call this function onClick in Home (when clicking on a conversation)
    function load(){
        message_xml.source = "http://vocoloco.herokuapp.com/conversation/" + convo_id
        message_xml.reload()
    }
}
