SOURCES += main.cpp \ 
           httpmanager.cpp \  
    cookiejar.cpp

HEADERS += \
    httpmanager.h \
    cookiejar.h

RESOURCES += voco.qrc

QT += network

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    android/version.xml \
    android/AndroidManifest.xml \
    android/src/org/kde/necessitas/ministro/IMinistroCallback.aidl \
    android/src/org/kde/necessitas/ministro/IMinistro.aidl \
    android/src/org/kde/necessitas/origo/QtApplication.java \
    android/src/org/kde/necessitas/origo/QtActivity.java \
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
    qml/content/ContactScreen.qml \
    qml/content/ConversationDelegate.qml \
    qml/content/Login.qml \
    qml/content/TextBox.qml \
    qml/content/ConversationXML.qml \
    qml/content/ConvoUsersXML.qml \
    qml/content/ConvoUsersDelegate.qml \
    qml/content/BusySpinner.qml \
    qml/content/Record.qml

