// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {

    signal showScreen( string msg )

    x: 0; y:window.height * (1/10); width: window.width; height: window.height * (9/10)  // Posistioning


    Text{
        text: "This is the new convo screen!"
    }

    MouseArea{
        anchors.fill: parent;
        onClicked: {
            changeHeader("Your Conversations")
            changeScreen(homeScreen)
        }
    }
}
