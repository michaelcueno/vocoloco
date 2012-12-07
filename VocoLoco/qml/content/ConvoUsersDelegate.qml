/****************************************************************************
 * Copyright (C) 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ****************************************************************************/
/**
  * This is used to format the users list in the homescreen users listview
  */
import QtQuick 1.1

Item {

    property string first
    property string last

    property string tr: "true"   // For checking if a user has a new message post

    Component.onCompleted: setFirstLast()

    id: column
    width: 115
    height: parent.height

    Rectangle {
        width: 105; height: 105
        anchors.centerIn: usrImg
        color: "#ff9b4f"
        visible: is_new === tr
    }

    Image {
        id: usrImg
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
        font.pixelSize: 22
        font.bold: true
        color: is_new === tr ? "#23a400" : "black"
    }

    function setFirstLast(){
        var whole = name;
        whole = whole.split(" ")
        first = whole[0]
        if (whole[1])
            last = whole[1]
    }
}
