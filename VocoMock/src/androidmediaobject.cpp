#include "androidmediaobject.h"

static JavaVM* s_javaVM = 0;
static jclass s_audioRecorderClassID = 0;
static jmethodID s_audioRecorderConstructorMethodID=0;
static jmethodID s_audioRecorderSetUrlMethodID=0;
static jmethodID s_audioRecorderRecordMethodID=0;
static jmethodID s_audioRecorderStopMethodID=0;
static jmethodID s_audioRecorderReleaseMethodID=0;

static jclass s_audioPlayerClassID = 0;
static jmethodID s_audioPlayerConstructorMethodID=0;
static jmethodID s_audioPlayerSetUrlMethodID=0;
static jmethodID s_audioPlayerPlayMethodID=0;
static jmethodID s_audioPlayerPauseMethodID=0;
static jmethodID s_audioPlayerStopMethodID=0;
static jmethodID s_audioPlayerReleaseMethodID=0;

QString AndroidMediaObject::type = "";

AndroidMediaObject::AndroidMediaObject(QString type)
{
    JNIEnv* env;
    if( type == "recorder" ){
        AndroidMediaObject::type = "recorder";
        // Qt is running in a different thread than Java UI, so you always Java VM *MUST* be attached to current thread
        if (s_javaVM->AttachCurrentThread(&env, NULL)<0)
        {
            qCritical()<<"AttachCurrentThread failed";
            return;
        }

        // Create a new instance of QSimpleAudioPlayer
        m_audioRecorderObject = env->NewGlobalRef(env->NewObject(s_audioRecorderClassID, s_audioRecorderConstructorMethodID));
        if (!m_audioRecorderObject)
        {
            qCritical()<<"Can't create recorder";
            return;
        }

        // Don't forget to detach from current thread
        s_javaVM->DetachCurrentThread();
    }
    else if ( type == "player" )
    {
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
    else {
        qCritical() << "incorrect type passed in constructor";
    }
}

AndroidMediaObject::~AndroidMediaObject()
{
    if(AndroidMediaObject::type == "player")
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
        env->DeleteGlobalRef(m_audioPlayerObject);

    }
    else if (AndroidMediaObject::type == "recorder")
    {
        if (!m_audioRecorderObject)
            return;

        JNIEnv* env;
        if (s_javaVM->AttachCurrentThread(&env, NULL)<0)
        {
            qCritical()<<"AttachCurrentThread failed";
            return;
        }

        if (!env->CallBooleanMethod(m_audioRecorderObject, s_audioRecorderReleaseMethodID))
            qCritical()<<"Releasing media recorder object failed";

        s_javaVM->DetachCurrentThread();
        env->DeleteGlobalRef(m_audioRecorderObject);
    }
}


// Player functions
bool AndroidMediaObject::playerSetUrl(const QString &url)
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

bool AndroidMediaObject::play()
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

bool AndroidMediaObject::playerPause()
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

bool AndroidMediaObject::playerStop()
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


// Recorder functions
bool AndroidMediaObject::recorderSetUrl(const QString &url)
{
    if (!m_audioRecorderObject)
        return false;

    JNIEnv* env;
    if (s_javaVM->AttachCurrentThread(&env, NULL)<0)
    {
        qCritical()<<"AttachCurrentThread failed";
        return false;
    }
    jstring str = env->NewString(reinterpret_cast<const jchar*>(url.constData()), url.length());
    jboolean res = env->CallBooleanMethod(m_audioRecorderObject, s_audioRecorderSetUrlMethodID, str);
    env->DeleteLocalRef(str);
    s_javaVM->DetachCurrentThread();
    return res;
}

bool AndroidMediaObject::record()
{
    if (!m_audioRecorderObject)
        return false;

    JNIEnv* env;
    if (s_javaVM->AttachCurrentThread(&env, NULL)<0)
    {
        qCritical()<<"AttachCurrentThread failed";
        return false;
    }
    jboolean res = env->CallBooleanMethod(m_audioRecorderObject, s_audioRecorderRecordMethodID);
    s_javaVM->DetachCurrentThread();
}

bool AndroidMediaObject::recorderStop()
{
    if (!m_audioRecorderObject)
        return false;

    JNIEnv* env;
    if (s_javaVM->AttachCurrentThread(&env, NULL)<0)
    {
        qCritical()<<"AttachCurrentThread failed";
        return false;
    }
    jboolean res = env->CallBooleanMethod(m_audioRecorderObject, s_audioRecorderStopMethodID);
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
    // search for our classes
    jclass playerClazz=env->FindClass("org/kde/necessitas/origo/QSimpleAudioPlayer");
    if (!playerClazz)
    {
        qCritical()<<"Can't find QSimpleAudioPlayer class";
        return -1;
    }
    jclass recorderClazz=env->FindClass("org/kde/necessitas/origo/QSimpleAudioRecorder");
    if (!recorderClazz)
    {
        qCritical()<<"Can't find QSimpleAudioRecorder class";
        return -1;
    }
    // keep a global reference to it
    s_audioPlayerClassID = (jclass)env->NewGlobalRef(playerClazz);
    s_audioRecorderClassID = (jclass)env->NewGlobalRef(recorderClazz);


    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Player Methods !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
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

    // search for pause method
    s_audioPlayerPauseMethodID = env->GetMethodID(s_audioPlayerClassID, "pause", "()Z");
    if (!s_audioPlayerPauseMethodID)
    {
        qCritical()<<"Can't find pause method";
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

    /////////////////////////////??!!!!!!!!!!!!!!!!!! Recorder Methods !!!!!!!!!!!!!!!!!!!!!!!!
    // search for its contructor
    s_audioRecorderConstructorMethodID = env->GetMethodID(s_audioRecorderClassID, "<init>", "()V");
    if (!s_audioRecorderConstructorMethodID)
    {
        qCritical()<<"Can't find QSimpleAudioRecorder class contructor";
        return -1;
    }

    // search for setUrl method
    s_audioRecorderSetUrlMethodID = env->GetMethodID(s_audioRecorderClassID, "setUrl", "(Ljava/lang/String;)Z");
    if (!s_audioRecorderSetUrlMethodID)
    {
        qCritical()<<"Can't find setUrl method";
        return -1;
    }

    // search for record method
    s_audioRecorderRecordMethodID = env->GetMethodID(s_audioRecorderClassID, "record", "()Z");
    if (!s_audioRecorderRecordMethodID)
    {
        qCritical()<<"Can't find record";
        return -1;
    }

    // search for stop method
    s_audioRecorderStopMethodID = env->GetMethodID(s_audioRecorderClassID, "stop", "()Z");
    if (!s_audioRecorderStopMethodID)
    {
        qCritical()<<"Can't find stop method";
        return -1;
    }

    // search for release method
    s_audioRecorderReleaseMethodID = env->GetMethodID(s_audioRecorderClassID, "release", "()Z");
    if (!s_audioRecorderReleaseMethodID)
    {
        qCritical()<<"Can't find release method";
        return -1;
    }

    // register our native methods
    if (env->RegisterNatives(s_audioRecorderClassID, methods, sizeof(methods) / sizeof(methods[0])) < 0)
    {
        qCritical()<<"RegisterNatives failed";
        return -1;
    }

    qDebug()<<"Yahooo !";
    return JNI_VERSION_1_6;
}
