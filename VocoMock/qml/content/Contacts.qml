/****************************************************************************
 * Copyright (C) 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ****************************************************************************/


import QtQuick 1.1



Rectangle {

    signal showScreen(string msg)

    x: 0; y:window.screenHeight * (1/10); width: window.screenWidth; height: window.screenHeight * (9/10)  // Posistioning

    Image {
        id: background
        anchors.fill: parent
        fillMode: Image.Tile
        source: ":/images/carbon_fibre.png"
    }

    ListView {
        id: allContacts
        x: 0; y:0; width: window.width; height: parent.height  // Posistioning
        maximumFlickVelocity: 2502
        clip: true;
        delegate: ContactsDelegate {id: contactsDelegate}
        model: xml_contacts
    }

    ScrollBar {
        scrollArea: allContacts; height: allContacts.height; width:10;
        anchors.right: allContacts.right; anchors.top: allContacts.top;
    }

    XmlListModel {

        id: xml_contacts
        query: "/contacts/contact"

        XmlRole { name: "username"; query: "username/string()" }
        XmlRole { name: "name"; query: "name/string()" }
        XmlRole { name: "image"; query: "url/string()" }
    }

    function loadXML(){
        xml_contacts.source = mainUrl + "contacts"
    }

    function clearCheckBoxes(){
        for(var i = 0; i < allContacts.count; i++){
            allContacts.currentIndex = i;
            allContacts.currentItem.unCheck()
        }
    }
}

