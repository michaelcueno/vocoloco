import QtQuick 1.1

import 'content'

// Main window of application -----------//
Rectangle {
    id: window
    width: 720; height: 1280


    Header {  id: header }

    Home { id: homeScreen; visible: true; }

    Convo { id: convoScreen; visible: false; }

    NewConvo { id: newConvoScreen; visible: false; }

    ContactScreen { id: contactScreen; visible: false; }

    function changeScreen(screen){

        homeScreen.visible = false;
        convoScreen.visible = false;
        newConvoScreen.visible = false;
        contactScreen.visible = false;

        screen.visible = true;
    }

    function changeHeader(msg){
        header.string = msg
    }




}
