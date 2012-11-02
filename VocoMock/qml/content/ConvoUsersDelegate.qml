import QtQuick 1.1

Item {
    id: column
    width: 115
    height: parent.height

    //TODO Naw.. I don't know
    Image {
        width:105;height:105;
        x:10;y:15;
        source: "https://vocoloco.herokuapp.com/" + image // network.getImage("https://vocoloco.herokuapp.com" + image)
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
