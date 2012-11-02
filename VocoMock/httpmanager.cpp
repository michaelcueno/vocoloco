#include "httpmanager.h"


static QString app = "https://vocoloco.herokuapp.com/";


HttpManager::HttpManager()
{
    manager = new QNetworkAccessManager(this);
    jar = new CookieJar(this);
    manager->setCookieJar(jar);
    m_isLoading = false;

 //   tmp = new QList<QByteArray>();
 //   reply = new HttpReply();
    setProgress(0);
   // QObject::connect(reply, SIGNAL(downloadProgress(int, int)), this, SIGNAL(progress(int)));
}
HttpManager::~HttpManager()
{
    delete manager;
    delete jar;
}

int HttpManager::progress(){ return m_progress; }

void HttpManager::setProgress(int prog){ m_progress = prog; emit progressChanged(); }

bool HttpManager::isLoading(){ return m_isLoading; }

void HttpManager::setLoading(bool x){ m_isLoading = x; emit loadingChanged();}

void HttpManager::setPath(QUrl path){ xml_path = path; emit pathChanged(); }

QUrl HttpManager::path(){ return xml_path; }

void HttpManager::setDownloadProgress(qint64 soFar, qint64 total){
    setProgress((soFar/total) * 100);
}

QNetworkAccessManager* HttpManager::getNam(){ return manager; }

bool HttpManager::hasSavedCookie(){
    QSettings settings;
    if(settings.contains("Cookies")){
        return true;
    }
    else {return false;}
}


/*
 * Sends a request. Correct implementation will request vocoloco.herokuapp.com/requested where requested is the
 * parameter passed in. This method is connected to the parse reply method which will run when the
 * request has finished (when it is fully downloaded into the reply instance)
 */
void HttpManager::requestXML(QString requested ){

    request = QNetworkRequest(QUrl("https://vocoloco.herokuapp.com/" + requested ));
    QNetworkReply *localreply = manager->get(request);
    localreply->ignoreSslErrors();
    connect(localreply, SIGNAL(readyRead()), this, SLOT(parseReply()));
}

/*
 * This method Posts login credentails to server @ vocoloco.herokuapp.com/login
 */
void HttpManager::postCredentials(QString credentials){

    setLoading(true);  // for spinner in qml

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
    QNetworkReply *reply = manager->post(request, postData.encodedQuery());
    reply->ignoreSslErrors();

    // When finished, jump to authenticate
    connect(reply, SIGNAL(finished()), this, SLOT(authenticate()));

}

/*
 * This method determines if the login post was a success or failure and emits the corresponding signals
 * TODO: Implement custom class inheriting QCookieJar for loacal storage in order to do single sign on,
 *      Also will allow a better way to check for successful login
 */
void HttpManager::authenticate(){
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
    QList<QByteArray> headers = reply->rawHeaderList();
    QList<QNetworkCookie> cookies = jar->getCookies();
    jar->save();

    if (cookies.isEmpty()){
        emit loginFail();
    }else{
        emit loginSuccess();
    }
    setLoading(false);
}

/*
 * Dummy method for parsing a reply, not to be used in production
 */
void HttpManager::parseReply(){

    CookieJar *test = new CookieJar(this);
    QDir dir;
    QString path = dir.absolutePath();
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
    QFile file(path + "/conversations.xml");
    if ( file.open(QFile::ReadWrite) )
    {
        QTextStream stream( &file );
        stream << reply->read(2048);
    }
    else
    {
        qDebug( "Could not create file %s", "filename" );
    }

    file.close();

    setPath(QUrl(app + "conversations"));

    /*QFile test(path + "/conversations.xml");
    if (test.pos() == 0) {
        qDebug() << "Empty";
    } else {
        qDebug() << "Not empty";
    }
    if ( file.open(QFile::ReadOnly)){
        qDebug() << test.read(2048);
    }
    else{
        qDebug() << "Could not open file";
    }*/
}