#ifndef COOKIEJAR_H
#define COOKIEJAR_H
#include <QNetworkCookieJar>

class CookieJar : public QNetworkCookieJar
{
public:
    CookieJar();
    QList<QNetworkCookie> getCookies();
};

#endif // COOKIEJAR_H
