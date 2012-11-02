
#include "networkconnection.h"
#include <iostream>
#include <QtTest/QTest>

using namespace std;

NetworkConnection::NetworkConnection(QObject *parent) :
    QObject(parent)
{

}



void NetworkConnection::postForm(QString credentials)
{
    QUrl postData;
    QString usrn;
    QString pass;


    QStringList list = credentials.split(" ");

    if(list.size() != 2){    // Error Checking
        emit loginFail();
    }else{
        usrn = list[0];
        pass = list[1];
    }

    request = QNetworkRequest(QUrl("https://vocoloco.herokuapp.com/login"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");

    postData.addQueryItem("username", usrn);
    postData.addQueryItem("password", pass);

    // Attempt Login
    reply = manager->post(request, postData.encodedQuery());

    // When finished, jump to authenticate
    connect(reply, SIGNAL(finished()), this, SLOT(authenticate()));
}

void NetworkConnection::authenticate(){

    QList<QByteArray> headers = reply->rawHeaderList();

    if(headers.size() < 2){
        emit loginFail();
    } else {
        if(headers[1] == "Set-Cookie")
            emit loginSuccess();
        else
            emit loginFail();
    }
}


void NetworkConnection::httpReadyRead()
{
    //write date to file
    if (file)
    {

        file->write(reply->readAll());
    }
}

void NetworkConnection::httpFinished(){
    file->flush();
    file->close();
    reply->deleteLater();
    reply = 0;
    delete file;
    file = 0;
}
