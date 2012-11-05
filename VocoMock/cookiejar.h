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

    /* This variable is used to delete the cookies in the settings for the applicaiton. The QApplicationViewer will set this
     * variable upon its destruction to either true or false depending on if the user checked the 'keep me logged in button'
     */
public: static bool STAY_LOGGED_IN;

public:
    CookieJar(QObject *parent);
    ~CookieJar();
    void save();
    void load();
    QList<QNetworkCookie> getCookies();
    void PrintCookies();
};

#endif // COOKIEJAR_H
