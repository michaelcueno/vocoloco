
#include "networkconnection.h"
#include <iostream>
#include <QtTest/QTest>

using namespace std;

NetworkConnection::NetworkConnection(QObject *parent) :
    QObject(parent)
{

}

void NetworkConnection::getXmlWriteToFile(QString getUrl)
{
    cout << "Entered getXml...." << endl;
    url = QUrl(getUrl);
    file = new QFile("./response.xml");
    file->open(QIODevice::WriteOnly);
    cout << "Created file object..." << endl;
    reply = qnam.get(QNetworkRequest(url));
    connect(reply, SIGNAL(readyRead()),
            this, SLOT(httpReadyRead()));
    connect(reply, SIGNAL(finished()),
            this, SLOT(httpFinished()));
}

void NetworkConnection::postForm(QString postUrl)
{
    cout << "Entered postUrl" << endl;
    QUrl postData;
    postData.addQueryItem("username", "pburd2");
    postData.addQueryItem("password", "burdpass");
    QNetworkRequest request(postUrl);
    request.setHeader(QNetworkRequest::ContentTypeHeader,
        "application/x-www-form-urlencoded");
    qnam.post(request, postData.encodedQuery());
    connect(reply, SIGNAL(readyRead()),
            this, SLOT(httpReadyRead()));
    connect(reply, SIGNAL(finished()),
            this, SLOT(httpFinished()));

    cout << "Now trying to get messages assumed we are logged in from loco" << endl;

    //getXmlWriteToFile("http://vocoloco.herokuapp.com/messages");
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
