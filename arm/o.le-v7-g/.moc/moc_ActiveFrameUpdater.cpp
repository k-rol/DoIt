/****************************************************************************
** Meta object code from reading C++ file 'ActiveFrameUpdater.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../src/ActiveFrameUpdater.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'ActiveFrameUpdater.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_ActiveFrameUpdater[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      28,   20,   19,   19, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_ActiveFrameUpdater[] = {
    "ActiveFrameUpdater\0\0appText\0update(QString)\0"
};

void ActiveFrameUpdater::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        ActiveFrameUpdater *_t = static_cast<ActiveFrameUpdater *>(_o);
        switch (_id) {
        case 0: _t->update((*reinterpret_cast< QString(*)>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData ActiveFrameUpdater::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject ActiveFrameUpdater::staticMetaObject = {
    { &SceneCover::staticMetaObject, qt_meta_stringdata_ActiveFrameUpdater,
      qt_meta_data_ActiveFrameUpdater, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &ActiveFrameUpdater::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *ActiveFrameUpdater::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *ActiveFrameUpdater::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ActiveFrameUpdater))
        return static_cast<void*>(const_cast< ActiveFrameUpdater*>(this));
    return SceneCover::qt_metacast(_clname);
}

int ActiveFrameUpdater::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = SceneCover::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 1)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
