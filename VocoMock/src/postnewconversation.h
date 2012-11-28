#ifndef POSTNEWCONVERSATION_H
#define POSTNEWCONVERSATION_H

#include <QString>
#include <QList>
/**
 * @brief This class is used to model the data of a conversation before it is posted to the server
 */

class PostNewConversation
{
public:
    PostNewConversation();
    void setTitle(QString title);
    void addUser(QString user);
    void removeUser(QString user);
    void clearUsers();
    bool noUsers();
    bool noTitle();
    QString getXML();

private:
    QString *convoTitle;
    QList<QString> *users;
};

#endif // POSTNEWCONVERSATION_H
