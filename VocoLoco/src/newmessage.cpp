#include "newmessage.h"

NewMessage::NewMessage()
{
}

void NewMessage::setContent(QString body){
    this->content = body;
}

void NewMessage::setOwner(QString name){
    this->owner = name;
}

void NewMessage::setId(QString id){
    this->id = id;
}

//! @brief Returns true if there is no content in the message
bool NewMessage::noContent()
{
    return content.isEmpty();
}

//! @brief Returns a string of XML used to be posted to the server to implement posting a new message
QString NewMessage::getXml()
{
    return "<conversation><message>" + content + "</message></conversation>";
}

