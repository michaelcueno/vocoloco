#ifndef NEWMESSAGE_H
#define NEWMESSAGE_H
#include <QString>

/**
 * @brief This class is used to model the data of a message before it is posted to the server
 */
class NewMessage
{
public:
    NewMessage();
    void setContent(QString body);
    void setOwner(QString name);
    void setId(QString convoId);
    bool noContent();
    QString getId() { return id; }
    QString getXml();

private:
    QString content;
    QString owner;
    QString id;

};

#endif // NEWMESSAGE_H
