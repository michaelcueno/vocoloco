/****************************************************************************
 * Copyright (C) 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ****************************************************************************/
/**
  * XML Model data for use in the ConvoUsersDelegate
  * The XmlRoles are available in the ConvoUsersDelegate refrenced by their name and will resolve to
  * the query they point to.
  */

import QtQuick 1.1

XmlListModel {

    property string conversationId  // for selecting the correct conversation
    id: xml_convoUsers

    // This query's the xml at gets the members from the converstaion where the conversation id equals the conversationID
    query: "/conversations/conversation[@id=\"" + conversationId + "\"]/members/member"

    XmlRole { name: "name"; query: "name/string()" }
    XmlRole { name: "image"; query: "url/string()" }
    XmlRole { name: "is_new"; query: "is_new/string()" }

    function loadXML(){
        xml_convoUsers.source = mainUrl + "conversations"
        xml_convoUsers.reload()
    }
}
