/*
 * ActiveFrameUpdater.h
 *
 *  Created on: 2014-01-30
 *      Author: cauellet
 */

#ifndef ACTIVEFRAMEUPDATER_H_
#define ACTIVEFRAMEUPDATER_H_

#include <QObject>
#include <bb/cascades/Label>
#include <bb/cascades/SceneCover>

using namespace ::bb::cascades;

class ActiveFrameUpdater: public SceneCover {
	Q_OBJECT

public:
	ActiveFrameUpdater(QObject *parent=0);
	virtual ~ActiveFrameUpdater();

public slots:
	Q_INVOKABLE void update(QString appText);

private:
	bb::cascades::Label *m_coverLabel;
};

#endif /* ACTIVEFRAMEUPDATER_H_ */
