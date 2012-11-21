#ifndef ANDROIDMEDIARECORDER_H
#define ANDROIDMEDIARECORDER_H
#include <jni.h>
 
class AndroidMediaRecorder
{
public:
    AndroidMediaRecorder();
    ~AndroidMediaRecorder();
    bool setUrl(const QString &url);
    bool record();
    bool pause();
    bool stop();
 
private:
    jobject m_audioRecorderObject;
 
};
 
#endif // ANDROIDMEDIARECORDER_H
