/****************************************************************************
 * Copyright (C) 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ****************************************************************************/


#ifndef COOKIEJAR_H
#define COOKIEJAR_H
#include <QNetworkCookieJar>
#include <QList>
#include <QByteArray>
#include <QNetworkCookie>
#include <QNetworkCookieJar>
#include <QSettings>

/**
 * @brief Allows for a permanent cookie jar by saving cookies on delete to QSettings and then loading from QSettings on creation
 *
 *  Allows for a permanent cookie jar by saving cookies on delete to QSettings and then loading from QSettings on creation.
 *  The QML engine requires this functionality because it sends a new request for all contents it recieves from the server
 *  (conversations, messages, contacts...ect). Each one of these requests is created in a different thread and instantiates
 *  its own QNetworkAccessManager. This means it creates a new cookie jar. By using this cookie jar for each instantiation,
 *  cookies are able to be reused, thus the user is able to stay logged in across the application.
 */

class CookieJar : public QNetworkCookieJar
{

/**
 * This variable is used to delete the cookies in the settings for the applicaiton. The QApplicationViewer will set this
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
