import QtQuick 1.1

Rectangle {
    id: window
    width: 720; height: 1280


    XmlListModel {
        id: conversations
        source: "../../xml/conversations.xml"
        query: "/conversations/conversation"

        XmlRole { name: "title_of_newest_message"; query: "title_pof_newest_message/string()" }
        XmlRole { name: "user"; query: "user/string()" }
        XmlRole { name: "number_of_new_messages"; query: "number_of_new_messages/string()" }

    }

    ListView {
        id: list_view1
        x: 0
        y: 0
        width: 720
        height: 1000
        maximumFlickVelocity: 2502
        delegate: ConversationDelegate
        model: conversations
    }

    Rectangle {
        id: rectangle1
        x: 0
        y: 1000
        width: 720
        height: 244
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
