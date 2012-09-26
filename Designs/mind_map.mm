<map version="freeplane 1.2.0">
<!--To view this file, download free mind mapping software Freeplane from http://freeplane.sourceforge.net -->
<node TEXT="VocoLoco" ID="ID_1096276082" CREATED="1348117126990" MODIFIED="1348117162134"><hook NAME="MapStyle">

<map_styles>
<stylenode LOCALIZED_TEXT="styles.root_node">
<stylenode LOCALIZED_TEXT="styles.predefined" POSITION="right">
<stylenode LOCALIZED_TEXT="default" MAX_WIDTH="600" COLOR="#000000" STYLE="as_parent">
<font NAME="SansSerif" SIZE="10" BOLD="false" ITALIC="false"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.details"/>
<stylenode LOCALIZED_TEXT="defaultstyle.note"/>
<stylenode LOCALIZED_TEXT="defaultstyle.floating">
<edge STYLE="hide_edge"/>
<cloud COLOR="#f0f0f0" SHAPE="ROUND_RECT"/>
</stylenode>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.user-defined" POSITION="right">
<stylenode LOCALIZED_TEXT="styles.topic" COLOR="#18898b" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subtopic" COLOR="#cc3300" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subsubtopic" COLOR="#669900">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.important">
<icon BUILTIN="yes"/>
</stylenode>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.AutomaticLayout" POSITION="right">
<stylenode LOCALIZED_TEXT="AutomaticLayout.level.root" COLOR="#000000">
<font SIZE="18"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,1" COLOR="#0033ff">
<font SIZE="16"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,2" COLOR="#00b439">
<font SIZE="14"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,3" COLOR="#990000">
<font SIZE="12"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,4" COLOR="#111111">
<font SIZE="10"/>
</stylenode>
</stylenode>
</stylenode>
</map_styles>
</hook>
<node TEXT="Server" POSITION="right" ID="ID_725447019" CREATED="1348117172396" MODIFIED="1348117181569">
<node TEXT="Authentication" ID="ID_1627655913" CREATED="1348117238996" MODIFIED="1348117243785"/>
<node TEXT="Basic Layout" ID="ID_1862198598" CREATED="1348617364943" MODIFIED="1348617367668">
<node TEXT="Each model resides on the server. The client will have all the functionality of the User model more or less." ID="ID_1156757099" CREATED="1348617287997" MODIFIED="1348617364243"/>
</node>
<node TEXT="User Registration" ID="ID_1219986054" CREATED="1348117467515" MODIFIED="1348117483859"/>
<node TEXT="Friends" ID="ID_258752345" CREATED="1348117235086" MODIFIED="1348117238585"/>
<node TEXT="Sending Audio files to other users" ID="ID_1328354082" CREATED="1348117396322" MODIFIED="1348117449411"/>
</node>
<node TEXT="Downloading files from server" POSITION="right" ID="ID_1005481764" CREATED="1348117244155" MODIFIED="1348117250713">
<node TEXT="Lets start by just storing everything on the server and when a user wants to play a file that is the only time a download will happen." ID="ID_557501673" CREATED="1348616415110" MODIFIED="1348616446221"/>
<node TEXT="Lets make it a lower priority to *sync* all data on the client locally" ID="ID_1538648650" CREATED="1348616446684" MODIFIED="1348616479655"/>
</node>
<node TEXT="Client" POSITION="right" ID="ID_150529512" CREATED="1348117185758" MODIFIED="1348117187432">
<node TEXT="Audio Playback" ID="ID_320620008" CREATED="1348117251014" MODIFIED="1348117263655"/>
<node TEXT="User Interface" ID="ID_935876584" CREATED="1348117297393" MODIFIED="1348117321358"/>
<node TEXT="Recording Audio" ID="ID_1963826135" CREATED="1348117224947" MODIFIED="1348117234348"/>
<node TEXT="Update / Sync with server" ID="ID_1375715526" CREATED="1348616952056" MODIFIED="1348616971417"/>
</node>
<node TEXT="Unknowns" POSITION="right" ID="ID_1715361389" CREATED="1348117323849" MODIFIED="1348117381497">
<node TEXT="Using QT" ID="ID_785941624" CREATED="1348117383646" MODIFIED="1348117391591"/>
<node TEXT="Porting to Android" ID="ID_192269446" CREATED="1348117392388" MODIFIED="1348117396041"/>
<node TEXT="Available Android API&apos;s within QT" ID="ID_1855213640" CREATED="1348117500965" MODIFIED="1348117515398"/>
</node>
<node TEXT="Models" POSITION="left" ID="ID_385914026" CREATED="1348615407793" MODIFIED="1348615413996">
<node TEXT="Message" ID="ID_249802899" CREATED="1348615417908" MODIFIED="1348615428986">
<node TEXT="has" ID="ID_1142296542" CREATED="1348615477007" MODIFIED="1348615623769" VSHIFT="-20">
<node TEXT="Meta Data" ID="ID_1497638119" CREATED="1348615543510" MODIFIED="1348615554543"/>
<node TEXT="Title" ID="ID_1865910814" CREATED="1348615555262" MODIFIED="1348615556677"/>
<node TEXT="Recipient User(s) ID" ID="ID_1728977483" CREATED="1348615578799" MODIFIED="1348615854327"/>
<node TEXT="Owner User ID" ID="ID_827986864" CREATED="1348615564382" MODIFIED="1348615577539"/>
<node TEXT="Recieved (boolean)" ID="ID_1365027289" CREATED="1348617555093" MODIFIED="1348617568383"/>
</node>
<node TEXT="can do" ID="ID_771556926" CREATED="1348615533886" MODIFIED="1348615538713">
<node TEXT="recieved?()" ID="ID_1468347875" CREATED="1348617572077" MODIFIED="1348617582656"/>
</node>
</node>
<node TEXT="User" ID="ID_143543354" CREATED="1348615433733" MODIFIED="1348615442035">
<node TEXT="has" ID="ID_1326796790" CREATED="1348615493065" MODIFIED="1348615493873">
<node TEXT="Email" ID="ID_874481206" CREATED="1348615647508" MODIFIED="1348615649694"/>
<node TEXT="Name" ID="ID_1741119409" CREATED="1348615646287" MODIFIED="1348615647215"/>
<node TEXT="Friends ID Array" ID="ID_1284886123" CREATED="1348615668536" MODIFIED="1348615686076"/>
<node TEXT="Password" ID="ID_719791461" CREATED="1348615688051" MODIFIED="1348615694256"/>
<node TEXT="ID" ID="ID_1560169004" CREATED="1348615640936" MODIFIED="1348615806625"/>
</node>
<node TEXT="Can do" ID="ID_1749005227" CREATED="1348615650036" MODIFIED="1348616198770">
<node TEXT="Get_Conversations()" ID="ID_1064408225" CREATED="1348616198781" MODIFIED="1348616330633"/>
<node TEXT="Make_New_Conversation(User[] recpipients)" ID="ID_1395623348" CREATED="1348616208060" MODIFIED="1348616327695"/>
<node TEXT="Add_To_Conversation(Conversation* conv)" ID="ID_309817385" CREATED="1348616308184" MODIFIED="1348616410667">
<node TEXT="This will be called when a User hits the + button on a open conversation. It will create a new message x and call conv.add_new_message(x)" ID="ID_855858423" CREATED="1348616678781" MODIFIED="1348616842534"/>
</node>
</node>
</node>
<node TEXT="Conversation" ID="ID_1927588987" CREATED="1348615442425" MODIFIED="1348615444906">
<node TEXT="has" ID="ID_1953711873" CREATED="1348615495644" MODIFIED="1348615496224">
<node TEXT="User ID Array" ID="ID_1455699717" CREATED="1348616177294" MODIFIED="1348616185736"/>
<node TEXT="All messages between everyone in the ID Array" ID="ID_601206754" CREATED="1348616584233" MODIFIED="1348616619202"/>
</node>
<node TEXT="Methods" ID="ID_1528708438" CREATED="1348616637478" MODIFIED="1348616646487">
<node TEXT="Add_new_message(Message m)" ID="ID_1457483383" CREATED="1348616646497" MODIFIED="1348616734043"/>
<node TEXT="Constructor(User[] IDS)" ID="ID_1274610743" CREATED="1348616856331" MODIFIED="1348616872186"/>
</node>
<node TEXT="Idea" ID="ID_746141663" CREATED="1348616155374" MODIFIED="1348616159548">
<node TEXT="User IDs of everyone in the conversation. A conversation is created everytime a new message is created. If a user creates a new message and sends it to a friend, whats really happening is a conversation is being made. The conversation is constructed and the creator and reciepient are added to the User ID&apos;s array of that conversation" ID="ID_1529922152" CREATED="1348615869458" MODIFIED="1348616138299"/>
</node>
</node>
<node TEXT="Observer" ID="ID_1143331774" CREATED="1348617095506" MODIFIED="1348617100985">
<node TEXT="idea" ID="ID_844871417" CREATED="1348617102726" MODIFIED="1348617181170" HGAP="30">
<node TEXT="Takes care of pushing to the server. This will have a bunch of slots that can be activated by things like a user creating a new message .. I think thats actually the only time we need to push to the server actually." ID="ID_50344986" CREATED="1348617110763" MODIFIED="1348617178667"/>
</node>
<node TEXT="Methods" ID="ID_13270311" CREATED="1348617238046" MODIFIED="1348617240020">
<node TEXT="Slot_Message_created(Message m)" ID="ID_1189433571" CREATED="1348617182515" MODIFIED="1348617225784"/>
</node>
</node>
</node>
<node TEXT="Actions" POSITION="left" ID="ID_1526333206" CREATED="1348617400181" MODIFIED="1348617403073">
<node TEXT="Initial Login" ID="ID_133422778" CREATED="1348617408747" MODIFIED="1348617416709">
<node TEXT="Client Queries server with Username and Password" ID="ID_640311884" CREATED="1348617418089" MODIFIED="1348617433803"/>
<node TEXT="Server sends back XML of that User&apos;s attributes and saves the XML to a local config file for next app startup." ID="ID_439685569" CREATED="1348617434348" MODIFIED="1348617478259"/>
<node TEXT="Client waits for User interaction" ID="ID_754805877" CREATED="1348617478729" MODIFIED="1348617494282"/>
<node TEXT="Client Requests all Conversations" ID="ID_57390225" CREATED="1348617523522" MODIFIED="1348617791781"/>
<node TEXT="Server Sends back all conversations user is in" ID="ID_234854225" CREATED="1348617603920" MODIFIED="1348617805142"/>
<node TEXT="Locally User checks for new messages" ID="ID_1224078050" CREATED="1348617805549" MODIFIED="1348617826722"/>
<node TEXT="New messages float to the top of &quot;All Messages&quot; panel" ID="ID_955564602" CREATED="1348617827631" MODIFIED="1348617853589"/>
<node TEXT="Client waits for user interaction" ID="ID_1735976616" CREATED="1348617854037" MODIFIED="1348617863428"/>
</node>
<node TEXT="Create New Message" ID="ID_1908515857" CREATED="1348617499551" MODIFIED="1348617880085">
<node TEXT="User clicks on +" ID="ID_1772182116" CREATED="1348617904749" MODIFIED="1348617914297"/>
<node TEXT="New message panel brought up and filled out" ID="ID_913693494" CREATED="1348617914633" MODIFIED="1348617933775">
<node TEXT="Recipients" ID="ID_930361601" CREATED="1348617935814" MODIFIED="1348617940289"/>
<node TEXT="title" ID="ID_222745769" CREATED="1348617947415" MODIFIED="1348617949354"/>
<node TEXT="..." ID="ID_681455535" CREATED="1348617973886" MODIFIED="1348617975190"/>
</node>
<node TEXT="User Records Message" ID="ID_1883060634" CREATED="1348618046323" MODIFIED="1348618050786"/>
<node TEXT="Constructor for message called" ID="ID_1540615523" CREATED="1348617982701" MODIFIED="1348618019231"/>
<node TEXT="Constructor for Conversation is called" ID="ID_643483304" CREATED="1348618019618" MODIFIED="1348618033971"/>
<node TEXT="Conversation successfully created sends signal to observer" ID="ID_143851164" CREATED="1348618034342" MODIFIED="1348618100809"/>
<node TEXT="Observer attempts to push conversation to server" ID="ID_213052346" CREATED="1348618101148" MODIFIED="1348618116757"/>
</node>
</node>
</node>
</map>
