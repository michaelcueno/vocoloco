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

bool NewMessage::noContent()
{
    return content.isEmpty();
}

QString NewMessage::getXml()
{
    return "<conversation><message>" + content + "</message></conversation>";
}

