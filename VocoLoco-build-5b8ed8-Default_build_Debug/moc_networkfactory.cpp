/****************************************************************************
** Meta object code from reading C++ file 'networkfactory.h'
**
** Created: Wed Dec 5 19:48:15 2012
**      by: The Qt Meta Object Compiler version 63 (Qt 4.8.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../VocoLoco/src/networkfactory.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'networkfactory.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_NetworkFactory[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      18,   16,   15,   15, 0x0a,
      69,   16,   15,   15, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_NetworkFactory[] = {
    "NetworkFactory\0\0,\0"
    "onIgnoreSSLErrors(QNetworkReply*,QList<QSslError>)\0"
    "onAuthNeeded(QNetworkReply*,QAuthenticator*)\0"
};

void NetworkFactory::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        NetworkFactory *_t = static_cast<NetworkFactory *>(_o);
        switch (_id) {
        case 0: _t->onIgnoreSSLErrors((*reinterpret_cast< QNetworkReply*(*)>(_a[1])),(*reinterpret_cast< QList<QSslError>(*)>(_a[2]))); break;
        case 1: _t->onAuthNeeded((*reinterpret_cast< QNetworkReply*(*)>(_a[1])),(*reinterpret_cast< QAuthenticator*(*)>(_a[2]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData NetworkFactory::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject NetworkFactory::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_NetworkFactory,
      qt_meta_data_NetworkFactory, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &NetworkFactory::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *NetworkFactory::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *NetworkFactory::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_NetworkFactory))
        return static_cast<void*>(const_cast< NetworkFactory*>(this));
    if (!strcmp(_clname, "QDeclarativeNetworkAccessManagerFactory"))
        return static_cast< QDeclarativeNetworkAccessManagerFactory*>(const_cast< NetworkFactory*>(this));
    return QObject::qt_metacast(_clname);
}

int NetworkFactory::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 2)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
