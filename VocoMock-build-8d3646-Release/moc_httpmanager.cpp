/****************************************************************************
** Meta object code from reading C++ file 'httpmanager.h'
**
** Created: Tue Oct 23 16:46:35 2012
**      by: The Qt Meta Object Compiler version 63 (Qt 4.8.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../VocoMock/httpmanager.h"
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
       9,   14, // methods
       1,   59, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // signals: signature, parameters, type, tag, flags
      13,   12,   12,   12, 0x05,
      28,   12,   12,   12, 0x05,
      40,   12,   12,   12, 0x05,
      58,   12,   12,   12, 0x05,

 // slots: signature, parameters, type, tag, flags
      73,   65,   12,   12, 0x0a,
     105,   93,   12,   12, 0x0a,
     142,  130,   12,   12, 0x0a,
     177,   12,   12,   12, 0x0a,
     192,   12,   12,   12, 0x0a,

 // properties: name, type, flags
     209,  205, 0x02495103,

 // properties: notify_signal_id
       2,

       0        // eod
};

static const char qt_meta_stringdata_HttpManager[] = {
    "HttpManager\0\0loginSuccess()\0loginFail()\0"
    "progressChanged()\0test()\0request\0"
    "requestXML(QString)\0credentials\0"
    "postCredentials(QString)\0soFar,total\0"
    "setDownloadProgress(qint64,qint64)\0"
    "authenticate()\0parseReply()\0int\0"
    "progress\0"
};

void HttpManager::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        HttpManager *_t = static_cast<HttpManager *>(_o);
        switch (_id) {
        case 0: _t->loginSuccess(); break;
        case 1: _t->loginFail(); break;
        case 2: _t->progressChanged(); break;
        case 3: _t->test(); break;
        case 4: _t->requestXML((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 5: _t->postCredentials((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 6: _t->setDownloadProgress((*reinterpret_cast< qint64(*)>(_a[1])),(*reinterpret_cast< qint64(*)>(_a[2]))); break;
        case 7: _t->authenticate(); break;
        case 8: _t->parseReply(); break;
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
        if (_id < 9)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 9;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = progress(); break;
        }
        _id -= 1;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setProgress(*reinterpret_cast< int*>(_v)); break;
        }
        _id -= 1;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 1;
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
void HttpManager::progressChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void HttpManager::test()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}
QT_END_MOC_NAMESPACE
