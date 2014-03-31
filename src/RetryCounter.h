/*
 * RetryCounter.h
 *
 *  Created on: 2014-03-28
 *      Author: CaroL
 */

#ifndef RETRYCOUNTER_H_
#define RETRYCOUNTER_H_

#include <QObject>
/*
 *
 */
class RetryCounter : public QObject
{
	Q_OBJECT
public:
	RetryCounter(QObject* parent = 0);
	virtual ~RetryCounter();


public Q_SLOTS:
	void stopReplyTimer();

Q_SIGNALS:

};

#endif /* RETRYCOUNTER_H_ */
