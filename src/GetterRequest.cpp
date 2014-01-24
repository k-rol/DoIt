/*
 * GetterRequest.cpp
 *
 *  Created on: 2014-01-20
 *      Author: Carol
 */

#include "GetterRequest.h"



#include <bb/data/JsonDataAccess>

#include <QDebug>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <iostream>

#include <QUrl>



GetterRequest::GetterRequest(QObject* parent)
    : QObject(parent)
    , m_networkAccessManager(new QNetworkAccessManager(this))
{
}

void GetterRequest::GetRequest()
{
	//QUrl command("%1")


	QUrl command (QString("%1%2").arg("http://10.5.5.9/").arg("bacpac/PW"));
	//QUrl command("http://10.5.5.9/bacpac/PW");
	//QString("%1%2%3%4").arg("=t").arg("Evilation01").arg("&p=").arg("%01")

	std::string rawString("t=Evilation01&p=%01");
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

GetterRequest::~GetterRequest() {
	// TODO Auto-generated destructor stub
}
