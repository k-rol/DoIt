/*
 * GetRequest.h
 *
 *  Created on: 2014-01-20
 *      Author: Carol
 */

#ifndef GETTERREQUEST_H_
#define GETTERREQUEST_H_

#include <QtCore/QObject>

class QNetworkAccessManager;

class GetterRequest : public QObject
{
    Q_OBJECT
public:
    GetterRequest(QObject* parent = 0);
    virtual ~GetterRequest();

public Q_SLOTS:
    void GetRequest();

Q_SIGNALS:
    void complete(const QString &info);

    void complete2(const QUrl &commandSent);

private Q_SLOTS:
    void onGetReply();

private:
    QNetworkAccessManager* m_networkAccessManager;
};

#endif
