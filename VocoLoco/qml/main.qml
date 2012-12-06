/****************************************************************************
 * Copyright (C) 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ****************************************************************************/


import QtQuick 1.1
import 'content'

// Main window of application -----------//
Rectangle {
    id: window
    width: 720; height: 1280;
    objectName: "mainObj";


    property string mainUrl: "https://vocoloco.herokuapp.com/"

    property int screenWidth
    property int screenHeight

    property int smallFont: 20
    property int normalFont: 30

    //--- Visual components --------- |


    Settings { id: settingsScreen; visible: true }


    /**
     * This Item holds all the main screens for the application. Each screen is defined in its own
     * QML file and thus can be referenced by the QML file name.
     */
    Item {
        id: container
        x: 0; y: 0;
        width: screenWidth;
        anchors.top: parent.top;
        anchors.bottom: parent.bottom

        Header {  id: header;  visible: false }

        Login { id: loginScreen; objectName: "loginObj"; visible: true }

        Home { id: homeScreen; objectName: "homeObj"; visible: false; }

        Convo { id: convoScreen; objectName: "convoObj"; visible: false  }

        NewConvo { id: newConvoScreen; objectName: "newConvoObj"; visible: false  }

        Contacts { id: contactScreen;  visible: false }

        Record {id: recordScreen; anchors.fill: parent; visible: false}

        // Shadow underneath header
        Image {
            id: header_shadow
            width: window.screenWidth
            source: ":/qml/content/images/header-shadow.png"
            anchors.top: header.bottom
            fillMode: Image.TileHorizontally
            visible: false
        }

        MouseArea {
            id: comeBackFromSettings
            anchors.fill: parent;
            enabled: false
            onClicked: parent.state = ""
            onPressed: parent.state = ""
        }

        states: State {
            name: "InSettings"
            PropertyChanges { target: container; x: -400; }
            PropertyChanges { target: comeBackFromSettings; enabled: true }
        }

        transitions: Transition {
            NumberAnimation { properties: "x"; easing.type: Easing.OutExpo; duration: 1000 }
        }
    }

    // TestScreen {id: audioTest; anchors.fill: parent; visible: true}


    //---- End of visual comonents ----- |

    //--- Functions non visual ------------------ |


    // ------ Development test code -------|
    function test(){
        changeScreen(testScreen)
    }

    // ------------- end of test code ----------|

    //Uncomment next line for auto login from saved cookie
    Component.onCompleted: {
        setDimensions()
        checkForSavedCookies()
    }

    function checkForSavedCookies()
    {
        if(network.hasSavedCookie()){
            changeScreen(homeScreen)
            loadXML()
            // TODO BUG: deletes cookie on second opening of application.
        }
    }

    function hideHeaderShadow() // For use when widgets come up and cover the whole screen (otherwise this will show through)
    {
        header_shadow.visible = false;
    }
    function showHeaderShadow()  // to restore state
    {
        header_shadow.visible = true;
    }

    function changeScreen(screen, id){

        if(newConvoScreen.visible)
            var fromNewConvo = true

        header.visible = true;
        homeScreen.visible = false;
        recordScreen.visible = false;
        convoScreen.visible = false;
        newConvoScreen.visible = false;
        contactScreen.visible = false;
        loginScreen.visible = false;
        screen.visible = true;

        header_shadow.visible = true;

        if(homeScreen.visible){
            changeHeader("All Conversations");
            header.unHideBtns()
            header.unHideSettings()
        }

        if(newConvoScreen.visible){
            newConvoScreen.setFocus()
            header.hideBtns()
            header.hideSettings()
        }

        if(convoScreen.visible && fromNewConvo){
            convoScreen.convo_id = id
            convoScreen.loadXML()
        }

        if(convoScreen.visible){
            header.unHideSettings()
            settingsScreen.enableConvo()
        }

        if(contactScreen.visible) {
            header.hideSettings()
        }
    }

    function changeHeader(msg){
        header.headerTitle = msg
        header.visible = true;
    }

    function loadXML(){
        homeScreen.loadXML()
        contactScreen.loadXML()
        newConvoScreen.loadXML()
    }

    // Set screen width and height for some static properties that will not resize on soft keyboard invokation
    function setDimensions(){
        screenHeight = window.height - 140
        screenWidth = window.width
        console.log(screenHeight)
        console.log(screenWidth)
    }

    // TODO Would be better if this goes to login screen but.. Getting a seg fault with next login so for now just quit app
    function logout(){
        network.logout()
        Qt.quit()
    }

    // Shows the settings panel (pushes whatever is on the screen left)
    function showSettings() {
        container.state = "InSettings"

        if(homeScreen.visible)
            settingsScreen.enableHome()
    }

    function hideSettings() {
        container.state = ""

        if(homeScreen.visible)
            settingsScreen.disableHome()
    }
}