import QtQuick 1.1

Rectangle {

    signal showScreen(string msg)

    x: 0; y:window.height * (1/10); width: window.width; height: window.height * (9/10)  // Posistioning


    Text{
        text: "this is the Contact page"
    }
}
