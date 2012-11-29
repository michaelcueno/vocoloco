import QtQuick 1.1

Item {
    anchors.fill: parent; // This will fill the entire screen

    Image {
        id: background
        anchors.fill: parent
        fillMode: Image.Tile
        source: ":/images/twinkle_twinkle.png"
    }

    Text {
        id: header
        anchors { right: parent.right; top: parent.top; topMargin: 20; rightMargin: 100 }

        text: "Settings"
        font.bold: true
        font.pixelSize: 40
        color: "white"
    }

    Rectangle {
        id: logout
        anchors.top: header.bottom
        anchors.right: parent.right;
        anchors.rightMargin: 20
        color: "grey"
        anchors.topMargin: 30;
        width: 300
        height: 100
        Text {
            text: "Logout"
            font.pixelSize: 20

        }
        MouseArea {
            id: logout_btn
            enabled: false
            anchors.fill: parent
            onClicked: fuckeduplogout()
        }
    }
    Rectangle {
        id: update
        anchors.top: logout.bottom
        anchors.right: parent.right;
        anchors.rightMargin: 20
        color: "grey"
        anchors.topMargin: 30;
        width: 300
        height: 100
        Text {
            text: "update"
            font.pixelSize: 20

        }
        MouseArea {
            id: update_btn
            anchors.fill: parent
            enabled: false
            onClicked: {
                hideSettings()
                homeScreen.loadXML()
            }
        }
    }

    function enable() {
        update_btn.enabled = true
        logout_btn.enabled = true
    }

    function disable() {
        update_btn.enabled = false
        logout_btn.enabled = false
    }
}
