<<<<<<< HEAD
SOURCES += src/main.cpp \
    src/httpmanager.cpp \
    src/cookiejar.cpp \
    src/networkfactory.cpp \
    src/postnewconversation.cpp \
    src/newmessage.cpp \
    src/dummydesktopplayer.cpp

HEADERS += \
    src/httpmanager.h \
    src/cookiejar.h \
    src/networkfactory.h \
    src/postnewconversation.h \
    src/newmessage.h \
    src/dummydesktopplayer.h
=======
SOURCES += main.cpp \ 
    httpmanager.cpp \
    cookiejar.cpp \
    networkfactory.cpp \
    postnewconversation.cpp \
    newmessage.cpp \
    mainwindow.cpp \
    dummydesktopplayer.cpp \
    androidmediarecorder.cpp

HEADERS += \
    httpmanager.h \
    cookiejar.h \
    networkfactory.h \
    ImageProvider.h \
    postnewconversation.h \
    newmessage.h \
    mainwindow.h \
    dummydesktopplayer.h \
    androidmediarecorder.h
>>>>>>> 33132f0b36ff52eb2b68c9890427c026b5fc67ab


RESOURCES += voco.qrc

QT += network \
        testlib

<<<<<<< HEAD
QML_IMPORT_PATH = ["/home/mike/necessitas/QtCreator/Qt/imports/desktop/components/plugin"]
=======
linux-g++ {
    INCLUDEPATH +=  "/usr/lib/jvm/java-1.6.0-openjdk/include"   \ # path to jni on linux

}
>>>>>>> 33132f0b36ff52eb2b68c9890427c026b5fc67ab

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()
INCLUDEPATH +=  /usr/lib/jvm/java-1.6.0-openjdk/include

linux-g++ {
    INCLUDEPATH +=  /usr/Classeslib/jvm/java-1.6.0-openjdk/include   # path to jni on linux
    DEFINES += MEDIA_HEADER='dummymediaplayer.h'
    DEFINES += MEDIA_OBJECT=DummyDesktopPlayer
}

android {
<<<<<<< HEAD
    DEFINES -= MEDIA_OBJECT
    SOURCES += src/androidmediaobject.cpp

    HEADERS += src/androidmediaobject.h

    INCLUDEPATH +=  /usr/lib/jni  #  path to jni for android
    DEFINES += MEDIA_PLAYER=\\\"androidmediaobject.h\\\"
    DEFINES += MEDIA_OBJECT=AndroidMediaObject
=======


    INCLUDEPATH +=  /usr/lib/jni  #  path to jni for android

>>>>>>> 33132f0b36ff52eb2b68c9890427c026b5fc67ab
}

OTHER_FILES += \
    android/version.xml \
    android/AndroidManifest.xml \
    android/src/org/kde/necessitas/ministro/IMinistroCallback.aidl \
    android/src/org/kde/necessitas/ministro/IMinistro.aidl \
    android/src/org/kde/necessitas/origo/QtApplication.java \
    android/src/org/kde/necessitas/origo/QtActivity.java \
    android/src/org/kde/necessitas/orgio/QtApplication.java \
    android/res/values-ru/strings.xml \
    android/res/values-nb/strings.xml \
    android/res/drawable-hdpi/icon.png \
    android/res/values-ja/strings.xml \
    android/res/values-zh-rCN/strings.xml \
    android/res/drawable/icon.png \
    android/res/drawable/logo.png \
    android/res/values-es/strings.xml \
    android/res/values-pt-rBR/strings.xml \
    android/res/drawable-mdpi/icon.png \
    android/res/values-et/strings.xml \
    android/res/values-id/strings.xml \
    android/res/drawable-ldpi/icon.png \
    android/res/layout/splash.xml \
    android/res/values-zh-rTW/strings.xml \
    android/res/values-ro/strings.xml \
    android/res/values-el/strings.xml \
    android/res/values-ms/strings.xml \
    android/res/values-nl/strings.xml \
    android/res/values-pl/strings.xml \
    android/res/values-fa/strings.xml \
    android/res/values-fr/strings.xml \
    android/res/values-it/strings.xml \
    android/res/values-rs/strings.xml \
    android/res/values/strings.xml \
    android/res/values/libs.xml \
    android/res/values-de/strings.xml \
    qml/content/Home.qml \
    qml/main.qml \
    qml/content/Convo.qml \
    qml/content/NewConvo.qml \
    qml/content/Header.qml \
    qml/content/ConversationDelegate.qml \
    qml/content/Login.qml \
    qml/content/TextBox.qml \
    qml/content/ConvoUsersXML.qml \
    qml/content/ConvoUsersDelegate.qml \
    qml/content/BusySpinner.qml \
    qml/content/MessageDelegate.qml \
    qml/content/Contacts.qml \
    qml/content/ContactsDelegate.qml \
    qml/content/SearchBox.qml \
<<<<<<< HEAD
    qml/content/Settings.qml \
    qml/content/SettingsOption.qml \
    qml/content/ScrollBar.qml \
    android/src/org/kde/necessitas/origo/QSimpleAudioPlayer.java

=======
    qml/TestScreen.qml \
    android/src/org/kde/necessitas/origo/QSimpleAudioRecorder.java \
    android/src/org/kde/necessitas/origo/QSimpleAudioPlayer.java
>>>>>>> 33132f0b36ff52eb2b68c9890427c026b5fc67ab

