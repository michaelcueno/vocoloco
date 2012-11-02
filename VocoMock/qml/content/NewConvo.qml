// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {

    x: 0; y:window.height * (1/10); width: window.width; height: window.height * (9/10)  // Posistioning

    TextBox{
        id: convo_title
        width: parent.width * (3/5); height: parent.height / 11
        x: parent.width * (1/5); y: parent.height * (3/7)
        isPassword: false;
        label: "Title"
        cornerRadius: 25
    }
}
