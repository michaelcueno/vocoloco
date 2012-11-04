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

int main(int argc, char *argv[])
{

    QApplication app(argc, argv);

    QSettings settings("CS340", "VocoLoco");

    qmlRegisterType<HttpManager>("Network", 1, 0, "HttpManager"); //TO make availalbe in QML
    HttpManager network;

    QmlApplicationViewer viewer;

  //  ImageProvider *imageProvider = new ImageProvider(network.getManager());

  //  viewer.engine()->addImageProvider(QString("my_provider"), imageProvider);

    NetworkFactory *factory = new NetworkFactory();
    viewer.engine()->setNetworkAccessManagerFactory(factory);

    viewer.rootContext()->setContextProperty("network", &network);  // make network avaiable to QML
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);
    viewer.setSource(QUrl(QLatin1String("qrc:/qml/main.qml")));


    // Locate and instantiate QML objects for connections
    QObject *rootObject = dynamic_cast<QObject*>(viewer.rootObject());
    QObject *login = rootObject->findChild<QObject*>("loginObj");
    QObject *home = rootObject->findChild<QObject*>("homeObj");
    QObject *main = rootObject;

    // Signals to slots between QML and c++
    QObject::connect(login, SIGNAL(postCredentials(QString)), &network, SLOT(postCredentials(QString)));
    QObject::connect(login, SIGNAL(requestXML(QString)), &network, SLOT(requestXML(QString)));
    QObject::connect(&network, SIGNAL(loginSuccess()), login, SLOT(onLoginSuccess()));
    QObject::connect(&network, SIGNAL(loginFail()), login, SLOT(onLoginFail()));
    QObject::connect(login, SIGNAL(stayLoggedIn(bool)), &viewer, SLOT(setStayLoggedIn(bool)));


    // Tests
    QObject::connect(&network, SIGNAL(test()), main, SLOT(test()));

    viewer.showExpanded();
    return app.exec();
}
