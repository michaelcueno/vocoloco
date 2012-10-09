import QtQuick 1.1

import 'content'

// Main window of application -----------//
Rectangle {
    id: window
    width: 720; height: 1280

    //--- Visual components ---------

    Header {  id: header }

    Login { id: loginScreen; anchors.fill: parent;  visible: true }

    Home { id: homeScreen; visible: false; }

    Convo { id: convoScreen; visible: false; }

    NewConvo { id: newConvoScreen; visible: false; }

    ContactScreen { id: contactScreen; visible: false; }

    //---- End of visual comonents -----

    // Element wrapper for network management



    //--- Functions non visual ------------------

    function changeScreen(screen){

        homeScreen.visible = false;
        convoScreen.visible = false;
        newConvoScreen.visible = false;
        contactScreen.visible = false;
        loginScreen.visible = false;

        screen.visible = true;
    }

    function changeHeader(msg){
        header.string = msg
        header.visible = true;
    }




}
