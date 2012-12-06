/****************************************************************************
 * Copyright (C) 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ****************************************************************************/
/**
  * This file is used in two places, firstly, in the contacts screen accessed by pressing on the
  * contacts icon in the header, and secondly in the new conversation creation screen when the
  * add users button is clicked, a version of this file will scroll up from the bottom
  */

import QtQuick 1.1



Rectangle {

    x: 0; y:window.screenHeight * (1/10); width: window.screenWidth; height: window.screenHeight * (9/10)  // Posistioning

    Image {
        id: background
        anchors.fill: parent
        fillMode: Image.Tile
        source: ":/images/carbon_fibre.png"
    }

    // List view for the contacts (uses ContactsDelegate for formatting)
    ListView {
        id: allContacts
        x: 0; y:0; width: window.width; height: parent.height  // Posistioning
        maximumFlickVelocity: 2502
        clip: true;
        delegate: ContactsDelegate {id: contactsDelegate}
        model: xml_contacts
        cacheBuffer:10000
    }

    ScrollBar {
        scrollArea: allContacts; height: allContacts.height; width:10;
        anchors.right: allContacts.right; anchors.top: allContacts.top;
    }

    /** Provides the XML model for the contacts list view
      * The XmlRole's name attribute can be used in the delegate and is used as an alias for the
      * data obtained by the xml at /contacts/contact/<attr>/string()
      */
    XmlListModel {

        id: xml_contacts
        query: "/contacts/contact"

        XmlRole { name: "username"; query: "username/string()" }
        XmlRole { name: "name"; query: "name/string()" }
        XmlRole { name: "image"; query: "url/string()" }
    }

    // Allows for delayed loading of the contacts (so that it doesn't slow down the app startup)
    function loadXML(){
        xml_contacts.source = mainUrl + "contacts"
    }

    // When contacts screen is left, the states should go back to original (check boxes => unchecked)
    function clearCheckBoxes(){
        for(var i = 0; i < allContacts.count; i++){
            allContacts.currentIndex = i;
            allContacts.currentItem.unCheck()
        }
    }
}

