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

    // make network avaiable to QML
    viewer.rootContext()->setContextProperty("network", &network);
    // Initailize and build QML
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);
    viewer.setSource(QUrl(QLatin1String("qrc:/qml/main.qml")));

    //   viewer.ResizeMode(QDeclarativeView::SizeRootObjectToView);


    MainWindow logoutbtn;
    logoutbtn.setOrientation(MainWindow::ScreenOrientationAuto);


    // Locate and instantiate QML objects for connections
    QObject *rootObject = dynamic_cast<QObject*>(viewer.rootObject());
    QObject *login = rootObject->findChild<QObject*>("loginObj");
    QObject *home = rootObject->findChild<QObject*>("homeObj");
    QObject *main = rootObject;

    // Signals to slots between QML and c++
    QObject::connect(login, SIGNAL(postCredentials(QString)), &network, SLOT(postCredentials(QString)));
    QObject::connect(&network, SIGNAL(loginSuccess()), login, SLOT(onLoginSuccess()));
    QObject::connect(&network, SIGNAL(loginFail()), login, SLOT(onLoginFail()));


    // Tests
    QObject::connect(&network, SIGNAL(test()), main, SLOT(test()));

    //logoutbtn.show();

    viewer.showExpanded();  // TODO: change to showFullScreen somehow grab the width and hieght of the application and resize QML


    return app.exec();
}
