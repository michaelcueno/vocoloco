#ifndef COOKIEJAR_H
#define COOKIEJAR_H
#include <QNetworkCookieJar>
#include <QList>
#include <QByteArray>
#include <QNetworkCookie>
#include <QNetworkCookieJar>
#include <QSettings>

/*
 * Allows for a permanent cookie jar by saving cookies on delete to QSettings and then loading from QSettings on creation
 */

class CookieJar : public QNetworkCookieJar
{
public:
    CookieJar(QObject *parent) : QNetworkCookieJar(parent) { load(); }
    ~CookieJar() { save(); }
    void save();
    void load();
    QList<QNetworkCookie> getCookies();
    void PrintCookies();
};

#endif // COOKIEJAR_H
