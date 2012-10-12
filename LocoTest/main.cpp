#include <QtCore/QCoreApplication>
#include "networkconnection.h"

#include <iostream>



int main(int argc, char *argv[])
{
    QString test = "asdfasdf";

    using namespace std;

    cout << test.toStdString() << endl;
    cout << "Starting to read from network." << endl;
    QCoreApplication a(argc, argv);
    NetworkConnection nc;
    cout << "Made call to getXml." << endl;
    nc.getXmlWriteToFile("http://vocoloco.herokuapp.com/messages");
    nc.postForm("http://localhost:9000/login");
    cout << "Made it past postForm" << endl;
    nc.getXmlWriteToFile("http://localhost:9000/messages");

    return a.exec();
}
