/****************************************************************************
 * Copyright (C) 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ****************************************************************************/


// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

/*
 * This file holds the markup for the creating a new conversation. On openeing this screen, the software keyboard
 *  Will come up and you can eneter a title. Then add users and create. If the title or users is empty, then an
 *  error will come up and the post to the server will not be made. Upon creation of a valid converstaion, the user
 *  is brought to that conversations focused view and is able to start creating messages within the conversation.
*/


Rectangle {
    id: container

    property int newConvoId

    x: 0; y:window.screenHeight * (1/10); width: window.screenWidth; height: window.screenHeight * (9/10)  // Posistioning

    Image {
        id: background
        anchors.fill: parent
        fillMode: Image.Tile
        source: ":/images/navy_blue.png"
    }


    Rectangle {
        id: titleHeader
        anchors.right: newConvoTitle.left; anchors.rightMargin: -10; anchors.top: newConvoTitle.top
        width: 100; height: 80
        radius: 10
        color: "black"
        Text {
            text: "Title"
            anchors.centerIn: parent
            font.pixelSize: 30
            color: "white"
        }
    }

    SearchBox {
        id: newConvoTitle;
        x: 150; y: 30; width: 500; height: 80;
        default_text: "Title your conversation..."
    }

    Rectangle { id: addUsersBtn; x: (container.width / 2) - (addUsersBtn.width / 2); y: 180;
        color: "#2881d3"
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#2869f5";
            }
            GradientStop {
                position: 1.00;
                color: "#01298d";
            }
        }

        width: window.screenWidth * 4/5; height: 80

        Text {
            anchors.centerIn: parent
            text: "Add Users"
            font.pixelSize: 35;
        }

        MouseArea {
            anchors.fill: parent
            onClicked: bringUpContacts()
        }

        border.width: 2
        border.color: "black"
    }

    Rectangle { id: submitBtn; x: (container.width / 2) - (addUsersBtn.width / 2); y: 320;
        color: "#1bd73d"
        border.color: "black"
        border.width: 2
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#15e812";
            }
            GradientStop {
                position: 1.00;
                color: "#038d08";
            }
        }
        width: window.screenWidth * 4/5; height: 80
        Text {
            anchors.centerIn: parent
            text: "Create"
            font.pixelSize: 35;
        }

        MouseArea {
            anchors.fill: parent
            onClicked: postToServer()
        }
    }

    Rectangle {
        id: error
        width: 200; height: 50
        color: "red"
        visible: false;
        anchors.top: submitBtn.bottom; anchors.topMargin: 20;
        Text {
            anchors.centerIn: parent
            text: "Error"
            font.pixelSize: 30;
        }
    }

    // Busy Spinner on until reply finishes
    BusySpinner {
        id: newConvoSpinner
        on: network.isLoading
        anchors.centerIn: parent

    }



    // Contacts Widget
    Rectangle {
        id: contactsWidget
        width: window.width; height: window.screenHeight
        x: 0; y: window.screenHeight - ((1/10 * window.screenHeight))
        Rectangle {
            id: topMenu
            color: "#ded4b9"
            height: 80; width: window.width

            Text {
                id: cancle
                text: "Cancle"
                font.pixelSize: 35;
                anchors { top: parent.top; topMargin: 20; left: parent.left; leftMargin: 30; }
                MouseArea {
                    anchors.fill: parent
                    onClicked: cancleWidget()
                }
            }
            Text {
                id: done
                text: "Done"
                font.pixelSize: 35;
                anchors { top: parent.top; topMargin: 20; right: parent.right; rightMargin: 30; }
                MouseArea {
                    anchors.fill: parent
                    onClicked: widgetDone()
                }
            }
        }

        Item { x: 0; y: 80; width: parent.width; height: window.height - 80;

            Contacts { id: contactsListWidget; anchors.fill: parent }

        }

        states : State {
            name: "ACTIVE"
            PropertyChanges { target: contactsWidget; y: 0 - ((1/10 * window.screenHeight)) }
        }

        transitions: Transition {
            NumberAnimation { properties: "y"; easing.type: Easing.OutExpo; duration: 1000 }
        }
    }



    function loadXML(){
        contactsListWidget.loadXML()
    }

    function setFocus(){
        newConvoTitle.setFocus()
    }

    function clearWidget() {
        contactsWidget.state = ""
        network.clearNewConvoUsers()
        contactsListWidget.clearCheckBoxes()
    }

    function cancleWidget() {
        clearWidget()
        changeScreen(homeScreen)
        showHeaderShadow()
    }

    function setTitle(){
        network.setNewConvoTitle(newConvoTitle.title.toString())
    }

    function bringUpContacts(){
        contactsWidget.state = "ACTIVE"
        hideHeaderShadow()
        newConvoTitle.unFocus()
    }

    function widgetDone(){
        contactsWidget.state = ""
        showHeaderShadow()
    }

    // Should post to server, wait for response, go to created conversatino focused view
    function postToServer(){
        newConvoTitle.updateTitle()
        setTitle()
        network.postNewConvo() // Send request to server. c++ signals will be triggered on completion and call goToConvo()
        clearWidget()
        newConvoTitle.clear()
    }

    function goToConvo(){
        newConvoId =  network.newConvoId
        console.log(newConvoId)
        changeScreen(convoScreen, newConvoId)
        changeHeader(newConvoTitle.title)
    }
}
