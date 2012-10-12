// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: container

    property string label
    property bool isPassword
    signal entered


    width: textInput.width + 70; height: textInput.height + 18

    BorderImage {
        anchors { fill: container; leftMargin: -6; topMargin: -6; rightMargin: -8; bottomMargin: -8 }
        source: 'images/box-shadow.png'; smooth: true
        border.left: 10; border.top: 10; border.right: 10; border.bottom: 10
    }

    Image { anchors.fill: parent; source: "images/cardboard.png"; smooth: true }

    TextInput {
        id: textInput; text: label; font.pixelSize: 15; anchors.centerIn: parent; smooth: true
    }

    // Border that is visible on clicked
    Rectangle {
        anchors.fill: container; border.color: "steelblue"; border.width: 4
        color: "transparent"; visible: textInput.focus; smooth: true
    }

    MouseArea {
        anchors { fill: parent; leftMargin: -20; topMargin: -20; rightMargin: -20; bottomMargin: -20 }
        onClicked: {
            textInput.forceActiveFocus();
            textInput.openSoftwareInputPanel();
            enteredd();

        }
    }

    function enteredd(){
        textInput.text = ""
        if (isPassword)
            textInput.echoMode = TextInput.Password;
        else
            textInput.echoMode = TextInput.Normal;
    }

}
