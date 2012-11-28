#include "networkfactory.h"
#include <QDeclarativeNetworkAccessManagerFactory>
#include <QNetworkAccessManager>
#include <QDebug>
#include <QSslError>
#include <QObject>
#include "cookiejar.h"

NetworkFactory::NetworkFactory(QObject *parent) : QObject(parent){}

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

void NetworkFactory::onAuthNeeded(QNetworkReply*, QAuthenticator*){
    qDebug() << "Required Authentication!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!";
}
