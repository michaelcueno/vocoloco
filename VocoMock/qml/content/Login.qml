// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {


    signal postCredentials(string credentials)
    signal submitted()    // Connects to TextBox, sets TextBox input
    signal requestXML(string xml)
    property bool isLoading

    function onLoginSuccess(){
        requestXML("conversations")
        changeScreen(homeScreen)
 //       loginScreen.visible = false;
//        homeLoader.source = ":/qml/content/Home.qml"
        changeHeader("All Conversations")


    }

    function onLoginFail(){
        loginFail.visible = true;
        console.log("failure")
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

    BusySpinner {
        on: network.isLoading;
        y: parent.height * (2/7)
        anchors.horizontalCenter: parent.horizontalCenter
    }


    // Username input field
    TextBox {
        id: username
        width: parent.width * (3/5); height: parent.height / 11
        x: parent.width * (1/5); y: parent.height * (3/7)
        isPassword: false;
        label: "username"
        cornerRadius: 25
    }

    // Password input field
    TextBox {
        id: password
        width: parent.width * (3/5); height: parent.height / 11
        x: parent.width * (1/5); y: parent.height * (4/7)
        isPassword: true;
        label: "password"
        cornerRadius: 25
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
        color: "#f76f6f"
        smooth: true
        visible: false
        width: parent.width * (4/5); height: 80
        x: parent.width * (0.5/5); y: parent.height * (6/7)
        Text {
            anchors.centerIn: parent;
            font.bold: true; font.pointSize: 18
            text: "Incorrect Username or Password"
        }
    }
}
