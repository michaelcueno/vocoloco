/****************************************************************************
 * Copyright (C) 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ****************************************************************************/


#ifndef ANDROIDMEDIAOBJECT_H
#define ANDROIDMEDIAOBJECT_H
#include <jni.h>
#include <QString>
#include <QDebug>

/**
 * @brief This class connects to the JVM on android for audio
 *
 *  This class connects the c++ of the backend to our application to the Java Virtual Machine registered with
 *  the android device. It sets up calls to record, play, pause and stop (ect) all referencing one file location.
 *  This means that every audio file recorded, downloaded and played, all reside in one audio file that is
 *  coninually rewritten.
 */
class AndroidMediaObject
{
public:
    AndroidMediaObject(QString type);
    ~AndroidMediaObject();

    // Player functions
    bool playerSetUrl(const QString &url);
    bool play();
    bool playerPause();
    bool playerStop();

    // Recorder functions
    bool recorderSetUrl(const QString &url);
    bool record();
    bool recorderStop();

    static QString type;

private:
    jobject m_audioPlayerObject;
    jobject m_audioRecorderObject;
};

#endif // ANDROIDMEDIAOBJECT_H
