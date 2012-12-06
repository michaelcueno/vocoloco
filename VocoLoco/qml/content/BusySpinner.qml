/****************************************************************************
 * Copyright (C) 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ****************************************************************************/
/**
  * Simple image that rotates when property "on" is true
  */

import QtQuick 1.1

Image {
    id: container
    property bool on: false

    source: ":/images/spinner.png"; visible: on

    NumberAnimation on rotation {
        running: container.on; from: 0; to: 360; loops: Animation.Infinite; duration: 1200
    }

}
