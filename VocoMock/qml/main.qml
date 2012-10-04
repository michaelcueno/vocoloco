import QtQuick 1.1

import 'content'

// Main window of application -----------//
Rectangle {
    id: window
    width: 720; height: 1280

    // This is a data model that can be imported into a ListView. It parses XML -------- //
    // This is not a visual element
    XmlListModel {
        id: conversations
        source: "http://vocoloco.herokuapp.com/friends"
        query: "/conversations/conversation"

        XmlRole { name: "title_of_newest_message"; query: "title_of_newest_message/string()" }
        XmlRole { name: "user"; query: "user/name/string()" }
        XmlRole { name: "number_new_messages"; query: "number_new_messages/string()" }
        XmlRole { name: "userImage"; query: "user/image/string()" }
    }

    // Start of Visual elements

    Rectangle {
        id: header
        x: 0; y: 0; width: 720; height: 150
        color: "#339ab3"
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#339ab3";
            }
            GradientStop {
                position: 1.00;
                color: "#275375";
            }
        }

        Text {
            text: "All Messages"
            font.pixelSize: 35; font.bold: true
            anchors.top: parent.top; anchors.left: parent.left; anchors.margins: 30
        }

    }
    ListView {
        id: allConversations
        x: 0
        y:150
        width: 720
        height: 1000
        maximumFlickVelocity: 2502
        delegate: ConversationDelegate {}
        model: conversations
    }

    ScrollBar {
        scrollArea: allConversations; height: allConversations.height; width:10;
        anchors.right: allConversations.right
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
