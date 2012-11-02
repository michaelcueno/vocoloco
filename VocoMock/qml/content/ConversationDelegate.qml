import QtQuick 1.1

Rectangle {
    id: row
    width: parent.width
    height: 180
    color: "#ffffff"


    //------------------------------- Non-Visual Logic Code -----------------------------//

        property string convo_title;
        function setTitle(){
            var slicedTitle = title;   // XMLRole defined property

            if(title.length > 19 ){
                slicedTitle = title.slice(0,16).concat("...");
            }

            convo_title = slicedTitle;
        }

        function reloadUsersXml(){
            convoUsersXML.reload()
        }


        Component.onCompleted: setTitle()
    //------------------------------- End of Logic Code -----------------------------//

    Rectangle {
        id: convoUsers
        width: parent.width * (9/20);
        anchors {left: parent.left; top: parent.top; bottom:parent.bottom; topMargin: 5; bottomMargin: 5; leftMargin: 5;}
        color: "#c0c9d1"
        ListView {
            id: convoUsersList
            anchors.fill:parent
            maximumFlickVelocity: 2502
            clip: true;
            orientation: ListView.Horizontal
            delegate: ConvoUsersDelegate {}
            model: ConvoUsersXML { id: convoUsersXML; conversationId: convo_id}
        }

    }
  /*  BorderImage {
        anchors { fill: convoUsers; leftMargin: -6; topMargin: -6; rightMargin: -8; bottomMargin: -8 }
        source: ':/qml/content/images/box-shadow.png'; smooth: true
        border.left: 10; border.top: 10; border.right: 10; border.bottom: 10

    } */

    Text {  // Message Title
        id: conversationTitle
        y: parent.height / 2 - 12
        anchors.left: convoUsers.right; anchors.leftMargin: 20;
        text: convo_title; width: parent.width * (7/20); wrapMode: Text.WordWrap
        font { bold: true; family: "Helvetica"; pixelSize: 25 }

    }

/* TODO awaiting server side implementation */
    Text {  // Number of new messages
        id: numNewMessages
        anchors.left: conversationTitle.right; anchors.leftMargin: 20;
        y: parent.height / 2 - 20
        text: "0" // new_messages;
        font { bold: true; italic: true; family: "Calibri"; pixelSize: 40 }

    }

    Image {
        source: ":/qml/content/images/convoNext.png"
        anchors {left: numNewMessages.right; leftMargin: 15;  }
        y: parent.height / 2 - 50
    }

    Rectangle { // Linebreak
        width: parent.width; height: 1; color: "#cccccc"
        anchors.bottom: parent.bottom
    }


// ----------------------------- Clickable Interactivity Code -----------------------//
    MouseArea {
        anchors { left: convoUsers.right; right:parent.right; top:parent.top; bottom:parent.bottom;}
        onPressAndHold: parent.state = "pressed"
        onClicked: {
            changeHeader(title)
            changeScreen(convoScreen)
            convoScreen.convo_id = convo_id
            convoScreen.load()
            header.hideBtns()
        }
    }

    states: [
        State {
            name: "normal"
            PropertyChanges { target: row; color: "white"}
        },
        State {
            name: "pressed"
            PropertyChanges { target: row; color: "lightsteelblue"}
        }
    ]

    transitions: [
        Transition {
            from: "pressed"
            to: "normal"
            ColorAnimation { target: row; duration: 300}
        }
    ]
//-------------------------------End of Clickable code -----------------------------//

}
