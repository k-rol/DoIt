/*
 * GetterRequest.cpp
 *
 *  Created on: 2014-01-20
 *      Author: Carol
 */

#include "GetterRequest.h"
#include "RetryCounter.h"


#include <bb/data/JsonDataAccess>

#include <QDebug>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <iostream>
#include <string>
#include <sstream>
#include <QUrl>
#include <math.h>
#include <QSettings>
#include <QTimer>


using namespace std;

GetterRequest::GetterRequest(QObject* parent)
    : QObject(parent)
    , m_networkAccessManager(new QNetworkAccessManager(this))
{

}

///////////////////////
//To get specific info
///////////////////////
void GetterRequest::GetRequest(const QString &password, const QString &cmd, const QString &cmdbyte)
{
	//QUrl command("%1")

	QUrl command (QString("%1%2%3").arg("http://10.5.5.9/").arg("bacpac/").arg(cmd));
	//QUrl command("http://10.5.5.9/bacpac/PW");
	//QString("%1%2%3%4").arg("=t").arg("Evilation01").arg("&p=").arg("%01")

	std::ostringstream oss;
	string passwordString = password.toUtf8().constData();
	string cmdbyteString = cmdbyte.toUtf8().constData();
	oss << "t=" << passwordString << "&p=%" << cmdbyteString;
	string rawString = oss.str();

	//string rawString("t=Evilation01&p=%01");
	QByteArray rawQuery(rawString.c_str(),rawString.length());


	//QByteArray rawQuery("t=Evilation01&p=%01");

	command.setEncodedQuery(rawQuery);

	QNetworkRequest request(command);
	QNetworkReply* response = m_networkAccessManager->get(request);
	QString urltostring; urltostring = command.toEncoded();

	emit commandSent(urltostring);



	bool ok = connect(response, SIGNAL(finished()),this,SLOT(onGetReply()));
	Q_ASSERT(ok);
	Q_UNUSED(ok);
}

///Get Response
void GetterRequest::onGetReply()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

    QString response;
    if (reply) {
        if (reply->error() == QNetworkReply::NoError) {
            const int available = reply->bytesAvailable();

            if (available > 0) {
                const QByteArray buffer(reply->readAll());

                // The data from reply is in a json format e.g
                //"args": {},
                //"headers": {
                //  "Accept": "*/*",
                //  "Connection": "close",
                //  "Content-Length": "",
                //  "Content-Type": "",
                //  "Host": "httpbin.org",
                //  "User-Agent": "curl/7.19.7 (universal-apple-darwin10.0) libcurl/7.19.7 OpenSSL/0.9.8l zlib/1.2.3"
                //},
                //"origin": "24.127.96.129",
                //"url": "http://httpbin.org/get"

                bb::data::JsonDataAccess ja;
                const QVariant jsonva = ja.loadFromBuffer(buffer);
                const QMap<QString, QVariant> jsonreply = jsonva.toMap();

                // Locate the header array
                QMap<QString, QVariant>::const_iterator it = jsonreply.find("headers");
                if (it != jsonreply.end()) {
                    // Print everything in header array
                    const QMap<QString, QVariant> headers = it.value().toMap();
                    for (QMap<QString, QVariant>::const_iterator hdrIter = headers.begin(); hdrIter != headers.end(); ++hdrIter) {
                        if (hdrIter.value().toString().trimmed().isEmpty())
                            continue; // Skip empty values

                        response += QString::fromLatin1("%1: %2\r\n").arg(hdrIter.key(), hdrIter.value().toString());
                    }
                }

                // Print everything else
                for (it = jsonreply.begin(); it != jsonreply.end(); it++) {
                    if (it.value().toString().trimmed().isEmpty())
                        continue;  // Skip empty values

                    response += QString::fromLatin1("%1: %2\r\n").arg(it.key(), it.value().toString());
                }
            }

        } else {
            response =  tr("Error: %1 status: %2").arg(reply->errorString(), reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toString());
            qDebug() << response;
        }

        reply->deleteLater();
    }

    if (response.trimmed().isEmpty()) {
        response = tr("Unable to retrieve request headers");
    }

    emit responseReceived(response);
}
//END/////////////////////
//To get specific info
//END/////////////////////


///////////////////////
//To get the stats "se"
///////////////////////
void GetterRequest::StatRequest(const QString &password, const QString &cmd)
{
	QUrl command (QString("%1%2%3").arg("http://10.5.5.9/").arg("camera/").arg(cmd));

	std::ostringstream oss;
	string passwordString = password.toUtf8().constData();

	oss << "t=" << passwordString;
	string rawString = oss.str();

	QByteArray rawQuery(rawString.c_str(),rawString.length());

	command.setEncodedQuery(rawQuery);

	QNetworkRequest request(command);
	QNetworkReply* response = m_networkAccessManager->get(request);
	QString urltostring; urltostring = command.toEncoded();

	emit commandSent(urltostring);

	bool ok = connect(response, SIGNAL(finished()),this,SLOT(onGetStats()));


	QTimer* timer = new QTimer(response);
	timer->setObjectName("StatRequest");
	timer->setSingleShot(true);
	bool ok2 = connect(timer, SIGNAL(timeout()),this,SLOT(stopReplyTimer()));
	timer->start(3000);


	Q_ASSERT(ok);
	Q_UNUSED(ok);
	Q_ASSERT(ok2);
	Q_UNUSED(ok2);

}

