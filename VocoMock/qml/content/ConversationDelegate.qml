/****************************************************************************
 * Copyright (C) 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ****************************************************************************/

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

    function load(){
        convoUsersXML.loadXML()
    }

    signal convo_pressed()
    signal convo_normal()

    Component.onCompleted: {setTitle(); load()}

    //------------------------------- End of Logic Code ---------------------------------//

    Rectangle {
        id: convoUsers
        width: parent.width * (9/20);
        anchors {left: parent.left; top: parent.top; bottom:parent.bottom; topMargin: 10; bottomMargin: 10; leftMargin: 5;}

        Image {
            anchors.fill: parent;
            source: ":/images/egg_shell.png"
            fillMode: Image.Tile
        }

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

    Image {
        id: users_side
        source: ":/images/users_side.png"
        anchors.right: convoUsers.right
        anchors.top: convoUsers.top
    }

    Text {  // Message Title
        id: conversationTitle
        y: parent.height / 2 - 12
        anchors.left: convoUsers.right; anchors.leftMargin: 20;
        text: convo_title; width: parent.width * (7/20); wrapMode: Text.WordWrap
        font { bold: true; family: "Helvetica"; pixelSize: 25 }
    }

    Text {  // Number of new messages
        id: numNewMessages
        anchors.left: conversationTitle.right; anchors.leftMargin: 10;
        y: parent.height / 2 - 20
        width: 50
        text: new_messages;
        font { bold: true; italic: true; family: "Calibri"; pixelSize: 40 }
        horizontalAlignment: Text.AlignRight
    }

    Image {
        id: forwardArrow
        source: ":/images/forward.png"
        anchors {left: numNewMessages.right; leftMargin: 10;  }
        y: parent.height / 2 - 50
    }

    Rectangle { // Linebreak
        width: parent.width; height: 1; color: "#cccccc"
        anchors.bottom: parent.bottom
    }




// ----------------------------- Clickable Interactivity Code -----------------------//
    MouseArea {
        anchors { left: convoUsers.right; right:parent.right; top:parent.top; bottom:parent.bottom;}

//        onPressed: parent.state = "pressed"
//        onReleased: parent.state = "normal"

        onPressAndHold: {
            parent.state = "normal"
            homeScreen.pressed_convo(convo_id, title)
        }

        onClicked: {
            changeHeader(title)
            changeScreen(convoScreen)
            convoScreen.convo_id = convo_id
            convoScreen.loadXML()
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
            PropertyChanges { target: list_background; source: ""}
        }
    ]

    transitions: [
        Transition {
            from: "normal"
            to: "pressed"
            ColorAnimation {from: "white"; to: "lightsteelblue"; duration: 3000}
        }
    ]
//-------------------------------End of Clickable code -----------------------------//
}
