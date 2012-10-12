
#ifndef NETWORKCONNECTION_H
#define NETWORKCONNECTION_H

#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
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
    void postForm(QString);
    //login
    //logout
    //isLoggedIn
    //hasAccess
    //getUrl
    //postUrl
    //createPayload
    //serverIsLive



public slots:
    void httpReadyRead();
    void httpFinished();
    // these handle the callbacks for http request
    //create handlers for all type of request nad responses
    //

private:
    QUrl url;
    QNetworkAccessManager qnam;
    QNetworkReply *reply;
    QFile *file;

};

#endif // NETWORKCONNECTION_H
