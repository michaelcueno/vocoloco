// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: container
    color: "#144d97"
    x: 0; y:0
    width: screenWidth; height: screenHieght


    signal postCredentials(string credentials)  // Connects to HttpManager::postCredentials
    signal stayLoggedIn(bool saveSesh)  // Connected to qmlapplicationviewer (tells the destructor to not delete the session cookie)
    signal submitted()    // Connects to TextBox, sets TextBox input
    signal requestXML(string xml)  // Connects to HttpManager::requestXML
    property bool isLoading


    // Masthead
    Text {
        y: parent.height * (1/10)
        anchors.horizontalCenter: parent.horizontalCenter;
        font.bold: true
        font.italic: true
        font.pointSize: 40
        text: "VocoLoco"
    }

    BusySpinner {
        on: network.isLoading;
        anchors { horizontalCenter: parent.horizontalCenter; top: parent.top; topMargin: 40}
    }

    // Username input field
    TextBox {
        id: username
        width: parent.width * (3/5); height: 80
        x: parent.width * (1/5); y: parent.height * (2/10)
        isPassword: false;
        label: "username"
        cornerRadius: 25
    }

    // Password input field
    TextBox {
        id: password
        width: parent.width * (3/5); height: 80
        x: parent.width * (1/5); y: parent.height * (3/10)
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
        x: parent.width * (1/5); y: parent.height * (4/10)
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
        x: parent.width * (0.5/5); y: 20
        Text {
            anchors.centerIn: parent;
            font.bold: true; font.pointSize: 18
            text: "Incorrect Username or Password"
        }
    }

    function onLoginSuccess(){
        changeScreen(homeScreen)
        loadXML()
        homeScreen.loadXML()
    }

    function onLoginFail(){
        loginFail.visible = true;
    }
}
