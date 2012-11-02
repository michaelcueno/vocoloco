import QtQuick 1.1

Item {
    height: 200; width: window.width
    id: messageDelegate
    Text {id: one; text:owner}
    Text {id: two; anchors.top: one.bottom; text:userpic}
    Text {id: three; anchors.top: two.bottom; text:message_id}
    Text {id: four; anchors.top: three.bottom; text:message}
    Text {id: five; anchors.top: four.bottom; text:date}
}
