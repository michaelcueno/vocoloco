import QtQuick 1.1

Rectangle {
    width: 100
    height: 62

    Rectangle {
        id: get
        width: 300;
        height: 200
        color: "gray"
        Text{
            text: "play"
        }

        MouseArea{
            anchors.fill: parent;
            onClicked: {
                network.downloadAudio("http://www.wavsource.com/snds_2012-11-18_3259125673848267/people/politics/bushw_chechnya.wav");
            }
        }
    }

    Rectangle {
        id: record
        anchors.top: get.bottom; anchors.topMargin: 20;
        width: 300;
        height: 200
        color: "green"
        Text{
            text: "record"
        }

        MouseArea{
            anchors.fill: parent;
            onClicked: {
                network.record();
            }
        }
    }
    Rectangle {
        id: stop
        anchors.top: record.bottom; anchors.topMargin: 20;
        width: 300;
        height: 200
        color: "blue"
        Text{
            text: "stop"
        }

        MouseArea{
            anchors.fill: parent;
            onClicked: {
                network.stopRecording();
            }
        }
    }

    Rectangle {
        id: play
         anchors.top: stop.bottom; anchors.topMargin: 20;
        width: 300;
        height: 200
        color: "blue"
        Text{
            text: "play"
        }

        MouseArea{
            anchors.fill: parent;
            onClicked: {
                network.play();
            }
        }
    }
}
