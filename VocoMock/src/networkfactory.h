#ifndef NETWORKFACTORY_H
#define NETWORKFACTORY_H
#include <QDeclarativeNetworkAccessManagerFactory>
#include <QNetworkReply>
#include <QAuthenticator>
#include <QSslError>


/**
 * @brief This class is fed to the QML engine so that it uses this class on each new server request
 *
 *  This class inherits from QDeclarativeNetworkAccessManagerFactory, and adds some neccessary functionality.
 *  First we needed to ingore SSL errors because necessitas doesn't handle them correctly. Also the constructor
 *  creates and uses our CookieJar implementation so that the user can stay logged in. This is also necessary
 *  for requests to function properly (the QML engine must send the cookie with each request).
 */
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

