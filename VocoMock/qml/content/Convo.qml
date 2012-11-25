// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {

    property string convo_id

    x: 0; y:window.screenHieght * (1/10); width: window.screenWidth; height: window.screenHieght * (9/10)  // Posistioning


    Image {
        id: background
        anchors.fill: parent
        fillMode: Image.Tile
        source: ":/images/carbon_fibre.png"
    }

    MouseArea{
        anchors.fill: parent;
        onClicked: {
            changeHeader("Your Conversations")
            changeScreen(homeScreen)
        }
    }

    ListView {
        rotation: 180;
        id: convo_messages
        width: window.screenWidth
        height: parent.height - new_message_input.height
        maximumFlickVelocity: 2502
        clip: true;
        delegate: MessageDelegate {id: message_delegate}
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

    Rectangle {
        id: new_message_input
        anchors.bottom: parent.bottom
        width: window.screenWidth
        height: window.screenHieght * (1/10)
        color: "grey"

        SearchBox {
            id: message_input
            anchors { left: parent.left; leftMargin: 30; verticalCenter: parent.verticalCenter }
            width: parent.width * (3/4)
            height: parent.height * (5/6)
        }

        Rectangle {
            id: send
            anchors { left: message_input.right; verticalCenter: parent.verticalCenter; leftMargin: 15 }
            width: parent.width * (1/5) - 40
            height: parent.height * (5/6)
            color: "green"
            Text {
                text: "Send"
                font.pixelSize: window.normalFont
                anchors.centerIn: parent
            }
        }
    }

    // Call this function onClick in Home (when clicking on a conversation)
    function loadXML(){
        message_xml.source = "http://vocoloco.herokuapp.com/conversation/" + convo_id
        message_xml.reload()
    }
}
