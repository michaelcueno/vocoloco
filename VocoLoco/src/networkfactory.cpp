#include "networkfactory.h"
#include <QDeclarativeNetworkAccessManagerFactory>
#include <QNetworkAccessManager>
#include <QDebug>
#include <QSslError>
#include <QObject>
#include "cookiejar.h"

NetworkFactory::NetworkFactory(QObject *parent) : QObject(parent){}

/**
 * @brief Implements the create function of the QDeclarativeNetworkAccessManagerFactory class
 * @param parent
 * @return QNetworkAccessManager*
 *
 * This class creates a new instance of the QNetworkAccessManager and a CookieJar, sets the cookie jar instance to be used
 * in the QNetworkAccessManager and then returns a reference to that manager. The Engine takes care of the destruction of the
 * manager since we set the parent to this. We also ingore ssl errors here.
 */
QNetworkAccessManager* NetworkFactory::create(QObject *parent){
    manager = new QNetworkAccessManager(this);
    CookieJar *jar = new CookieJar(manager);
    manager->setCookieJar(jar);
    QList<QNetworkCookie> list = jar->getCookies();

    QObject::connect(manager, SIGNAL(sslErrors(QNetworkReply*,QList<QSslError>)), this, SLOT(onIgnoreSSLErrors(QNetworkReply*,QList<QSslError>)));
    QObject::connect(manager, SIGNAL(authenticationRequired(QNetworkReply*,QAuthenticator*)), this, SLOT(onAuthNeeded(QNetworkReply*, QAuthenticator*)));

    return manager;
}

void NetworkFactory::onIgnoreSSLErrors(QNetworkReply* reply, QList<QSslError> errors){
    reply->ignoreSslErrors();
}

/**
 * @brief Just a flag for debugging, should never be needed in production
 */
void NetworkFactory::onAuthNeeded(QNetworkReply*, QAuthenticator*){
    qDebug() << "Required Authentication!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!";
}
