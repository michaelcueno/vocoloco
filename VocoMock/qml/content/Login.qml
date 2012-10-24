// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {

    signal postCredentials(string credentials)
    signal submitted();     // Connects to TextBox, sets TextBox input

    function onLoginSuccess(){
        changeScreen(homeScreen)
        changeHeader("Your Messages");
        progressBar.visible = true;
    }

    function onLoginFail(){
        loginFail.visible = true;
        progressBar.visible = true;
    }

    function progress(soFar, total){
        var percent = (soFar/total)*100;
        progressBar.percent = percent
        progressBar.visible = true
    }

    id: container
    color: "#144d97"

    // Masthead
    Text {
        y: parent.height * (1/7)
        anchors.horizontalCenter: parent.horizontalCenter;
        font.bold: true
        font.italic: true
        font.pointSize: 40
        text: "VocoLoco"
    }

    // Progress Bar
    Rectangle {
        id: progressBar
        width: parent.width * (3/5); height: 50
        x: parent.width * (1/5); y: parent.height * (2/7)
        visible: true;
        Text {
            anchors.centerIn: parent;
            font.bold: true; font.pointSize: 14
            text: network.progress
        }
    }

    // Username input field
    TextBox {
        id: username
        width: parent.width * (3/5); height: 60
        x: parent.width * (1/5); y: parent.height * (3/7)
        isPassword: false;
        label: "username"
    }

    // Password input field
    TextBox {
        id: password
        width: parent.width * (3/5); height: 60
        x: parent.width * (1/5); y: parent.height * (4/7)
        isPassword: true;
        label: "password"
    }

    // Login Button
    Rectangle {
        id: login_btn
        smooth: true;
        radius: 20
        width: parent.width * (3/5); height: 80
        x: parent.width * (1/5); y: parent.height * (5/7)
        Text {
            anchors.centerIn: parent;
            font.bold: true; font.pointSize: 20
            text: "login"
        }
        color: "#9cbcff"
        border.color: "#0d0101"

        MouseArea {
            anchors.fill: parent;
            onClicked: {
                login_btn.forceActiveFocus()
                submitted() // needed to set Input fields for the textboxes
                postCredentials(username.input + " "  + password.input) // connected to HttpManager::authenticate()
            }
        }
    }


    // Login Fail notification
    Rectangle {
        id: loginFail
        color: "#ea0b0b"
        smooth: true
        visible: false
        width: parent.width * (4/5); height: 50
        x: parent.width * (0.5/5); y: parent.height * (6/7)
        Text {
            anchors.centerIn: parent;
            font.bold: true; font.pointSize: 14
            text: "Incorrect Username or Password"
        }

    }
}
