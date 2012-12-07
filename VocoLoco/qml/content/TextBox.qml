/****************************************************************************
 * Copyright (C) 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ****************************************************************************/
/**
  * This file is used as the text box for the login screen. It wraps a textInput to allow for password hiding
  * and for gathering data and having an initial, greyed out text that will dissapear on focus
  */
import QtQuick 1.1

Rectangle {
    id: container

    property string label     // Initial text in grey
    property bool isPassword  // sets field to use *** instead of chars
    property string input     // property for accessing user input
    property int cornerRadius // rounded edges

    signal textEntered

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
        font { pixelSize: 30; italic:true; } color: "black"
        anchors.centerIn: parent;
        smooth: true;
        onActiveFocusChanged: textEntered()
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

    // Clears out the text that was in the text box
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

    function setFocus(){
        textInput.focus = true;
        textInput.openSoftwareInputPanel();
    }
}
