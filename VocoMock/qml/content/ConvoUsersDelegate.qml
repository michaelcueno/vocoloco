import QtQuick 1.1

Item {
    id: column
    width: 115
    height: parent.height


    Image {
        width:105;height:105;
        x:10;y:15;
        /*
        anchors.fill: parent;
        anchors {topMargin:5; leftMargin:5; rightMargin:5; bottomMargin:20} */
        source: image
        fillMode: Image.Stretch;

    }
    Text {
        height:20;
        y:130;
        anchors {left: parent.left; right:parent.right;}
        horizontalAlignment: Text.AlignHCenter;
        text: name
        font.pixelSize: 22;
        font.bold: true
    }
}
