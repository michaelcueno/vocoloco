#ifndef ANDROIDMEDIAPLAYER_H
#define ANDROIDMEDIAPLAYER_H
#include <jni.h>
#include <QString>
 
class AndroidMediaPlayer
{

public:
    AndroidMediaPlayer();
    ~AndroidMediaPlayer();
    bool setUrl(const QString &url);
    bool play();
    bool pause();
    bool stop();
    void static Load_JNI(JavaVM *vm, void*);
private:
    jobject m_audioPlayerObject;
 
};
 
#endif // ANDROIDMEDIAPLAYER_H
