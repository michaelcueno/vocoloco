import QtQuick 1.1

import 'content'

// Main window of application -----------//
Rectangle {
    id: window
    width: 720; height: 1280

    // This is a data model that can be imported into a ListView. It parses XML -------- //
    XmlListModel {
        id: conversations
        source: "http://vocoloco.herokuapp.com/friends"
        query: "/conversations/conversation"

        XmlRole { name: "title_of_newest_message"; query: "title_of_newest_message/string()" }
        XmlRole { name: "user"; query: "user/name/string()" }
        XmlRole { name: "number_new_messages"; query: "number_new_messages/string()" }
        XmlRole { name: "userImage"; query: "user/image/string()" }

    }



    ListView {
        id: list_view1
        x: 0
        y:150
        width: 720
        height: 1000
        maximumFlickVelocity: 2502
        delegate: ConversationDelegate {}
        model: conversations
    }

    Rectangle {
        id: rectangle1
        x: 0
        y: 0
        width: 720
        height: 150
        color: "#44be06"
    }




 /*   Rectangle {
        id: focusedView
        width: parent.width; height: parent.height;
        opacity: 0;
        color: "blue"
        states: [
            State {
                name: "background"
                PropertyChanges { target: focusedView; opacity: 0}
            },

            State {
                name: "focused"
                PropertyChanges { target: focusedView; opacity: 1 }
            }
        ]

        transitions: Transition { from: "background"; to: "focused"
            PropertyAnimation: {target: focusedView; properties: "opacity"; duration: 1000
            }
        }

        Rectangle {
            id: quit_focusedView
            color: "red"
            width: 150;
            height: 100;
            anchors.centerIn: parent
            Text {
                anchors.centerIn: parent
                text: "Quit"
                font.pixelSize: 15;
                MouseArea {
                    anchors.fill: parent
                    onClicked: { focusedView.state = "background" }
                }
            }
        }
    } */

}
