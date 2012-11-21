#ifndef HTTPMANAGER_H
#define HTTPMANAGER_H

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QAuthenticator>
#include <QByteArray>
#include <QUrl>
#include <QtDebug>
#include <QStringList>
#include <QString>
#include <QPointer>
#include <QFile>
#include <QTextStream>
#include <QDir>

#include "cookiejar.h"
#include "postnewconversation.h"
#include "newmessage.h"
#include "androidmediaobject.h"  // Defined in the .pro file (automatically happens when build is switched)


class HttpManager : public QObject
{

    Q_OBJECT

    // These declarations are used by the compiler to link c++ properties to be used in QML
    // !! IMPORTANT !!
    //   These values must be changed by using set____, never changed directly!
    Q_PROPERTY(int progress
               READ progress
               WRITE setProgress
               NOTIFY progressChanged )
    Q_PROPERTY(bool isLoading
               READ isLoading
               WRITE setLoading
               NOTIFY loadingChanged )
    Q_PROPERTY(QUrl path
               READ path
               WRITE setPath
               NOTIFY pathChanged )
    Q_PROPERTY(QString username
               READ username
               WRITE setUsername
               NOTIFY usernameChanged )



public:
    HttpManager();
    ~HttpManager();

    void setProgress(int prog);
    int progress();
    bool isLoading();
    void setLoading(bool x);
    QUrl path();
    void setPath(QUrl path);
    QString username();
    void setUsername(QString name);
    QNetworkAccessManager* getManager(){return manager;}

    Q_INVOKABLE bool hasSavedCookie();
    Q_INVOKABLE void logout();

    // For creating, posting, deleting a conversation
    Q_INVOKABLE void setNewConvoTitle(QString title);
    Q_INVOKABLE void addNewConvoUser(QString user);
    Q_INVOKABLE void removeNewConvoUser(QString user);
    Q_INVOKABLE void clearNewConvoUsers();
    Q_INVOKABLE bool postNewConvo();  // Returns false if new_convo doesn't have a title or any users
    Q_INVOKABLE void deleteConvo(QString convo_id);

    // For creating and posting a new message
    Q_INVOKABLE void setNewMessageContent(QString content);
    Q_INVOKABLE bool postNewMessage();  // Returns false if new_convo doesn't have a title or any users

    // For the QML player
    Q_INVOKABLE void play();
    Q_INVOKABLE void record();
    Q_INVOKABLE void downloadAudio(QString url);  // Plays the audio after downloading
    Q_INVOKABLE void stopRecording();
    QNetworkAccessManager* getNam();


signals:
    void loginSuccess();
    void loginFail();

    /* The signals below are used by the QML meta object system to notify QML components
     * of changes to the values they correspond to */
    void loadingChanged();
    void progressChanged();
    void pathChanged();
    void usernameChanged();
    void test();

public slots:
    void postCredentials(QString credentials);
    void setDownloadProgress(qint64 soFar,qint64 total);
    void authenticate();
    void writeAudioToFile(); // Plays the file at the end of the method TODO: Should be private


private:
    QNetworkAccessManager *manager;
    QNetworkRequest request;
    CookieJar *jar;

    // QML Accessible Properties
    int m_progress;
    bool m_isLoading;
    QUrl xml_path;
    QString m_username;
    PostNewConversation *new_convo;
    NewMessage *new_message;
    AndroidMediaObject *player;
};

#endif // HTTPMANAGER_H
