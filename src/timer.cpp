/*
 * timer.cpp
 *
 *  Created on: 2014-03-17
 *      Author: cauellet
 */




#include <QTimer>
#include "timer.h"

Timer::Timer(QObject* parent): bb::cascades::CustomControl(),_timer(new QTimer(this))
{
	Q_UNUSED(parent);

	bool connectResult;

	Q_UNUSED(connectResult);

	connectResult = connect(_timer,SIGNAL(timeout()),this,SIGNAL(timeout()));

	Q_ASSERT(connectResult);

	setVisible(false);
}

bool Timer::isActive()
{
	return _timer->isActive();
}

int Timer::interval()
{
	return _timer->interval();
}

void Timer::setInterval(int m_sec)
{
	if (_timer->interval() == m_sec)
		return;

	_timer->setInterval(m_sec);
	emit intervalChanged();
}

void Timer::start()
{
	if (_timer->isActive())
		return ;

	_timer->start();
	emit activeChanged();
}

void Timer::stop()
{
	if (!_timer->isActive())
		return ;

	_timer->stop();
	emit activeChanged();
}
