import QtQuick 1.1

Rectangle {

    signal showScreen(string msg)

    x: 0; y:window.height * (1/10); width: window.width; height: window.height * (9/10)  // Posistioning

    Image {
        id: background
        anchors.fill: parent
        fillMode: Image.TileVertically
        source: ":/images/background.png"
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

    function load(){
        xml_contacts.source = mainUrl + "contacts"
    }

    XmlListModel {

        id: xml_contacts
        query: "/contacts/contact"

        XmlRole { name: "username"; query: "username/string()" }
        XmlRole { name: "name"; query: "name/string()" }
        XmlRole { name: "image"; query: "url/string()" }

    }




}
