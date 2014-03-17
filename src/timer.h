/*
 * timer.h
 *
 *  Created on: 2014-03-17
 *      Author: cauellet
 */

#ifndef TIMER_H_
#define TIMER_H_

#include <QObject>
#include <bb/cascades/CustomControl>

class QTimer;

class Timer : public bb::cascades::CustomControl
{
	Q_OBJECT
	Q_PROPERTY(bool active READ isActive NOTIFY activeChanged)
	Q_PROPERTY(int interval READ interval WRITE setInterval
	           NOTIFY intervalChanged)


public:
	explicit Timer(QObject* parent = 0);

	bool isActive();
	void setInterval(int m_sec);
	int interval();

public slots:
	void start();
	void stop();

signals:
	void timerOut();
	void intervalChanged();
	void activeChanged();

private:
	QTimer* _timer;

};



#endif /* TIMER_H_ */
