/*
 * GetRequest.h
 *
 *  Created on: 2014-01-20
 *      Author: Carol
 */

#ifndef GETTERREQUEST_H_
#define GETTERREQUEST_H_

#include <QObject>

class QNetworkAccessManager;

class GetterRequest : public QObject
{
    Q_OBJECT
public:
    GetterRequest(QObject* parent = 0);
    virtual ~GetterRequest();

public Q_SLOTS:
    void GetRequest(const QString &password, const QString &cmd, const QString &cmdbyte);
    void StatRequest(const QString &password, const QString &cmd);

Q_SIGNALS:
    void responseReceived(const QString &info);

    void commandSent(const QUrl &commandSent);

private Q_SLOTS:
    void onGetReply();

private:
    QNetworkAccessManager* m_networkAccessManager;
};

#endif
