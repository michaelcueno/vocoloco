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
#include <QFile>
#include <QTextStream>
#include <QDir>

#include "cookiejar.h"

class HttpManager : public QObject
{

    Q_OBJECT

    // These declarations are used by the compiler to link c++ properties to be used in QML
    // !! IMPORTANT !!
    //   These values must be changed by using set____, never changed directly!
    Q_PROPERTY(int progress
               READ progress
               WRITE setProgress
               NOTIFY progressChanged )
    Q_PROPERTY(bool isLoading
               READ isLoading
               WRITE setLoading
               NOTIFY loadingChanged )
    Q_PROPERTY(QUrl path
               READ path
               WRITE setPath
               NOTIFY pathChanged )


public:
    HttpManager();
    ~HttpManager();

    void setProgress(int prog);
    int progress();
    bool isLoading();
    void setLoading(bool x);
    QUrl path();
    void setPath(QUrl path);
    QNetworkAccessManager* getManager(){return manager;}

    Q_INVOKABLE bool hasSavedCookie();
    Q_INVOKABLE void logout();

    QNetworkAccessManager* getNam();


signals:
    void loginSuccess();
    void loginFail();

    /* The signals below are used by the QML meta object system to notify QML components
     * of changes to the values they correspond to */
    void loadingChanged();
    void progressChanged();
    void pathChanged();
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
    CookieJar *jar;

    // QML Accessible Properties
    int m_progress;
    bool m_isLoading;
    QUrl xml_path;

};

#endif // HTTPMANAGER_H
