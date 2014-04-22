/*
 * WifiInfo.h
 *
 *  Created on: 2014-04-21
 *      Author: CaroL
 */

#ifndef WIFIINFO_H_
#define WIFIINFO_H_
#include <QObject>
/*
 *
 */
class WifiInfo : public QObject
{
	Q_OBJECT
public:
	WifiInfo(QObject* parent = 0);
	virtual ~WifiInfo();

public Q_SLOTS:

Q_SIGNALS:

};

#endif /* WIFIINFO_H_ */
