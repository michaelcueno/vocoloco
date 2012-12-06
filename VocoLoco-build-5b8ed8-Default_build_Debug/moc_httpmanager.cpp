/****************************************************************************
** Meta object code from reading C++ file 'httpmanager.h'
**
** Created: Wed Dec 5 19:48:15 2012
**      by: The Qt Meta Object Compiler version 63 (Qt 4.8.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../VocoLoco/src/httpmanager.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'httpmanager.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_HttpManager[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      34,   14, // methods
       5,  184, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
      13,       // signalCount

 // signals: signature, parameters, type, tag, flags
      13,   12,   12,   12, 0x05,
      28,   12,   12,   12, 0x05,
      40,   12,   12,   12, 0x05,
      57,   12,   12,   12, 0x05,
      75,   12,   12,   12, 0x05,
      89,   12,   12,   12, 0x05,
     107,   12,   12,   12, 0x05,
     127,   12,   12,   12, 0x05,
     135,   12,   12,   12, 0x05,
     151,   12,   12,   12, 0x05,
     172,   12,   12,   12, 0x05,
     185,   12,   12,   12, 0x05,
     199,   12,   12,   12, 0x05,

 // slots: signature, parameters, type, tag, flags
     227,  215,   12,   12, 0x0a,
     264,  252,   12,   12, 0x0a,
     299,   12,   12,   12, 0x0a,
     314,   12,   12,   12, 0x0a,
     333,   12,   12,   12, 0x0a,
     345,   12,   12,   12, 0x0a,
     364,   12,   12,   12, 0x0a,

 // methods: signature, parameters, type, tag, flags
     385,   12,  380,   12, 0x02,
     402,   12,   12,   12, 0x02,
     417,  411,   12,   12, 0x02,
     448,  443,   12,   12, 0x02,
     473,  443,   12,   12, 0x02,
     501,   12,   12,   12, 0x02,
     522,   12,  380,   12, 0x02,
     546,  537,   12,   12, 0x02,
     578,  567,   12,   12, 0x02,
     616,   12,  380,   12, 0x02,
     633,   12,   12,   12, 0x02,
     640,   12,   12,   12, 0x02,
     653,  649,   12,   12, 0x02,
     676,   12,   12,   12, 0x02,

 // properties: name, type, flags
     696,  692, 0x02495103,
     705,  380, 0x01495003,
     720,  715, 0x11495103,
     733,  725, 0x0a495103,
     742,  692, 0x02495103,

 // properties: notify_signal_id
       3,
       2,
       4,
       5,
       6,

       0        // eod
};

static const char qt_meta_stringdata_HttpManager[] = {
    "HttpManager\0\0loginSuccess()\0loginFail()\0"
    "loadingChanged()\0progressChanged()\0"
    "pathChanged()\0usernameChanged()\0"
    "newConvoIdChanged()\0error()\0replyFinished()\0"
    "convoCreatedSignal()\0reloadHome()\0"
    "reloadConvo()\0playAudioDone()\0credentials\0"
    "postCredentials(QString)\0soFar,total\0"
    "setDownloadProgress(qint64,qint64)\0"
    "authenticate()\0writeAudioToFile()\0"
    "replyDone()\0convoCreatedSlot()\0"
    "messagePosted()\0bool\0hasSavedCookie()\0"
    "logout()\0title\0setNewConvoTitle(QString)\0"
    "user\0addNewConvoUser(QString)\0"
    "removeNewConvoUser(QString)\0"
    "clearNewConvoUsers()\0postNewConvo()\0"
    "convo_id\0deleteConvo(QString)\0content,id\0"
    "setNewMessageContent(QString,QString)\0"
    "postNewMessage()\0play()\0record()\0url\0"
    "downloadAudio(QString)\0stopRecording()\0"
    "int\0progress\0isLoading\0QUrl\0path\0"
    "QString\0username\0newConvoId\0"
};

void HttpManager::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        HttpManager *_t = static_cast<HttpManager *>(_o);
        switch (_id) {
        case 0: _t->loginSuccess(); break;
        case 1: _t->loginFail(); break;
        case 2: _t->loadingChanged(); break;
        case 3: _t->progressChanged(); break;
        case 4: _t->pathChanged(); break;
        case 5: _t->usernameChanged(); break;
        case 6: _t->newConvoIdChanged(); break;
        case 7: _t->error(); break;
        case 8: _t->replyFinished(); break;
        case 9: _t->convoCreatedSignal(); break;
        case 10: _t->reloadHome(); break;
        case 11: _t->reloadConvo(); break;
        case 12: _t->playAudioDone(); break;
        case 13: _t->postCredentials((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 14: _t->setDownloadProgress((*reinterpret_cast< qint64(*)>(_a[1])),(*reinterpret_cast< qint64(*)>(_a[2]))); break;
        case 15: _t->authenticate(); break;
        case 16: _t->writeAudioToFile(); break;
        case 17: _t->replyDone(); break;
        case 18: _t->convoCreatedSlot(); break;
        case 19: _t->messagePosted(); break;
        case 20: { bool _r = _t->hasSavedCookie();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 21: _t->logout(); break;
        case 22: _t->setNewConvoTitle((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 23: _t->addNewConvoUser((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 24: _t->removeNewConvoUser((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 25: _t->clearNewConvoUsers(); break;
        case 26: { bool _r = _t->postNewConvo();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 27: _t->deleteConvo((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 28: _t->setNewMessageContent((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 29: { bool _r = _t->postNewMessage();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 30: _t->play(); break;
        case 31: _t->record(); break;
        case 32: _t->downloadAudio((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 33: _t->stopRecording(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData HttpManager::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject HttpManager::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_HttpManager,
      qt_meta_data_HttpManager, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &HttpManager::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *HttpManager::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *HttpManager::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_HttpManager))
        return static_cast<void*>(const_cast< HttpManager*>(this));
    return QObject::qt_metacast(_clname);
}

int HttpManager::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 34)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 34;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = progress(); break;
        case 1: *reinterpret_cast< bool*>(_v) = isLoading(); break;
        case 2: *reinterpret_cast< QUrl*>(_v) = path(); break;
        case 3: *reinterpret_cast< QString*>(_v) = username(); break;
        case 4: *reinterpret_cast< int*>(_v) = newConvoId(); break;
        }
        _id -= 5;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setProgress(*reinterpret_cast< int*>(_v)); break;
        case 1: setLoading(*reinterpret_cast< bool*>(_v)); break;
        case 2: setPath(*reinterpret_cast< QUrl*>(_v)); break;
        case 3: setUsername(*reinterpret_cast< QString*>(_v)); break;
        case 4: setNewConvoId(*reinterpret_cast< int*>(_v)); break;
        }
        _id -= 5;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 5;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void HttpManager::loginSuccess()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void HttpManager::loginFail()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void HttpManager::loadingChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void HttpManager::progressChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}

// SIGNAL 4
void HttpManager::pathChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, 0);
}

// SIGNAL 5
void HttpManager::usernameChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, 0);
}

// SIGNAL 6
void HttpManager::newConvoIdChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 6, 0);
}

// SIGNAL 7
void HttpManager::error()
{
    QMetaObject::activate(this, &staticMetaObject, 7, 0);
}

// SIGNAL 8
void HttpManager::replyFinished()
{
    QMetaObject::activate(this, &staticMetaObject, 8, 0);
}

// SIGNAL 9
void HttpManager::convoCreatedSignal()
{
    QMetaObject::activate(this, &staticMetaObject, 9, 0);
}

// SIGNAL 10
void HttpManager::reloadHome()
{
    QMetaObject::activate(this, &staticMetaObject, 10, 0);
}

// SIGNAL 11
void HttpManager::reloadConvo()
{
    QMetaObject::activate(this, &staticMetaObject, 11, 0);
}

// SIGNAL 12
void HttpManager::playAudioDone()
{
    QMetaObject::activate(this, &staticMetaObject, 12, 0);
}
QT_END_MOC_NAMESPACE
