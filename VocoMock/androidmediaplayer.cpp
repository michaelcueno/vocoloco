#include <QDebug>
 
#include "androidmediaplayer.h"
 
static JavaVM* s_javaVM = 0;
static jclass s_audioPlayerClassID = 0;
static jmethodID s_audioPlayerConstructorMethodID=0;
static jmethodID s_audioPlayerSetUrlMethodID=0;
static jmethodID s_audioPlayerPlayMethodID=0;
static jmethodID s_audioPlayerPauseMethodID=0;
static jmethodID s_audioPlayerStopMethodID=0;
static jmethodID s_audioPlayerReleaseMethodID=0;
 
AndroidMediaPlayer::AndroidMediaPlayer()
{
    JNIEnv* env;
    // Qt is running in a different thread than Java UI, so you always Java VM *MUST* be attached to current thread
    if (s_javaVM->AttachCurrentThread(&env, NULL)<0)
    {
        qCritical()<<"AttachCurrentThread failed";
        return;
    }
 
    // Create a new instance of QSimpleAudioPlayer
    m_audioPlayerObject = env->NewGlobalRef(env->NewObject(s_audioPlayerClassID, s_audioPlayerConstructorMethodID));
    if (!m_audioPlayerObject)
    {
        qCritical()<<"Can't create the player";
        return;
    }
 
    // Don't forget to detach from current thread
    s_javaVM->DetachCurrentThread();
}
 
AndroidMediaPlayer::~AndroidMediaPlayer()
{
    if (!m_audioPlayerObject)
        return;
 
    JNIEnv* env;
    if (s_javaVM->AttachCurrentThread(&env, NULL)<0)
    {
        qCritical()<<"AttachCurrentThread failed";
        return;
    }
 
    if (!env->CallBooleanMethod(m_audioPlayerObject, s_audioPlayerReleaseMethodID))
        qCritical()<<"Releasing media player object failed";
 
    s_javaVM->DetachCurrentThread();
}
 
bool AndroidMediaPlayer::setUrl(const QString &url)
{
    if (!m_audioPlayerObject)
        return false;
 
    JNIEnv* env;
    if (s_javaVM->AttachCurrentThread(&env, NULL)<0)
    {
        qCritical()<<"AttachCurrentThread failed";
        return false;
    }
    jstring str = env->NewString(reinterpret_cast<const jchar*>(url.constData()), url.length());
    jboolean res = env->CallBooleanMethod(m_audioPlayerObject, s_audioPlayerSetUrlMethodID, str);
    env->DeleteLocalRef(str);
    s_javaVM->DetachCurrentThread();
    return res;
}
 
bool AndroidMediaPlayer::play()
{
    if (!m_audioPlayerObject)
        return false;
 
    JNIEnv* env;
    if (s_javaVM->AttachCurrentThread(&env, NULL)<0)
    {
        qCritical()<<"AttachCurrentThread failed";
        return false;
    }
    jboolean res = env->CallBooleanMethod(m_audioPlayerObject, s_audioPlayerPlayMethodID);
    s_javaVM->DetachCurrentThread();
    return res;
}
 
bool AndroidMediaPlayer::pause()
{
    if (!m_audioPlayerObject)
        return false;
 
    JNIEnv* env;
    if (s_javaVM->AttachCurrentThread(&env, NULL)<0)
    {
        qCritical()<<"AttachCurrentThread failed";
        return false;
    }
    jboolean res = env->CallBooleanMethod(m_audioPlayerObject, s_audioPlayerPauseMethodID);
    s_javaVM->DetachCurrentThread();
    return res;
}
 
bool AndroidMediaPlayer::stop()
{
    if (!m_audioPlayerObject)
        return false;
 
    JNIEnv* env;
    if (s_javaVM->AttachCurrentThread(&env, NULL)<0)
    {
        qCritical()<<"AttachCurrentThread failed";
        return false;
    }
    jboolean res = env->CallBooleanMethod(m_audioPlayerObject, s_audioPlayerStopMethodID);
    s_javaVM->DetachCurrentThread();
    return res;
}

// our native method, it is called by the java code above
static int addTwoNumbers(JNIEnv * /*env*/, jobject /*thiz*/,int a, int b)
{
    return a+b;
}

static JNINativeMethod methods[] = {
    {"addTwoNumbers", "(II)I", (void *)addTwoNumbers}
};

// this method is called immediately after the module is load
JNIEXPORT jint JNI_OnLoad(JavaVM* vm, void* /*reserved*/)
{
    JNIEnv* env;
    if (vm->GetEnv(reinterpret_cast<void**>(&env), JNI_VERSION_1_6) != JNI_OK) {
        qCritical()<<"Can't get the enviroument";
        return -1;
    }

    s_javaVM = vm;
    // search for our class
    jclass clazz=env->FindClass("org/kde/necessitas/origo/QSimpleAudioPlayer");
    if (!clazz)
    {
        qCritical()<<"Can't find QSimpleAudioPlayer class";
        return -1;
    }
    // keep a global reference to it
    s_audioPlayerClassID = (jclass)env->NewGlobalRef(clazz);

    // search for its contructor
    s_audioPlayerConstructorMethodID = env->GetMethodID(s_audioPlayerClassID, "<init>", "()V");
    if (!s_audioPlayerConstructorMethodID)
    {
        qCritical()<<"Can't find QSimpleAudioPlayer class contructor";
        return -1;
    }

    // search for setUrl method
    s_audioPlayerSetUrlMethodID = env->GetMethodID(s_audioPlayerClassID, "setUrl", "(Ljava/lang/String;)Z");
    if (!s_audioPlayerSetUrlMethodID)
    {
        qCritical()<<"Can't find setUrl method";
        return -1;
    }

    // search for play method
    s_audioPlayerPlayMethodID = env->GetMethodID(s_audioPlayerClassID, "play", "()Z");
    if (!s_audioPlayerPlayMethodID)
    {
        qCritical()<<"Can't find start method";
        return -1;
    }

    // search for play method
    s_audioPlayerPauseMethodID = env->GetMethodID(s_audioPlayerClassID, "pause", "()Z");
    if (!s_audioPlayerPauseMethodID)
    {
        qCritical()<<"Can't find start method";
        return -1;
    }

    // search for stop method
    s_audioPlayerStopMethodID = env->GetMethodID(s_audioPlayerClassID, "stop", "()Z");
    if (!s_audioPlayerStopMethodID)
    {
        qCritical()<<"Can't find stop method";
        return -1;
    }

    // search for release method
    s_audioPlayerReleaseMethodID = env->GetMethodID(s_audioPlayerClassID, "release", "()Z");
    if (!s_audioPlayerReleaseMethodID)
    {
        qCritical()<<"Can't find release method";
        return -1;
    }

    // register our native methods
    if (env->RegisterNatives(s_audioPlayerClassID, methods, sizeof(methods) / sizeof(methods[0])) < 0)
    {
        qCritical()<<"RegisterNatives failed";
        return -1;
    }

    qDebug()<<"Yahooo !";
    return JNI_VERSION_1_6;
}
