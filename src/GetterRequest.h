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
    void GetPassword();

    void whatEveRequest(const QString &rest);


Q_SIGNALS:
    void responseReceived(const QString &info);
    void statsReceived(const QString &info, const int &info2, const QString &info3);
    void passwordReceived(const QString &pass);
    void commandSent(const QUrl &commandSent);
    //void outOfTime(QNetworkReply* &m_reply);


private Q_SLOTS:
    void onGetReply();
    void onGetStats();
    void onGetPassword();

private:
    QNetworkAccessManager* m_networkAccessManager;
    float mathBattery(QByteArray &hexCode);
    QString mathMode(QByteArray &hexCode);
    //QNetworkReply* m_reply;
    //void timerTimeout(QNetworkReply* &m_reply);
};

#endif
