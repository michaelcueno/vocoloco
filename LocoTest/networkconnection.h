
#ifndef NETWORKCONNECTION_H
#define NETWORKCONNECTION_H

#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QNetworkCookieJar>
#include <QUrl>
#include <QObject>
#include <QFile>
#include <QByteArray>


class NetworkConnection : public QObject
{
    Q_OBJECT
public:
    explicit NetworkConnection(QObject *parent = 0);
    void getXmlWriteToFile(QString);


    //login
    //logout
    //isLoggedIn
    //hasAccess
    //getUrl
    //postUrl
    //createPayload
    //serverIsLive

signals:
    void loginFail();
    void loginSuccess();

public slots:
    void httpReadyRead();
    void httpFinished();
    void postForm(QString);
    void authenticate();
    // these handle the callbacks for http request
    //create handlers for all type of request nad responses
    //

private:
    QUrl url;
    QNetworkAccessManager *manager;
    QNetworkReply *reply;
    QNetworkRequest request;
    QNetworkCookieJar cookies;
    QFile *file;


};

#endif // NETWORKCONNECTION_H
