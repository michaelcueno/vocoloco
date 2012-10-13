import QtQuick 1.1
//import Network 1.0

import 'content'


// Main window of application -----------//
Rectangle {
    id: window
    width: 600; height: 780

    property string mainUrl: "https://vocoloco.herokuapp.com/"

    //--- Visual components --------- |

    Header {  id: header }

    Login { id: loginScreen; objectName: "loginObj"; anchors.fill: parent;  visible: true }

    Home { id: homeScreen; objectName: "homeObj"; visible: false; }

    Convo { id: convoScreen; visible: false; }

    NewConvo { id: newConvoScreen; visible: false; }

    ContactScreen { id: contactScreen; visible: false; }

    //---- End of visual comonents ----- |

/*
    // Element wrapper for network management
    HttpManager { id: httpManager }

    // Connections between slots and signals / c++ talking to QML
    Component.onCompleted: {
        loginScreen.authenticate.connect(httpManager.sendReqest);
    }

*/
    //--- Functions non visual ------------------ |

    function changeScreen(screen){

        homeScreen.visible = false;
        convoScreen.visible = false;
        newConvoScreen.visible = false;
        contactScreen.visible = false;
        loginScreen.visible = false;

        screen.visible = true;
    }

    function changeHeader(msg){
        header.string = msg
        header.visible = true;
    }
}
