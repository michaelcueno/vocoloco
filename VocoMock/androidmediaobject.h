#ifndef ANDROIDMEDIAOBJECT_H
#define ANDROIDMEDIAOBJECT_H
#include <jni.h>
#include <QString>
#include <QDebug>

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
