import QtQuick 1.1

Rectangle {

    property string first
    property string last

    Component.onCompleted: setFirstLast()

    id: row
    width: parent.width
    height: 150
    color: "#ffffff"

    Image {
        id: list_background
        source: ":/images/list_background.gif"
    }

    Image {
        id: user_img
        source: "http://vocoloco.herokuapp.com/" + image
        width: 105; height: 105
        x: 30; y: 22;
    }

    Text {
        id:first_name
        text: first;
        font { bold: true; family: "Helvetica"; pixelSize: 35 }
        anchors { left: user_img.right; leftMargin: 40;}
        color: "black"
        y: 50;
    }
    Text {
        id: last_name
        text: last;
        font { bold: true; family: "Helvetica"; pixelSize: 35 }
        anchors { left: first_name.right; leftMargin: 10;}
        color: "#46433a"
        y: 50;
    }
    Text {
        id: usrName
        text: "username: "+ username
        font { pixelSize: 20 }
        anchors { top: first_name.bottom; topMargin: 10; left: first_name.left}
        color: "#46433a"
    }

    // Check Box -------------------------------------------------------------------------|
    Rectangle {
        id: check_box
        y: 24; x: parent.width - 140;
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

    function contacts_checked()
    {
        if(check_box.state == ""){
            check_box.state = "checked"
            network.addNewConvoUser(username)
        }else{
            check_box.state = ""
            network.removeNewConvoUser(username)
        }
    }

    function unCheck(){
        check_box.state = ""
    }

    function setFirstLast(){
        var whole = name;
        whole = whole.split(" ")
        first = whole[0]
        if (whole[1])
            last = whole[1]
    }
}
