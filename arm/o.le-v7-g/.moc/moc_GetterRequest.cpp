/****************************************************************************
** Meta object code from reading C++ file 'GetterRequest.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../src/GetterRequest.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'GetterRequest.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_GetterRequest[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: signature, parameters, type, tag, flags
      20,   15,   14,   14, 0x05,
      58,   46,   14,   14, 0x05,

 // slots: signature, parameters, type, tag, flags
      76,   14,   14,   14, 0x0a,
      89,   14,   14,   14, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_GetterRequest[] = {
    "GetterRequest\0\0info\0responseReceived(QString)\0"
    "commandSent\0commandSent(QUrl)\0"
    "GetRequest()\0onGetReply()\0"
};

void GetterRequest::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        GetterRequest *_t = static_cast<GetterRequest *>(_o);
        switch (_id) {
        case 0: _t->responseReceived((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 1: _t->commandSent((*reinterpret_cast< const QUrl(*)>(_a[1]))); break;
        case 2: _t->GetRequest(); break;
        case 3: _t->onGetReply(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData GetterRequest::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject GetterRequest::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_GetterRequest,
      qt_meta_data_GetterRequest, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &GetterRequest::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *GetterRequest::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *GetterRequest::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_GetterRequest))
        return static_cast<void*>(const_cast< GetterRequest*>(this));
    return QObject::qt_metacast(_clname);
}

int GetterRequest::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    }
    return _id;
}

// SIGNAL 0
void GetterRequest::responseReceived(const QString & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void GetterRequest::commandSent(const QUrl & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
QT_END_MOC_NAMESPACE
