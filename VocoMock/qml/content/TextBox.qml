// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: container

    property string label     // Initial text in grey
    property bool isPassword  // sets field to use *** instead of chars
    property string input     // property for accessing user input
    property int cornerRadius // rounded edges

    Connections {
        target: loginScreen
        onSubmitted: setInput();
    }


    //width: textInput.width + 70; height: textInput.height + 18
    smooth: true;
    radius: cornerRadius

    TextInput {
        id: textInput;
        text: label;
        font { pixelSize: 30; italic:true; } color: "grey"
        anchors.centerIn: parent;
        smooth: true;
    }

    // Border that is visible on clicked
    Rectangle {
        anchors.fill: container; border.color: "#89c5f5"; border.width: 4
        color: "transparent"; visible: textInput.focus; smooth: true
        radius: 25
    }

    MouseArea {
        anchors { fill: parent; leftMargin: -20; topMargin: -20; rightMargin: -20; bottomMargin: -20 }
        onClicked: {
            textInput.forceActiveFocus();
            textInput.openSoftwareInputPanel();
            reset();
            textInput.data
        }
    }


    function reset(){
        textInput.text = ""
        textInput.font.italic = false;
        textInput.color = "black"
        if (isPassword)
            textInput.echoMode = TextInput.Password;
        else
            textInput.echoMode = TextInput.Normal;
    }

    function setInput(){
        input = textInput.text;
    }

}
