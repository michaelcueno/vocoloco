import QtQuick 1.1
import 'content'


// Main window of application -----------//
Rectangle {
    id: window
    width: 720; height: 1280
    objectName: "mainObj";

    property string mainUrl: "https://vocoloco.herokuapp.com/"

    property int screenWidth
    property int screenHieght

    property int smallFont: 20
    property int normalFont: 30

    //--- Visual components --------- |

    Header {  id: header;  visible: false }

    Login { id: loginScreen; objectName: "loginObj"; visible: true }

    Home { id: homeScreen; objectName: "homeObj"; visible: false; }

    Convo { id: convoScreen; visible: false  }

    NewConvo { id: newConvoScreen; visible: false  }

    Contacts { id: contactScreen;  visible: false }

    Record {id: recordScreen; anchors.fill: parent; visible: false}

    TestScreen {id: audioTest; anchors.fill: parent; visible: true}

    Rectangle {
        id: logoutBtn
        color: "red"
        width: parent.width
        height: 40
        anchors.bottom: parent.bottom
        Text{
            text: "logout"
            anchors.centerIn: parent
            font.pixelSize: 30
        }
        MouseArea{
            anchors.fill: parent
            onClicked: logout()
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
    Component.onCompleted: {
        setDimensions()
        checkForSavedCookies()
    }

    function checkForSavedCookies()
    {
        if(network.hasSavedCookie()){
            network.requestXML("conversations")
            changeScreen(homeScreen)
            loadXML()
            // TODO BUG: deletes cookie on second opening of application.
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
            header.unHideBtns()
        }
    }

    function changeHeader(msg){
        header.headerTitle = msg
        header.visible = true;
    }

    function loadXML(){
        homeScreen.loadXML()
        contactScreen.loadXML()
        newConvoScreen.loadXML()
    }

    // Set screen width and height for some static properties that will not resize on soft keyboard invokation
    function setDimensions(){
        screenHieght = window.height
        screenWidth = window.width
        console.log(screenHieght)
        console.log(screenWidth)
    }

    // TODO Would be better if this goes to login screen but.. Getting a seg fault with next login so for now just quit app
    function logout(){
        network.logout()
        console.log(window.y)
        console.log(window.width)
       // changeScreen(loginScreen)
        Qt.quit()

    }
}
