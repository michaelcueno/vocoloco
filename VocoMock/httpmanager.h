#ifndef HTTPMANAGER_H
#define HTTPMANAGER_H

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QNetworkCookieJar>
#include <QByteArray>
#include <QUrl>
#include <QtDebug>
#include <QStringList>
#include <QString>

class HttpManager : public QObject
{

    Q_OBJECT


public:
    HttpManager();
    ~HttpManager();

signals:
    void loginSuccess();
    void loginFail();

public slots:
    void requestXML(QString request);
    void postCredentials(QString credentials);
    void authenticate();
    void parseReply();

private:
    QNetworkAccessManager *manager;
    QNetworkReply *reply;
    QNetworkRequest request;
    QNetworkCookieJar cookies;

};

#endif // HTTPMANAGER_H
