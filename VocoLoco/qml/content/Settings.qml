/****************************************************************************
** Copyright (C) 2012 Michael Cueno
** Contact: mcueno2@uic.edu
*****************************************************************************/
/**
  * This is the settings screen that rests behind the application windows. This makes it visible when the
  * main application screens are moved to the side.
  *
  * This file contains:
  *     o Logout option
  *     o Update homescreen and conversation screen  options
  *     o Options to add users to conversations (not implemented yet in server)
  */

import QtQuick 1.1

Item {
    anchors.fill: parent; // This will fill the entire screen

    Image {
        id: background
        anchors.fill: parent
        fillMode: Image.Tile
        source: ":/images/twinkle_twinkle.png"
    }

    Text {
        id: header
        anchors { right: parent.right; top: parent.top; topMargin: 30; rightMargin: 120 }
        text: "Settings"
        font.bold: true
        font.pixelSize: 42
        color: "white"
    }

    Rectangle {   // The "Settings" text at the top of the settings screen
        id: linebreak
        color: "grey"
        width: 400; height: 2;
        anchors { top: header.bottom; right: parent.right; topMargin: 43 }
    }

    Item {   // This holds the first menu option
        id: button1
        anchors.top: linebreak.bottom
        anchors.right: parent.right;
        width: 400
        height: 100

        SettingsOption {  // Update the Convo Screen
            id: update_convo_option
            title: "Update"
            active: false
            onSettingClicked: {
                hideSettings()
                convoScreen.loadXML()
            }
            visible: false
        }

        SettingsOption {  // Logout
            id: logout_option
            title: "Logout"
            active: true
            onSettingClicked: {
                hideSettings()
                hideHeaderShadow()
                logout()
            }
        }
    }

    Rectangle {
        id: linebreak2
        color: "grey"
        width: 400; height: 2;
        anchors { top: button1.bottom; right: parent.right; }
    }

    Item {  // This holds the second menu option

        id: button2
        anchors.top: linebreak2.bottom
        anchors.right: parent.right;
        width: 400
        height: 100

        SettingsOption {  // Add Contact to Conversation
            id: addContactToConveration
            title: "Add Contact"
            active: false
            onSettingClicked: {
                hideSettings()
                console.log("TODO: Implement add contact to conversation");
            }
            visible: false
        }

        SettingsOption {  // Update Home Screen
            id: update_option
            title: "update"
            active: true
            onSettingClicked: {
                hideSettings()
                homeScreen.loadXML()
            }
        }

    }

    Rectangle {
        id: linebreak3
        color: "grey"
        width: 400; height: 2;
        anchors { top: button2.bottom; right: parent.right; }
    }


    ///////////////////// NON VISUAL CODE ///////////////////////

    // For HomeScreen Settings
    function enableHome() {
        disableConvo()
        update_option.active = true
        logout_option.active = true
        update_option.visible = true
        logout_option.visible = true
    }

    function disableHome() {
        update_option.active = false
        logout_option.active = false
        update_option.visible = false
        logout_option.visible = false
    }

    // For Conversation View Settings
    function enableConvo(){
        disableHome()
        update_convo_option.active = true
        addContactToConveration.active = true
        update_convo_option.visible = true
        addContactToConveration.visible = true
    }

    function disableConvo(){
        update_convo_option.active = false;
        addContactToConveration.active = false

    }
}
