/*
 * RetryCounter.cpp
 *
 *  Created on: 2014-03-28
 *      Author: CaroL
 */

#include "RetryCounter.h"
#include <QTimer>
#include <QNetworkReply>
#include <QDebug>
#include <QSettings>
#include <applicationui.hpp>

RetryCounter::RetryCounter(QObject* parent)
	: QObject(parent)
{


}

void RetryCounter::stopReplyTimer()
{
	QTimer* timer = qobject_cast<QTimer*>(sender());
	QNetworkReply* response = qobject_cast<QNetworkReply*>(timer->parent());

	QSettings settings;
	settings.setValue("counter",0);
	bool* ok;
	int passwordCounter = settings.value("counter").toInt(ok);
	qDebug() << passwordCounter;


	qDebug() << "request aborting...";
	qDebug() << timer->objectName();

	response->abort();
	qDebug() << "Aborted";

	if (timer->objectName() == "GetPassword")
	{
		if (passwordCounter == 3)
		{
			//stop timer and bring retry dialog
			//emit passwordfailedDialog();
			qDebug() << "**********SHOW RETRY DIALOG**********";
			//emit timerTimesOut("GetPassword");
		}

		else {
			passwordCounter++;
			//retry get password timer
			//emit signalGetPassword(passwordCounter);
			qDebug() << "****** emit signalGetPassword(passwordCounter)********";
		}
	}

	else if (timer->objectName() == "StatRequest") {
		//emit timerTimesOut("neverconected");
		//powerbutton at off
		qDebug() << "ITS STATREQUEST";

	}

	qDebug() << passwordCounter;



}



RetryCounter::~RetryCounter() {
	qDebug() << "!!!!!!!!RETRYCOUNTER DESTROYED!!!!!!!!!!";
}

