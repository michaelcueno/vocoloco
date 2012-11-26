// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

/*
 * This file holds the markup for the creating a new conversation. On openeing this screen, the software keyboard
 *  Will come up and you can eneter a title. Then add users and create. If the title or users is empty, then an
 *  error will come up and the post to the server will not be made. Upon creation of a valid converstaion, the user
 *  is brought to that conversations focused view and is able to start creating messages within the conversation.
*/


Rectangle {

     x: 0; y:window.screenHieght * (1/10); width: window.screenWidth; height: window.screenHieght * (9/10)  // Posistioning

    Image {
        id: background
        anchors.fill: parent
        fillMode: Image.Tile
        source: ":/images/carbon_fibre.png"
    }

    SearchBox { id: newConvoTitle; x: 60; y: 30; width: 600; height: 80; }

    Rectangle { id: addUsersBtn; x: (parent.width / 2) - (addUsersBtn.width / 2); y: 160;
        color: "#c04b4b"
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
    }

    Rectangle { id: submitBtn; x: (parent.width / 2) - (addUsersBtn.width / 2); y: 320;
        color: "#1bd73d"
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



    // Contacts Widget
    Rectangle {
        id: contactsWidget
        width: window.width; height: window.screenHieght
        x: 0; y: window.screenHieght - ((1/10 * window.screenHieght))
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

        Item { id: container; x: 0; y: 80; width: parent.width; height: window.height - 80;

            Contacts { id: contactsListWidget; anchors.fill: parent }

        }

        states : State {
            name: "ACTIVE"
            PropertyChanges { target: contactsWidget; y: 0 - ((1/10 * window.screenHieght)) }
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

    function cancleWidget() {
        contactsWidget.state = ""
        network.clearNewConvoUsers()
        contactsListWidget.clearCheckBoxes()
        changeScreen(homeScreen)
        showHeaderShadow()
    }

    function setTitle(){
        network.setNewConvoTitle(newConvoTitle.title)
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
        if( network.postNewConvo() ){
            changeScreen(convoScreen, network.newConvoId())
        } else {
            error.visible = true
        }
    }
}
