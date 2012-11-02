#include "cookiejar.h"

CookieJar::CookieJar()
{
}

QList<QNetworkCookie> CookieJar::getCookies(){
    return this->allCookies();
}
