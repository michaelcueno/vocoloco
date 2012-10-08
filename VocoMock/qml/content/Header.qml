// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

// Header, this is on almost every screen
Rectangle {

    property string string: "Your Conversations"

    x: 0; y: 0; width: window.width; height: window.height * (1/10);
    gradient: Gradient {
        GradientStop {
            position: 0.00;
            color: "#339ab3";
        }
        GradientStop {
            position: 1.00;
            color: "#275375";
        }
    }

    Text {
        id: header_string
        text: string
        font.pixelSize: 35; font.bold: true
        anchors.top: parent.top; anchors.left: parent.left; anchors.margins: 30
    }



    // Using nested image here because I don't know another way to get transparency. I want the gradient to come through
    Image {
        id: newConvoBtn
        x: window.width * (2/3); y: 0
        anchors.top: parent.top; anchors.bottom: parent.bottom
        width: ((window.width * (1/3) * (1/2)) - 1)
        Image {
           source: "images/plus.png"
           anchors.centerIn: parent
           width: 100
           height: 100

        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                string = "Create New Conversation"
                changeScreen(newConvoScreen)
            }
        }

    }
    Rectangle {
        id: header_linebreak
        anchors.top: parent.top; anchors.bottom: parent.bottom; anchors.left: newConvoBtn.right
        width: 2
        opacity: .6
        color: "white"
    }
    Image {
        id: contactsBtn

        anchors.left: header_linebreak.right; anchors.top: parent.top; anchors.bottom: parent.bottom
        anchors.right: parent.right

        Image{
            source: "images/contacts.png"
            anchors.centerIn: parent
            width: 64
            height: 64
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
               string = "All Contacts"
               changeScreen(contactScreen)
            }
        }
    }
}
