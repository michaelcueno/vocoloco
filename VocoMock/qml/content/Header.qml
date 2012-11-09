
import QtQuick 1.1

// Header, this is on almost every screen
Rectangle {

    property string headerTitle: "Your Conversations"

    x: 0; y: 0; width: window.screenWidth; height: window.screenHieght * (1/10);
    color: "#ded4b9"

    Text {
        id: header_string
        text: headerTitle
        font.pixelSize: 35; font.bold: true
        anchors.top: parent.top; anchors.left: parent.left; anchors.margins: 30
    }

    // Using nested image here because I don't know another way to get transparency. I want the gradient to come through
    Image {
        id: newConvoBtn
        x: window.width * (2/3); y: 20
      //  anchors.top: parent.top; anchors.bottom: parent.bottom
        width: ((window.width * (1/3) * (1/2)) - 1)
        height: 64
        Image {
           id: plus_img
           source: "images/plus.png"
           anchors.centerIn: parent
           width: 100
           height: 100

        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                headerTitle = "Create New Conversation"
                changeScreen(newConvoScreen)
                hideBtns()
            }
        }
        states: State {
            name: "HIDDEN"
            PropertyChanges { target: plus_img; y: -40; opacity: 0}
        }

        transitions: Transition{
            from: ''; to: "HIDDEN"
            PropertyAnimation { properties: "opacity"; easing.type: Easing.InQuad; easing.period: 2.5}
        }

    }
    Rectangle {
        id: header_linebreak
        anchors.top: parent.top; anchors.bottom: parent.bottom; anchors.left: newConvoBtn.right
        width: 2
        opacity: .6
        color: "white"
    }

    // Contacts Button at top right hand corner
    Image {
        id: contactsBtn

        x:window.width-100
        y: 20
        width: 64
        height: 64

        Image{
            id: contacts_img
            source: "images/contacts.png"
            anchors.centerIn: parent
            width: 64
            height: 64
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
               headerTitle = "All Contacts"
               changeScreen(contactScreen)
               hideBtns()
            }
        }
        states: State {
            name: "HIDDEN"
            PropertyChanges { target: contacts_img; y: -40; opacity: 0}
        }

        transitions: Transition{
            from: ''; to: "HIDDEN"
            PropertyAnimation { properties: "opacity"; easing.type: Easing.InQuad; easing.period: 2.5}
        }
    }

    // Back Button -----------------------------------------------------------------------------------------------------

    Image {
        id: backBtn
        x: -40
        y: 20
        width: 64
        height: 64
        opacity: 0

        Image{
            id: backBtn_img
            source: ":/images/back_black.png"
            anchors.centerIn: parent
            width: 40
            height: 70
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
               unHideBtns()
               changeScreen(homeScreen)
                homeScreen.loadXML()
            }
        }
        states: State { name: "ACTIVE"; PropertyChanges { target: backBtn; opacity: 1; x:0 } }
        transitions: Transition {
            from: ""; to: "ACTIVE"
            PropertyAnimation { properties: "opacity"; easing.type: Easing.InQuad; easing.period: 2.5}
            NumberAnimation { properties: "x"; easing.type: Easing.InQuad; easing.period: 2.5 }
        }
    }

    function hideBtns(){
        contactsBtn.state = "HIDDEN"
        newConvoBtn.state = "HIDDEN"
        backBtn.state = "ACTIVE"
        header_string.anchors.leftMargin = 60
        header_linebreak.visible = false
    }

    function unHideBtns(){
        contactsBtn.state = ""
        newConvoBtn.state = ""
        backBtn.state = ""
        header_string.anchors.leftMargin = 30
        header_linebreak.visible = true
    }
}
