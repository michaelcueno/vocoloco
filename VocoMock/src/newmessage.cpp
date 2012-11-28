#include "newmessage.h"

NewMessage::NewMessage()
{
}

void NewMessage::setContent(QString body){
    content = body;
}

void NewMessage::setOwner(QString name){
    owner = name;

}
