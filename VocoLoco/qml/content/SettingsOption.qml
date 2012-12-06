/****************************************************************************
 * Copyright (C) 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ****************************************************************************/
/**
  * This file models the code for creating a settings option
  */

import QtQuick 1.1

Rectangle {

    id: container

    property string title  // The text that will appear as the settings option
    signal settingClicked  // The signal to indicate that this option was tapped
    property bool active   // Makes the option visible (so that different options can be present in different states

    width: 400
    height: 100
    color: "black"

    Text {
        visible: active
        text: title
        font.pixelSize: 35
        anchors.centerIn: parent;
        color: "white"
    }

    MouseArea {
        anchors.fill: parent
        enabled: active
        onClicked: {
            settingClicked()
        }
        onPressed: container.state = "PRESSED"
        onReleased: container.state = ""
    }


    states: State { id: pressed
        name: "PRESSED"
        PropertyChanges {target: container; color: "STEELBLUE" }
    }

}
