import QtQuick 1.1

Rectangle {
    id: row
    width: parent.width
    height: 180
    color: "#ffffff"

    Image {
        id: list_background
        source: ":/images/list_background.gif"
    }

    Image {
        id: user_img
        source: "http://vocoloco.herokuapp.com/" + image
        width: 105; height: 105
        x: 30; y: 38;
    }

    Text {
        id: contact_name
        text: name;
        font { bold: true; family: "Helvetica"; pixelSize: 35 }
        anchors { left: user_img.right; leftMargin: 40;}
        color: "#46433a"
        y: 70;
    }

    // Check Box --------------------------------------------------------------------____|
    Rectangle {
        id: check_box
        anchors { right: parent.right; }
        y: 38; x: parent.width - 56;
        width: 111; height: 93
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                contacts_checked()
            }
        }
        states: [State {
                    name: "checked"
                    PropertyChanges { target: un_checked_box; opacity: 0}
                    PropertyChanges { target: checked_box; opacity: 1}
        },      State {
                    name: ""
                    PropertyChanges { target: un_checked_box; opacity: 1}
                    PropertyChanges { target: checked_box; opacity: 0}
        }
        ]
    }

    Image {
        id: un_checked_box
        source: ":/images/un_checked_box.gif"
        anchors.fill: check_box
        opacity: 1
    }

    Image {
       id: checked_box
       source: ":/images/checked_box.gif"
       smooth: true
       anchors.fill: check_box
       opacity: 0
    }

    function contacts_checked(){
        console.log (check_box.state)
        if(check_box.state == "")
            check_box.state = "checked"
        else
            check_box.state = ""
    }
}
