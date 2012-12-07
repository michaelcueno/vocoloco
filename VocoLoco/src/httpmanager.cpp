/***********************************************************************
 * COPYRIGHT @ 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ***********************************************************************/

#include "httpmanager.h"

QDir dir;
static QString APP = "http://vocoloco.herokuapp.com/";

/**
 * @brief The constructor for the HttpManager
 *
 * This creates instances of QNetworkAccessManager, CookieJar, PostNewConversation and NewMessage.
 * It also sets isLoading to false.
 */
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

    setProgress(0); // Init
}

/**
 * @brief Destructor for the HttpManager. Deletes QNetworkAccessManager, and CookieJar
 */
HttpManager::~HttpManager()
{
    delete manager;
    delete jar;
    delete new_convo;
    delete new_message;
}

/////////////////////////////////////// TEMP FOR AUDIO PLAYER

/**
 * @brief Sends a request to "url". This method will then download the audio file
 * that is hosted at "url" and call the slot writeAudioToFile().
 */
void HttpManager::downloadAudio(QString url){

    qDebug() << url;
    request = QNetworkRequest(QUrl( url ));
    QNetworkReply *localreply = manager->get(request);
    localreply->ignoreSslErrors();
    connect(localreply, SIGNAL(finished()), this, SLOT(writeAudioToFile()));
}

/**
 * @brief Plays audio file in local storage at TMP_AUDIO_PATH
 */
void HttpManager::play(){

    // We use one location for all audio files, each play() rewrites this file
    QString TMP_AUDIO_PATH = dir.absolutePath() + "/tmpAudio";

    QByteArray latin = TMP_AUDIO_PATH.toLatin1();

    qDebug() << latin;

    player = new MEDIA_OBJECT("player");
    if (!player->playerSetUrl(latin))
    {
        qDebug() << "Error: couldn't load file";
    }
    if (!player->play()) {
        qDebug() << "Error: couldn't play file";
    }


    emit playAudioDone();
    qDebug() << "Should have turned black";
    delete player;

}

/**
 * @brief Writes the audio file to local storage.
 */
void HttpManager::writeAudioToFile(){

    QString TMP_AUDIO_PATH = dir.absolutePath() + "/tmpAudio";

    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());

    QFile file(TMP_AUDIO_PATH);
    if ( file.open(QFile::WriteOnly | QFile::Truncate) )
    {

        QTextStream stream( &file );
        stream << reply->readAll();
    }
    else
    {
        qDebug( "Could not create file %s" );
    }

    file.close();

    QFile contents(TMP_AUDIO_PATH);

    if ( contents.open(QFile::ReadWrite) )
    {
        qDebug() << contents.read(2048);
    }
    else
    {
        qDebug( "Could not open file %s" );
    }

    this->play();
}

/**
 * @brief We couldn't get this to work unfortunately
 */
void HttpManager::record()
{
    QString TMP_AUDIO_PATH = dir.absolutePath() + "/tmpAudio.3gp";
    QByteArray latin = TMP_AUDIO_PATH.toLatin1();
    player = new MEDIA_OBJECT("recorder");
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

bool HttpManager::isLoading(){ return m_isLoading; }

void HttpManager::setLoading(bool x){ m_isLoading = x; emit loadingChanged();}

void HttpManager::setPath(QUrl path){ xml_path = path; emit pathChanged(); }

QUrl HttpManager::path(){ return xml_path; }

void HttpManager::setUsername(QString name){ m_username = name; emit usernameChanged();}

QString HttpManager::username(){ return m_username; }

void HttpManager::setNewConvoId(int id) { m_newConvoId = id; emit newConvoIdChanged(); }

int HttpManager::newConvoId() { return m_newConvoId; }

QNetworkAccessManager* HttpManager::getNam(){ return manager; }

void HttpManager::setDownloadProgress(qint64 soFar, qint64 total){
    setProgress((soFar/total) * 100);
}

/**
 * @brief Sets the loading variable to done so that qml can stop the loading animation
 */
void HttpManager::replyDone()
{
    setLoading(false);
    emit reloadHome();
}


//////////////////////////////////////// Interaction invoving Conversations //////////////////////////////////////////

//! @brief Sets the title for a new conversation that will later be pushed to the server
void HttpManager::setNewConvoTitle(QString title)
{
    new_convo->setTitle(title);
}

/**
 * @brief Adds a user to the conversation that will be sent to the server vai POST
 */
void HttpManager::addNewConvoUser(QString user)
{
    new_convo->addUser(user);
}

//! @brief Removes a user from the PostNewConversation model
void HttpManager::removeNewConvoUser(QString user)
{
    new_convo->removeUser(user);
}

//! @brief Clears all users from the new coversation
void HttpManager::clearNewConvoUsers()
{
    new_convo->clearUsers();
}

/**
 * Sends the post request to the server at POST /conversations
 */
bool HttpManager::postNewConvo()
{
    // Error Check (Check for no users added, or no title
    if( new_convo->noTitle() || new_convo->noUsers() ){
        return false;
    }

    // Start Post Request
    request = QNetworkRequest(QUrl(APP + "conversation" ));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "text/xml");


    // Attempt Post
    QNetworkReply *reply = manager->post(request, new_convo->getXML().toAscii());
    setLoading(true);

    reply->ignoreSslErrors();

    connect(reply, SIGNAL(finished()), this, SLOT(convoCreatedSlot()));
    return true;
}

