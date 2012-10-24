import QtQuick 1.1
import 'content'


// Main window of application -----------//
Rectangle {
    id: window
    width: 500; height: 700
    objectName: "mainObj";

    property string mainUrl: "https://vocoloco.herokuapp.com/"

    //--- Visual components --------- |

    Header {  id: header; visible: false; Loader{id: headerLoader; }}

    Login { id: loginScreen; objectName: "loginObj"; anchors.fill: parent;  visible: true }

    Home { id: homeScreen; visible: false; Loader{id: homeLoader}}

    Convo { id: convoScreen; visible: false; }

    NewConvo { id: newConvoScreen; visible: false; }

    ContactScreen { id: contactScreen; visible: false; }

    Rectangle{
        id: testScreen;
        visible: false;
        anchors.centerIn: parent;
        width: 100;
        height: 100;
        Text{
            text:"got here"
        }
    }

    //---- End of visual comonents ----- |

    //--- Functions non visual ------------------ |

    function test(){
        changeScreen(testScreen)
    }


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
