#include <QtGui/QApplication>
#include <QDeclarativeComponent>
#include "qmlapplicationviewer.h"
#include "httpmanager.h"
#include "ImageProvider.h"
#include <QGraphicsObject>
#include <QDeclarativeContext>
#include "networkfactory.h"
#include <QDeclarativeEngine>
#include <QDeclarativeImageProvider>
#include <QDebug>
#include <QMenuBar>
#include "mainwindow.h"
#include <jni.h>


int main(int argc, char *argv[])
{

    QApplication app(argc, argv);

    // Create settings for storing cookie on android for one-time-log-in
    QSettings settings("CS340", "VocoLoco");

    HttpManager network;
    QmlApplicationViewer viewer;

                     //  ImageProvider *imageProvider = new ImageProvider(network.getManager());

                     //  viewer.engine()->addImageProvider(QString("my_provider"), imageProvider);

    // Override QML's default netowrkAccessManagerFactory with our custom built factory
    NetworkFactory *factory = new NetworkFactory();
    viewer.engine()->setNetworkAccessManagerFactory(factory);
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);

    // make network avaiable to QML
    viewer.rootContext()->setContextProperty("network", &network);

    // Initailize and build QML
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);
    viewer.setAttribute(Qt::WA_LockPortraitOrientation, true);
    viewer.setAttribute(Qt::WA_AutoOrientation, false);

    viewer.setSource(QUrl(QLatin1String("qrc:/qml/main.qml")));

    //   viewer.ResizeMode(QDeclarativeView::SizeRootObjectToView);


    MainWindow logoutbtn;
    logoutbtn.setOrientation(MainWindow::ScreenOrientationAuto);


    // Locate and instantiate QML objects for connections
    QObject *rootObject = dynamic_cast<QObject*>(viewer.rootObject());
    QObject *login = rootObject->findChild<QObject*>("loginObj");
    QObject *home = rootObject->findChild<QObject*>("homeObj");
    QObject *newConvo = rootObject->findChild<QObject*>("newConvoObj");
    QObject *convo = rootObject->findChild<QObject*>("convoObj");
    QObject *main = rootObject;

    // Signals to slots between QML and c++
    QObject::connect(login, SIGNAL(postCredentials(QString)), &network, SLOT(postCredentials(QString)));
    QObject::connect(&network, SIGNAL(loginSuccess()), login, SLOT(onLoginSuccess()));
    QObject::connect(&network, SIGNAL(loginFail()), login, SLOT(onLoginFail()));
    QObject::connect(&network, SIGNAL(convoCreatedSignal()), newConvo, SLOT(goToConvo()));
    QObject::connect(&network, SIGNAL(reloadHome()), home, SLOT(loadXML()));
    QObject::connect(&network, SIGNAL(reloadConvo()), convo, SLOT(loadXML()));
    QObject::connect(&network, SIGNAL(playAudioDone()), convo, SLOT(playAudioDone()));


    // Tests
  //  QObject::connect(&network, SIGNAL(error()), main, SLOT(test()));

    //logoutbtn.show();

    viewer.showExpanded();  // TODO: change to showFullScreen somehow grab the width and Height of the application and resize QML


    return app.exec();
}
