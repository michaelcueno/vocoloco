/****************************************************************************
 * Copyright (C) 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ****************************************************************************/

import QtQuick 1.1

Rectangle {

    id: container

    property string title
    signal settingClicked
    property bool active

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
