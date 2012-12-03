/****************************************************************************
 * Copyright (C) 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ****************************************************************************/

import QtQuick 1.1

Item {

    property string first
    property string last
    Component.onCompleted: setFirstLast()

    id: column
    width: 115
    height: parent.height

    Image {
        width:100;height:100;
        x:10;y:15;
        source: "http://vocoloco.herokuapp.com/" + image
        fillMode: Image.Stretch;
        asynchronous: true
    }

    Text {
        height:20;
        y:130;
        anchors {left: parent.left; right:parent.right;}
        horizontalAlignment: Text.AlignHCenter;
        text: first
        font.pixelSize: 22;
        font.bold: true
    }

    function setFirstLast(){
        var whole = name;
        whole = whole.split(" ")
        first = whole[0]
        if (whole[1])
            last = whole[1]
    }
}
