#ifndef NEWMESSAGE_H
#define NEWMESSAGE_H
#include <QString>

class NewMessage
{
public:
    NewMessage();
    void setContent(QString body);
    void setOwner(QString name);

private:
    QString content;
    QString owner;

};

#endif // NEWMESSAGE_H
