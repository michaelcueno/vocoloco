#include "cookiejar.h"
#include <QDebug>

bool CookieJar::STAY_LOGGED_IN = true;  // Must be true until application destruction in order to preserve session while app is open

CookieJar::CookieJar(QObject *parent) : QNetworkCookieJar(parent)
{
    load();
}

/**
 * Destructor that will save the cookie to local storage if boolean STAY_LOGGED_IN is true
 */
CookieJar::~CookieJar()
{
    if(CookieJar::STAY_LOGGED_IN)
        save();
    else{
       // do not save
    }
}

QList<QNetworkCookie> CookieJar::getCookies(){
    return this->allCookies();
}

/**
 * Saves cookie to QSettings object which is stored in the directory where the binaries are kept.
 */
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

/**
 * If a cookie is saved in the QSettings then this will load that cookie into the cookiejar for all
 * cookie jars accross the application
 */
void CookieJar::load()
{
    QSettings settings;
    QByteArray data = settings.value("Cookies").toByteArray();
    setAllCookies(QNetworkCookie::parseCookies(data));
    settings.sync();
   // QList<QNetworkCookie> cookies = this->getCookies();
}

/**
 * @brief Just for debugging, prints a list of the cookies in this jar
 */
void CookieJar::PrintCookies(){
    qDebug() << getCookies();
}

