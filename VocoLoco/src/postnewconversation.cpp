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

//! @brief Returns true if there is no title to this conversation
bool PostNewConversation::noTitle()
{
    return (convoTitle->isEmpty());
}

//! @brief Returns true if there are no users added to the conversation
bool PostNewConversation::noUsers()
{
    return (users->isEmpty());
}

/**
 * @brief Wraps the information about the new conversation to be posted in the xml format that the server accepts
 * @return QString xml
 */
QString PostNewConversation::getXML()
{
    QString result = QString("<conversation><title>" + *convoTitle + "</title><contacts>");

    for(int i = 0; i < users->size(); i++){
        result += "<username>" + users->at(i) + "</username>";
    }

    result += "</contacts></conversation>";

    return result;
}


