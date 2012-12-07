/****************************************************************************
 * Copyright (C) 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ****************************************************************************/

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
#include <QProcess>

#include "cookiejar.h"
#include "postnewconversation.h"
#include "dummydesktopplayer.h"
#include "newmessage.h"
<<<<<<< HEAD
#include "dummydesktopplayer.h"  // Defined in the .pro file (automatically happens when build is switched)

/**
 * @brief This class acts as the backend controller for the QML engine viewer.
 *
 * This class was authored by Michael Cueno.
 * It is set as the root context of the QML engine and serves as the backed of the application.
 * Properties defined with the Q_INVOKABLE macro are made available to QML, these properties must
 * only be changed with their respective set functions since in these set functions is also an emit
 * signal that notifies the qml engine of the property change so that it can update it in the qml.
 * Also, all functions defined with the Q_INVOKABLE macro or defined as a public slot can be called
 * from within the qml.
 */
=======
#include "androidmediarecorder.h"  // Defined in the .pro file (automatically happens when build is switched)


>>>>>>> 33132f0b36ff52eb2b68c9890427c026b5fc67ab
class HttpManager : public QObject
{

    Q_OBJECT

    // These declarations are used by the compiler to link c++ properties to be used in QML
    // !! IMPORTANT !!
    //   These values must be changed by using set____, never changed directly!

    /**
     * @brief Used to tell QML the progress of a request to the server
     */
    Q_PROPERTY(int progress
               READ progress
               WRITE setProgress
               NOTIFY progressChanged )
    /**
     * @brief used to tell QML if the reply is still loading
     */
    Q_PROPERTY(bool isLoading
               READ isLoading
               WRITE setLoading
               NOTIFY loadingChanged )
    /**
     * @brief used to tell QML the path of the xml (depreciated)
     */
    Q_PROPERTY(QUrl path
               READ path
               WRITE setPath
               NOTIFY pathChanged )
    /**
     * @brief used to tell QML the username of the current user logged into the client
     */
    Q_PROPERTY(QString username
               READ username
               WRITE setUsername
               NOTIFY usernameChanged )
    /**
     * @brief used to tell QML the id of the newly created converstion so the client can go
     *
     * directly to it after creation of it in the new conversation screen
     */
    Q_PROPERTY(int newConvoId
               READ newConvoId
               WRITE setNewConvoId
               NOTIFY newConvoIdChanged )


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
    void setNewConvoId(int id);
    int newConvoId();
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
    Q_INVOKABLE void setNewMessageContent(QString content, QString id);
    Q_INVOKABLE bool postNewMessage();  // Returns false if new_convo doesn't have a title or any users

    // For the QML player
    Q_INVOKABLE void play();
    Q_INVOKABLE void record();
    Q_INVOKABLE void downloadAudio(QString url);  // Plays the audio after downloading
    Q_INVOKABLE void stopRecording();
    QNetworkAccessManager* getNam();


signals:
            //! Used to trigger events on successful login. i.e. go to home screen
    void loginSuccess();
            //! Used to throw login error screen, stays on login screen
    void loginFail();

    /* The signals below are used by the QML meta object system to notify QML components
     * of changes to the values they correspond to */

                          //! To notify the qml engine that the isLoading property changed
    void loadingChanged();
                          //! To notify the qml engine that the progress property changed
    void progressChanged();
                          //! To notify the qml engine that the path property changed
    void pathChanged();
                          //! To notify the qml engine that the username property changed
    void usernameChanged();
                          //! To notify the qml engine that the newConvoId property changed
    void newConvoIdChanged();
                          //! For signaling an error (usually results in an error screen appearing
    void error();
                          //! Triggered when a reply from the server finished downloaded
    void replyFinished();
                          //! Triggered when a new conversation is created
    void convoCreatedSignal();
                          //! Used to reload the homescreen after a new conversation has been posted for example
    void reloadHome();
                          //! Used to reload a conversation
    void reloadConvo();
                          //! Triggered when the audio is fininished playing in a message
    void playAudioDone();

public slots:
    void postCredentials(QString credentials);
    void setDownloadProgress(qint64 soFar,qint64 total);
    void authenticate();
    void writeAudioToFile(); // Plays the file at the end of the method TODO: Should be private
    void replyDone();
    void convoCreatedSlot();
    void messagePosted();

private:
    QNetworkAccessManager *manager;
    QNetworkRequest request;
    CookieJar *jar;
    int m_newConvoId;

    // QML Accessible Properties
    int m_progress;
    bool m_isLoading;
    QUrl xml_path;
    QString m_username;
    PostNewConversation *new_convo;
    NewMessage *new_message;
<<<<<<< HEAD
    MEDIA_OBJECT *player;
=======
    AndroidMediaRecorder *player;
>>>>>>> 33132f0b36ff52eb2b68c9890427c026b5fc67ab
};

#endif // HTTPMANAGER_H