///Get Response
void GetterRequest::onGetStats()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

    QString response;
    float batteryLevel;
    QString camMode;


    if (reply) {
        if (reply->error() == QNetworkReply::NoError) {
        	const int available = reply->bytesAvailable();

            if (available > 0) {

            	QByteArray buffer(reply->readAll());

                QString something(buffer.toHex());
                response = something;

                batteryLevel = mathBattery(buffer);
                camMode = mathMode(buffer);

                qDebug() << response;
                qDebug() << batteryLevel;
                qDebug() << camMode;

            }

        } else {
            response =  tr("Error: %1 status: %2").arg(reply->errorString(), reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toString());
            qDebug() << response;
        }

        reply->deleteLater();
    }

    if (response.trimmed().isEmpty()) {
        response = tr("Unable to retrieve request headers");
    }

    emit statsReceived(response, batteryLevel, camMode);
}

//Elements of SE STATS://

///Get battery percentage level
float GetterRequest::mathBattery(QByteArray &hexCode) //
{
	bool ok;
	float batteryLevel;
	batteryLevel = hexCode.toHex().mid(38,2).toInt(&ok,16);
	batteryLevel = roundf(batteryLevel / 76 * 100);
	return batteryLevel;

}

//Get camera mode (photo-video-burst-time)
QString GetterRequest::mathMode(QByteArray &hexCode) //
{
	bool ok;
	QString camMode = "";
	int numMode = 9;
	numMode = hexCode.toHex().mid(3,1).toInt(&ok,10);


	switch (numMode) {
		case 0:
			camMode = "Video";
			break;
		case 1:
			camMode = "Picture";
			break;
		case 2:
			camMode = "Burst Picture";
			break;
		case 3:
			camMode = "Time Lapse";
			break;
		case 4:
			camMode = "Not found";
			break;
		case 5:
			camMode = "Not found";
			break;
		case 6:
			camMode = "Not Found";
			break;
		case 7:
			camMode = "Setup";
			break;
		default:
			camMode = "Unknown";
			break;
	}

	return camMode;

}

//END/////////////////////
//To get the stats "se"
//END/////////////////////

///////////////////////
//Get password at start
///////////////////////
void GetterRequest::GetPassword()
{
	const QString ipAddress = "http://10.5.5.9/";
	const QString cmd = "sd";

	QUrl command (QString("%1%2%3").arg(ipAddress).arg("bacpac/").arg(cmd));

	QNetworkRequest request(command);
	QNetworkReply* response = m_networkAccessManager->get(request);

	qDebug() << "GetPassword";
	qDebug() << command;

	bool ok = connect(response, SIGNAL(finished()),this,SLOT(onGetPassword()));

	QTimer* timer = new QTimer(response);
	timer->setObjectName("GetPassword");
	timer->setSingleShot(true);
	timer->start(3000);
	//RetryCounter counterClass;
	bool ok2 = connect(timer, SIGNAL(timeout()),this,SLOT(stopReplyTimer()));
	//bool ok2 = connect(timer, SIGNAL(timeout()),&counterClass,SLOT(stopReplyTimer()));

	Q_ASSERT(ok);
	Q_UNUSED(ok);
	Q_ASSERT(ok2);
	Q_UNUSED(ok2);

}

///On Get Password Response
void GetterRequest::onGetPassword()
{
	QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

	QByteArray hexToPassword = "";

	if (reply)	{
		if(reply->error() == QNetworkReply::NoError) {
			const int available = reply->bytesAvailable();


			if (available > 0) {
				QByteArray buffer(reply->readAll().toHex());

				//QString myCustomData = reply->property("mycustomdata").toString();

				hexToPassword = QByteArray::fromHex(buffer.right(buffer.length()-4));

				qDebug() << "onGetPassword";

				qDebug() << hexToPassword.data();

				QSettings settings;
				settings.setValue("password", hexToPassword);
				emit passwordReceived(hexToPassword.data());

			}
		}

		else {
			QString response = tr("Error: %1 Status: %2").arg(reply->errorString(), reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toString());
			qDebug() << response;
		}

		reply->deleteLater();
	}


}
//END/////////////////////
//Get password at start
//END/////////////////////

///////////////////////
//SLOT called by QNetworkAccessManager
//requests for timeouts
///////////////////////
void GetterRequest::stopReplyTimer()
{
	QTimer* timer = qobject_cast<QTimer*>(sender());
	QNetworkReply* response = qobject_cast<QNetworkReply*>(timer->parent());

	qDebug() << "request aborting...";
	qDebug() << timer->objectName();

	response->abort();
	qDebug() << "Aborted";

	if (timer->objectName() == "GetPassword")
	{
		emit signalGetPassword();

	}

	else if (timer->objectName() == "StatRequest") {
		//emit timerTimesOut("neverconected");
		//powerbutton at off
	}

}


//END/////////////////////
//SLOT called by QNetworkAccessManager
//requests for timeouts
//END/////////////////////


//Destructor
GetterRequest::~GetterRequest() {
	//delete m_networkAccessManager;
	qDebug() << "*******GETTERREQUEST DESTROYED?********";

}
