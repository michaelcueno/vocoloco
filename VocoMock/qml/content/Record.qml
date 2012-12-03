/****************************************************************************
 * Copyright (C) 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ****************************************************************************/

import QtQuick 1.1

Rectangle{
    id: recordContainer
    Image{
        id: microphone
        anchors.centerIn: parent
        source: ":/qml/content/images/OldRadioMicrophone6.png"
    }

    Rectangle {
        id: backBtn
        anchors.top: microphone.bottom; anchors.bottom: parent.bottom
        width: parent.width
        color: 'grey'
        Text { font.pixelSize: 23; text: "Go Back" }
        MouseArea{
            anchors.fill: parent;
            onClicked: changeScreen(homeScreen);
        }
    }
}
