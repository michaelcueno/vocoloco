#include "cookiejar.h"
#include <QDebug>


QList<QNetworkCookie> CookieJar::getCookies(){
    return this->allCookies();
}

void CookieJar::save()
{
    QList<QNetworkCookie> list = allCookies();
    QByteArray data;
    foreach (QNetworkCookie cookie, list) {
        data.append(cookie.toRawForm());
        data.append("\n");
    }
    QSettings settings;
    settings.setValue("Cookies",data);
    settings.sync();
}

void CookieJar::load()
{
    QSettings settings;
    QByteArray data = settings.value("Cookies").toByteArray();
    setAllCookies(QNetworkCookie::parseCookies(data));
    settings.sync();
    QList<QNetworkCookie> cookies = this->getCookies();
}

void CookieJar::PrintCookies(){
    qDebug() << getCookies();
}
