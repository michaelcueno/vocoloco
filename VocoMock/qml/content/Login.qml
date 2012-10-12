// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: container
    color: "#6b94cc"
    gradient: Gradient {
    GradientStop {
        position: 0.00;
        color: "#6b94cc";
    }
    GradientStop {
        position: 1.00;
        color: "#2d5f97";
    }
}

    Text {
        y: 200
        anchors.horizontalCenter: parent.horizontalCenter;
        font.bold: true
        font.italic: true
        font.pointSize: 21
        text: "VocoLoco"

    }


    TextBox {
        id: username
        width: parent.width * (3/5); height: 80
        x: parent.width * (1/5); y: parent.height * (3/7)
        isPassword: false;
        label: "username"
    }

    TextBox {
        id: password
        width: parent.width * (3/5); height: 80
        x: parent.width * (1/5); y: parent.height * (4/7)
        isPassword: true;
        label: "password"
    }

    Rectangle {
        id: login_btn
        width: parent.width * (3/5); height: 80
        x: parent.width * (1/5); y: parent.height * (5/7)
        Text {
            anchors.centerIn: parent;
            font.bold: true; font.pointSize: 20
        }
        color: "#0043d5"
        border.color: "#0d0101"
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                changeScreen(homeScreen);
                changeHeader("Your Messages")

            }
        }
    }
}
