#include "httpmanager.h"



HttpManager::HttpManager()
{
    manager = new QNetworkAccessManager(this);
    jar = new CookieJar();
    manager->setCookieJar(jar);
 //   tmp = new QList<QByteArray>();
 //   reply = new HttpReply();
    setProgress(0);
   // QObject::connect(reply, SIGNAL(downloadProgress(int, int)), this, SIGNAL(progress(int)));
}
HttpManager::~HttpManager()
{
    delete manager;
}

int HttpManager::progress(){ return m_progress; }

void HttpManager::setProgress(int prog){ m_progress = prog; emit progressChanged(); }

void HttpManager::setDownloadProgress(qint64 soFar, qint64 total){
    setProgress((soFar/total) * 100);
}

/*
 * Sends a request. Correct implementation will request vocoloco.herokuapp.com/raw where raw is the
 * parameter passed in. This method is connected to the parse reply method which will run when the
 * request has finished (when it is fully loaded into the reply instance
 */
void HttpManager::requestXML(QString raw){

    qDebug() << raw;

    request = QNetworkRequest(QUrl("https://vocoloco.herokuapp.com/messages"));
    QNetworkReply *localReply = manager->get(request);

    connect(localReply, SIGNAL(finished()), this, SLOT(parseReply()));

}

/*
 * This method Posts login credentails to server @ vocoloco.herokuapp.com/login
 */
void HttpManager::postCredentials(QString credentials){

    QUrl postData;
    QString usrn;
    QString pass;

    QStringList list = credentials.split(" ");

    if(list.size() != 2){    // Error Checking
        emit loginFail();
    }else{
        usrn = list[0];
        pass = list[1];
    }

    request = QNetworkRequest(QUrl("https://vocoloco.herokuapp.com/login"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");

    postData.addQueryItem("username", usrn);
    postData.addQueryItem("password", pass);
    // Attempt Login
    reply = manager->post(request, postData.encodedQuery());
    reply->ignoreSslErrors();

    // When finished, jump to authenticate
    connect(reply, SIGNAL(finished()), this, SLOT(authenticate()));

   // connect(reply, SIGNAL(downloadProgress(qint64,qint64)), this, SLOT(setDownloadProgress(qint64,qint64)));
}

/*
 * This method determines if the login post was a success or failure and emits the corresponding signals
 * TODO: Implement custom class inheriting QCookieJar for loacal storage in order to do single sign on,
 *      Also will allow a better way to check for successful login
 */
void HttpManager::authenticate(){

    QList<QByteArray> headers = reply->rawHeaderList();
    QList<QNetworkCookie> cookies = jar->getCookies();
    if (cookies.isEmpty()){
        emit loginFail();
    }else{
        emit loginSuccess();
    }
}

/*
 * Dummy method for parsing a reply, not to be used in production
 */
void HttpManager::parseReply(){
/*
    QByteArray data = reply->read(2048);
    qDebug() << data;
    qDebug() << reply->rawHeaderList();
    */
}
