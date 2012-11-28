#include "postnewconversation.h"
#include <QDebug>

PostNewConversation::PostNewConversation()
{
    convoTitle = new QString();
    users =  new QList<QString>();
}

void PostNewConversation::setTitle(QString title)
{
    QString *tmp = new QString(title);
    convoTitle = tmp;
}

void PostNewConversation::addUser(QString user)
{
    users->append(user);
}

void PostNewConversation::removeUser(QString user)
{
    users->removeAll(user);
}

void PostNewConversation::clearUsers()
{
    users = new QList<QString>();
}

bool PostNewConversation::noTitle()
{
    return (convoTitle->isEmpty());
}

bool PostNewConversation::noUsers()
{
    return (users->isEmpty());
}

QString PostNewConversation::getXML()
{
    QString result = QString("<conversation><title>" + *convoTitle + "</title><contacts>");

    for(int i = 0; i < users->size(); i++){
        result += "<username>" + users->at(i) + "</username>";
    }

    result += "</contacts></conversation>";

    return result;
}


