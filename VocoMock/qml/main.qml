import QtQuick 1.1
import 'content'


// Main window of application -----------//
Rectangle {
    id: window
    width: 720; height: 1280
    objectName: "mainObj";

    property string mainUrl: "https://vocoloco.herokuapp.com/"

    //--- Visual components --------- |

    Header {  id: header;  visible: false }

    Login { id: loginScreen; objectName: "loginObj"; anchors.fill: parent; visible: true }

    Home { id: homeScreen; objectName: "homeObj"; visible: false; }

    Convo { id: convoScreen; visible: false  }

    NewConvo { id: newConvoScreen; visible: false  }

    Contacts { id: contactScreen;  visible: false }

    Record {id: recordScreen; anchors.fill: parent; visible: false}

    Rectangle{
        id: testScreen
        visible: false
        anchors.centerIn: parent
        width: 100
        height: 100
        Text{
            id: testText
            text:"got here"
        }
    }

    //---- End of visual comonents ----- |

    //--- Functions non visual ------------------ |


    // ------ Development test code -------|
    function test(){
        changeScreen(testScreen)
    }

    // ------------- end of test code ----------|

    //Uncomment next line for auto login from saved cookie
    Component.onCompleted: checkForSavedCookies()

    //TODO not correct (There will always be a Cookie, must verify if it is valid)
    function checkForSavedCookies()
    {
        if(network.hasSavedCookie()){
            network.requestXML("conversations")
            changeScreen(homeScreen)
        }
    }

    function changeScreen(screen){

        header.visible = true;
        homeScreen.visible = false;
        recordScreen.visible = false;
        convoScreen.visible = false;
        newConvoScreen.visible = false;
        contactScreen.visible = false;
        loginScreen.visible = false;
        screen.visible = true;

        if(homeScreen.visible){
            changeHeader("All Conversations");
            homeScreen.load()
        }

    }

    function changeHeader(msg){
        header.headerTitle = msg
        header.visible = true;
    }
}
