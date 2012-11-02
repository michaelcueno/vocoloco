#ifndef NETWORKFACTORY_H
#define NETWORKFACTORY_H
#include <QDeclarativeNetworkAccessManagerFactory>
#include <QNetworkReply>
#include <QAuthenticator>
#include <QSslError>

class NetworkFactory : public QObject, public QDeclarativeNetworkAccessManagerFactory
{
    Q_OBJECT

public:
    explicit NetworkFactory(QObject *parent = 0);
    virtual QNetworkAccessManager* create(QObject *parent = 0);

public slots:
    void onIgnoreSSLErrors(QNetworkReply*, QList<QSslError>);
    void onAuthNeeded(QNetworkReply*, QAuthenticator*);

private:
    QNetworkAccessManager* manager;
};

#endif // NETWORKFACTORY_H

