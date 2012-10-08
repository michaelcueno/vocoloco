// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item{

    signal showScreen(string msg)


    ListView {
        id: allConversations
        x: 0; y:window.height * (1/10); width: window.width; height: window.height * (9/10)  // Posistioning
        maximumFlickVelocity: 2502
        clip: true;
        delegate: ConversationDelegate {}
        model: ConversationXML {}
    }

    ScrollBar {
        scrollArea: allConversations; height: allConversations.height; width:10;
        anchors.right: allConversations.right; anchors.top: allConversations.top;
    }

}
