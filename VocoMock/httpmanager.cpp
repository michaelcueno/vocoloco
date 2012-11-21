#include "httpmanager.h"

QDir dir;
static QString APP = "http://vocoloco.herokuapp.com/";

HttpManager::HttpManager()
{
    manager = new QNetworkAccessManager(this);
    jar = new CookieJar(this);
    manager->setCookieJar(jar);
    m_isLoading = false;
    new_convo = new PostNewConversation();
    new_message = new NewMessage();


    // QML Player
    player = 0;

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

/////////////////////////////////////// TEMP FOR AUDIO PLAYER

/*
 * Sends a request to "url". This method will then download the audio file
 * that is hosted at "url" and call the slot writeAudioToFile().
 */
void HttpManager::downloadAudio(QString url){

    request = QNetworkRequest(QUrl( url ));
    QNetworkReply *localreply = manager->get(request);
    localreply->ignoreSslErrors();
    connect(localreply, SIGNAL(finished()), this, SLOT(writeAudioToFile()));
}

/**
 * @brief Plays audio file in local storage at TMP_AUDIO_PATH
 */
void HttpManager::play(){

    QString TMP_AUDIO_PATH = dir.absolutePath() + "/tmpAudio";

    QByteArray latin = TMP_AUDIO_PATH.toLatin1();

    qDebug() << latin;

    player = new AndroidMediaObject("player");
    if (!player->playerSetUrl(latin))
    {
        qDebug() << "Error: couldn't load file";
    }
    if (!player->play()) {
        qDebug() << "Error: couldn't play file";
    }

    delete player;

}

/**
 * Writes the audio file to local storage.
 */
void HttpManager::writeAudioToFile(){

    QString TMP_AUDIO_PATH = dir.absolutePath() + "/tmpAudio";

    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());

    QFile file(TMP_AUDIO_PATH);
    if ( file.open(QFile::ReadWrite) )
    {
        QTextStream stream( &file );
        stream << reply->readAll();
    }
    else
    {
        qDebug( "Could not create file %s", TMP_AUDIO_PATH );
    }

    file.close();

    QFile contents(TMP_AUDIO_PATH);

    if ( contents.open(QFile::ReadWrite) )
    {
        qDebug() << contents.read(2048);
    }
    else
    {
        qDebug( "Could not open file %s", TMP_AUDIO_PATH );
    }

    this->play();
}

void HttpManager::record()
{
    QString TMP_AUDIO_PATH = dir.absolutePath() + "/tmpAudio.3gp";
    QByteArray latin = TMP_AUDIO_PATH.toLatin1();
    player = new AndroidMediaObject("recorder");
    player->recorderSetUrl(latin);
     qDebug() << latin;
    player->record();
}

void HttpManager::stopRecording()
{
    if(player){
        player->recorderStop();
    }
}

/////////////////////////////////////////////////////// End of Audio Player stuff

/**
 * @brief progress of a current http request
 */
int HttpManager::progress(){ return m_progress; }

void HttpManager::setProgress(int prog){ m_progress = prog; emit progressChanged(); }

/**
 * @brief Boolean given to QML to mark if a request is loading
 *
 * This is used by the spinner at the login screen for example.
 */
bool HttpManager::isLoading(){ return m_isLoading; }

void HttpManager::setLoading(bool x){ m_isLoading = x; emit loadingChanged();}

void HttpManager::setPath(QUrl path){ xml_path = path; emit pathChanged(); }

QUrl HttpManager::path(){ return xml_path; }

void HttpManager::setUsername(QString name){ m_username = name; emit usernameChanged();}

QString HttpManager::username(){ return m_username; }

QNetworkAccessManager* HttpManager::getNam(){ return manager; }

void HttpManager::setDownloadProgress(qint64 soFar, qint64 total){
    setProgress((soFar/total) * 100);
}

////////////////////////////////////////////////////////////////////////////////// Interaction invoving Conversations //////////////////////////////////////////

// Sets the title for a new conversation that will later be pushed to the server
void HttpManager::setNewConvoTitle(QString title)
{
    new_convo->setTitle(title);
}

// Adds a user to the conversation that will be sent to the server vai POST
void HttpManager::addNewConvoUser(QString user)
{
    new_convo->addUser(user);
}

void HttpManager::removeNewConvoUser(QString user)
{
    new_convo->removeUser(user);
}

void HttpManager::clearNewConvoUsers()
{
    new_convo->clearUsers();
}

// Sends the post request to the server at POST /conversations
bool HttpManager::postNewConvo()
{
    // Error Check (Check for no users added, or no title
    if( new_convo->noTitle() || new_convo->noUsers() ){
        return false;
    }

    // Start Post Request
    request = QNetworkRequest(QUrl(APP + "conversation" ));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "text/xml");


    // Attempt Login
    QNetworkReply *reply = manager->post(request, new_convo->getXML().toAscii());

    reply->ignoreSslErrors();

    connect(reply, SIGNAL(finished()), this, SLOT(parseReply()));
    return true;
}

void HttpManager::deleteConvo(QString convo_id)
{
    qDebug() << "TODO: imlement deleteConvo(" + convo_id + ") In HttpManager";
}

//////////////////////////////////////////////////////////  Methods For Posting a New Message ///////////////////////////////

void HttpManager::setNewMessageContent(QString content){
    qDebug() << "TODO: implement setNewMessageContent in HttpManager.cpp";
}

bool HttpManager::postNewMessage(){
    return false;
}

bool HttpManager::hasSavedCookie(){
    QSettings settings;
    QVariant cookie = settings.value("Cookies");
    if(settings.contains("Cookies"))
        return true;
    else
        return false;
}

/*
 * This method Posts login credentails to server @ vocoloco.herokuapp.com/login
 */
void HttpManager::postCredentials(QString credentials){

    setLoading(true);  // for spinner in qml

    QUrl postData;
    QString usrn;
    QString pass;

    QSettings settings;

    QStringList list = credentials.split(" ");

    if(list.size() != 2){    // Error Checking
        emit loginFail();
    }else{
        usrn = list[0];
        pass = list[1];
    }

    settings.setValue("Username", usrn);
    request = QNetworkRequest(QUrl(APP + "login"));
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
    QSettings settings;
    jar->save();

    if (cookies.isEmpty()){
        emit loginFail();
    }else{
        emit loginSuccess();
        setUsername(settings.value("Username").toString());
    }
    setLoading(false);
}

void HttpManager::logout(){
    QSettings settings;
    settings.clear();
    CookieJar::STAY_LOGGED_IN = false;
    delete jar;
    jar = new CookieJar(this);
   // CookieJar::STAY_LOGGED_IN = true;  // Will need to be set back to implement to login screen instead of Qt.quit
}

