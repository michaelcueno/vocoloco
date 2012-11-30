
import QtQuick 1.1

// Header, this is on almost every screen
Rectangle {

    property string headerTitle: "Your Conversations"

    x: 0; y: 0; width: window.screenWidth; height: window.screenHeight * (1/10);
    color: "#ded4b9"

    Image {
        id: background
        anchors.fill: parent
        fillMode: Image.Tile
        source: ":/images/egg_shell.png"
    }

    Text { // Header title
        id: header_string
        text: headerTitle
        font.pixelSize: 35; font.bold: true
        anchors { verticalCenter: parent.verticalCenter; left: parent.left; }
    }

    Rectangle { // Line break in header
        id: header_linebreak1
        anchors.top: parent.top; anchors.bottom: parent.bottom; anchors.right: newConvoBtn.left; anchors.rightMargin: 0;
        width: 2
        opacity: .6
        color: "black"
    }

    Image {  // New Coversation Button (top right of header)
        id: newConvoBtn
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: header_linebreak.left; anchors.rightMargin: 10;
        width: 100; height: 100;

        Image {  // Using nested image here because I don't know another way to get transparency. I want the gradient to come through
           id: plus_img
           source: "images/plus.png"
           anchors.centerIn: parent
           width: 100
           height: 100

        }
        MouseArea{
            id: new_convo_mouse_area
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
            PropertyChanges { target: new_convo_mouse_area; enabled: false }
        }
/*
        transitions: Transition{
            from: ''; to: "HIDDEN"
            PropertyAnimation { properties: "opacity"; easing.type: Easing.InQuad; easing.period: 2.5}
        }
        */
    }

    Rectangle { // Line break in header
        id: header_linebreak
        anchors.top: parent.top; anchors.bottom: parent.bottom; anchors.right: contactsBtn.left; anchors.rightMargin: 15;
        width: 2
        opacity: .6
        color: "black"
    }

    Image { // Contacts Button at top right hand corner
        id: contactsBtn
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: settingsBtn.left; anchors.rightMargin: 10
        width: 100
        height: 100

        Image{
            id: contacts_img
            source: ":/images/contacts.png"
            anchors.centerIn: parent
            width: 100
            height: 100
        }

        MouseArea{
            id: contacts_mouse_area
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
            PropertyChanges { target: contacts_mouse_area; enabled: false }
        }
/*
        transitions: Transition{
            from: ''; to: "HIDDEN"
            PropertyAnimation { properties: "opacity"; easing.type: Easing.InQuad; easing.period: 2.5}
        }
*/
    }

    Rectangle { // Line break in header
        id: header_linebreak2
        anchors.top: parent.top; anchors.bottom: parent.bottom; anchors.right: settingsBtn.left; anchors.rightMargin: 0;
        width: 2
        opacity: .6
        color: "black"
    }

    Image { // Settings Button at top right hand corner
        id: settingsBtn
        anchors.verticalCenter: parent.verticalCenter
        x:window.width-105
        y: 20
        width: 100
        height: 100

        Image{
            id: settings_img
            source: ":/images/settings.png"
            anchors.centerIn: parent
            width: 100
            height: 100
        }

        MouseArea{
            id: settings_mouse_area
            anchors.fill: parent
            onClicked: {
               showSettings()
            }
        }
        states: State {
            name: "HIDDEN"
            PropertyChanges { target: settings_img; y: -40; opacity: 0}
            PropertyChanges { target: settings_mouse_area; enabled: false }
            PropertyChanges { target: header_linebreak2; visible: false }
        }
/*
        transitions: Transition{
            from: ''; to: "HIDDEN"
            PropertyAnimation { properties: "opacity"; easing.type: Easing.InQuad; easing.period: 2.5}
        }
        */
    }

    Image { // Back Button
        id: backBtn
        x: -40
        y: 20
        width: 64
        height: 64
        opacity: 0
        anchors.verticalCenter: parent.verticalCenter

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
        header_linebreak1.visible = false
    }

    function unHideBtns(){
        contactsBtn.state = ""
        newConvoBtn.state = ""
        backBtn.state = ""
        header_string.anchors.leftMargin = 30
        header_linebreak.visible = true
        header_linebreak1.visible = true
    }

    function hideSettings(){
        settingsBtn.state = "HIDDEN"
    }

    function unHideSettings(){
        settingsBtn.state = ""
    }
}
