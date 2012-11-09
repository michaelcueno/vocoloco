#ifndef POSTNEWCONVERSATION_H
#define POSTNEWCONVERSATION_H

#include <QString>
#include <QList>
/* This class will model the data used to send a post to the server. It will handle the creation of the XML
 *  that the server can understand
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
