/****************************************************************************
 * Copyright (C) 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ****************************************************************************/

/**
  * This QML file is shown on the app startup if there is no saved cookie on file.
  * Otherwise the app will bypass this screen and go into the homescreen.
  */


// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: container
    color: "white"
    x: 0; y:0
    width: screenWidth; height: screenHeight

    signal postCredentials(string credentials)  // Connects to HttpManager::postCredentials
    signal stayLoggedIn(bool saveSesh)  // Connected to qmlapplicationviewer (tells the destructor to not delete the session cookie)
    signal submitted()    // Connects to TextBox, sets TextBox input
    signal requestXML(string xml)  // Connects to HttpManager::requestXML
    property bool isLoading        // Boolean for the spinner


    Image {
        id:background
        source: ":/images/Switchboard.png"
        anchors.fill: parent
    }

    // Masthead
    Text {
        y:0
        anchors.horizontalCenter: parent.horizontalCenter;
        font.bold: true
        font.pointSize: 50
        text: "Hi!\nThis is VocoLoco"
        color: "white"
    }



    // Username input field
    TextBox {
        id: username
        width: parent.width * (3/5); height: 80
        x: parent.width * (1/5); y: parent.height * (2/10)
        isPassword: false;
        label: "username"
        cornerRadius: 25
        opacity: .7
    }

    // Password input field
    TextBox {
        id: password
        width: parent.width * (3/5); height: 80
        x: parent.width * (1/5); y: parent.height * (3/10)
        isPassword: true;
        label: "password"
        cornerRadius: 25
        opacity: .7
        onTextEntered: brightenLoginBtn();
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
        color: "#bac2d3"
        border.color: "#0d0101"
        opacity: .7

        MouseArea {
            anchors.fill: parent;
            onClicked: {
                login_btn.forceActiveFocus()
                submitted() // needed to set Input fields for the textboxes
                postCredentials(username.input + " "  + password.input) // connected to HttpManager::authenticate()
            }
        }
    }

    // Loading Spinner dependant on the login request to the server
    BusySpinner {
        on: network.isLoading;
        anchors { horizontalCenter: parent.horizontalCenter; top:login_btn.bottom; topMargin: 40;}
    }

    // Login Fail notification
    Rectangle {
        id: loginFail
        color: "#f76f6f"
        smooth: true
        visible: false
        width: parent.width * (4/5); height: 80
        anchors {horizontalCenter: parent.horizontalCenter; top: login_btn.bottom; topMargin: 50 }
        Text {
            anchors.centerIn: parent
            font.bold: true; font.pointSize: 18
            text: "Incorrect Username or Password"
        }
    }

    // Go to home Screen
    function onLoginSuccess(){
        changeScreen(homeScreen)
        loadXML()
        homeScreen.loadXML()
    }

    // Login failure notification
    function onLoginFail(){
        loginFail.visible = true;
    }

    // When user enters password bubble, the login btn color changes
    function brightenLoginBtn(){
        login_btn.color = "#3baaea"
        login_btn.opacity = 1
    }
}
