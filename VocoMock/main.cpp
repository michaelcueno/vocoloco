#include <QtGui/QApplication>
#include <QDeclarativeComponent>
#include "qmlapplicationviewer.h"
#include "httpmanager.h"
#include <QGraphicsObject>


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

   // qmlRegisterType<HttpManager>("Network", 1, 0, "HttpManager"); //TO make availalbe in QML
    HttpManager network;


    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);
    viewer.setSource(QUrl(QLatin1String("qrc:/qml/main.qml")));

    // Locate and instantiate QML objects for connections
    QObject *rootObject = dynamic_cast<QObject*>(viewer.rootObject());
    QObject *login = rootObject->findChild<QObject*>("loginObj");


    // Signals to slots between QML and c++
    QObject::connect(login, SIGNAL(authenticate(QString)), &network, SLOT(postCredentials(QString)));
    QObject::connect(&network, SIGNAL(loginSuccess()), login, SLOT(onLoginSuccess()));
    QObject::connect(&network, SIGNAL(loginFail()), login, SLOT(onLoginFail()));


    viewer.showExpanded();

    return app.exec();
}