/**
 * @brief Delete a conversation. Posts to the server to implement the delete from the server
 * @param convo_id
 */
void HttpManager::deleteConvo(QString convo_id)
{
    request = QNetworkRequest(QUrl(APP + "conversation/delete/" + convo_id ));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");

    // attempt delete
    QNetworkReply *reply = manager->get(request);
    setLoading(true);

    connect(reply, SIGNAL(finished()), this, SLOT(replyDone()));
}

/**
 * @brief Sets loading variable to false, and emits convoCreatedSignal for the qml to trigger the screen change
 */
void HttpManager::convoCreatedSlot()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
    setLoading(false);

    // Get new convo id from reply
    QByteArray convoId = reply->readAll();

    // type cast to int
    int i_convoId = convoId.toInt();
    if (i_convoId == -1) {
        emit error();
    } else {
        setNewConvoId(i_convoId);
    }

    emit convoCreatedSignal();
    emit reloadHome();
}

//////////////////////////////////////////////////////////  Methods For Posting a New Message ///////////////////////////////

/**
 * @brief Sets the content and converstaion id of the message object to be posted
 * @param content
 * @param id
 */
void HttpManager::setNewMessageContent(QString content, QString id)
{
    new_message->setContent(content);
    new_message->setId(id);
    new_message->setOwner(m_username);
}

/**
 * @brief This method will post the message object to the server
 */
bool HttpManager::postNewMessage(){

    // Error Check (not valid if no conent in message)
    if( new_message->noContent() ){
        return false;
    }

    // Start Post Request
    request = QNetworkRequest(QUrl(APP + "conversation/respondtext/" + new_message->getId()));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "text/xml");


    // Attempt Post
    QNetworkReply *reply = manager->post(request, new_message->getXml().toAscii());

    reply->ignoreSslErrors();

    connect(reply, SIGNAL(finished()), this, SLOT(messagePosted()));
    return true;
}

/**
 * @brief Slot called after message successfully posted to server. Throws signal to update QML
 */
void HttpManager::messagePosted()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());

    emit reloadConvo();
}

/**
 * @brief Checks if there is a saved cookie on file
 * @return Boolean
 */
bool HttpManager::hasSavedCookie(){
    QSettings settings;
    QVariant cookie = settings.value("Cookies");
    if(settings.contains("Cookies")){
        setUsername(settings.value("Username").toString());
        return true;
    }else{
        return false;
    }
}

/**
 * @brief This method Posts login credentails to server @ vocoloco.herokuapp.com/login
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

    setUsername(usrn);
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

/**
 * @brief This method determines if the login post was a success or failure and emits the corresponding signals
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

/**
 * @brief Logs out of the app, (deletes the cookie)
 */
void HttpManager::logout(){
    QSettings settings;
    settings.clear();
    CookieJar::STAY_LOGGED_IN = false;
    delete jar;
    jar = new CookieJar(this);
}

