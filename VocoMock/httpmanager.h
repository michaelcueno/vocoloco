#ifndef HTTPMANAGER_H
#define HTTPMANAGER_H

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QAuthenticator>
#include <QByteArray>
#include <QUrl>
#include <QtDebug>
#include <QStringList>
#include <QString>
#include <QPointer>

#include "cookiejar.h"

class HttpManager : public QObject
{

    Q_OBJECT
    Q_PROPERTY(int progress
               READ progress
               WRITE setProgress
               NOTIFY progressChanged )  // Makes available to QML
    Q_PROPERTY(bool isLoading READ isLoading WRITE setLoading NOTIFY loadingChanged)


public:
    HttpManager();
    ~HttpManager();

    void setProgress(int prog);
    int progress();
    bool isLoading();
    void setLoading(bool x);

signals:
    void loginSuccess();
    void loginFail();
    void loadingChanged();
    void progressChanged();
    void test();

public slots:
    void requestXML(QString request);
    void postCredentials(QString credentials);
    void setDownloadProgress(qint64 soFar,qint64 total);
    void authenticate();
    void parseReply();

private:
    QNetworkAccessManager *manager;
    QNetworkRequest request;
    QPointer<QNetworkReply> reply;
    CookieJar *jar;
   // QList<QByteArray> *tmp;
    int m_progress;
    bool m_isLoading;

};

#endif // HTTPMANAGER_H
