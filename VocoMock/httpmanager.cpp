#include "httpmanager.h"



HttpManager::HttpManager()
{
    manager = new QNetworkAccessManager();
}
HttpManager::~HttpManager()
{
    delete manager;
}


void HttpManager::requestXML(QString raw){

    qDebug() << raw;

    request = QNetworkRequest(QUrl("https://vocoloco.herokuapp.com/messages"));
    reply = manager->get(request);

    connect(reply, SIGNAL(finished()), this, SLOT(parseReply()));
}

/*
 * This method Posts login credentails to server @ vocoloco.herokuapp.com/login
 */
void HttpManager::postCredentials(QString credentials){

    QUrl postData;

    QStringList list = credentials.split(" ");
    QString usrn = list[0];
    QString pass = list[1];

    request = QNetworkRequest(QUrl("https://vocoloco.herokuapp.com/login"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");

    postData.addQueryItem("username", usrn);
    postData.addQueryItem("password", pass);

    // Attempt Login
    reply = manager->post(request, postData.encodedQuery());

    // When finished, jump to authenticate
    connect(reply, SIGNAL(finished()), this, SLOT(authenticate()));
}

/*
 * This method determines if the login post was a success or failure and emits the corresponding signals
 * TODO: Implement custom class inheriting QCookieJar for loacal storage in order to do single sign on,
 *      Also will allow a better way to check for successful login
 */
void HttpManager::authenticate(){
    QByteArray data = reply->read(2048);
    QList<QByteArray> headers = reply->rawHeaderList();

    if(headers[1] == "Set-Cookie")
        emit loginSuccess();
    else
        emit loginFail();



}

void HttpManager::parseReply(){
    QByteArray data = reply->read(2048);
    qDebug() << data;
    qDebug() << reply->rawHeaderList();
}
