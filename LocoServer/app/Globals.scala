import play.api._

import models._
import anorm._


object Global extends GlobalSettings {
	
	override def onStart(app: Application) {
		InitialData.insert()
	}
}


// this populates all the dummy data
object InitialData {
	
	// TODO change time resolution to contain seconds
	def date(str: String) = new java.text.SimpleDateFormat("yyyy-MM-dd").parse(str)

	def insert() = {

		if (User.findAll.isEmpty) {

			// add users
			Seq(
				User("pburd2", "Pat Burd","/assets/images/pburd2.jpg","burdpass"),
				User("mcueno2", "Mike Cueno","/assets/images/mcueno2.jpg" ,"cuenopass"),
				User("ooman", "Alex Ooman","/assets/images/ooman.jpg", "oomanpass"),
				User("hal","hal","/assets/images/hal.jpg","computer"),
				User("t1000","Terminator","/assets/images/t1000.jpg" ,"skynet"),
				User("happy:)","Iam Sohappy","/assets/images/user1.jpg" ,"userpass"),
				User("ricflair", "Ric Flair","/assets/images/ricflair.jpg", "natural1"),
				User("bobama","Barrack Obama","/assets/images/bobama.jpg","elpresidente"),
				User("arnold","The Govenor","/assets/images/arnold.jpg","arnoldpass"),
				User("mrrogers","The Mr. Rogers","/assets/images/mrrogers.jpg","rogerpass"),
				User("mc","Mike Corleone","/assets/images/pacino.jpg","pacinopass"),
				User("magicmike","Mike Scott","/assets/images/mike.jpg","mikepass")
			).foreach(User.create)

			// add users friends
			User.addFriend("pburd2", "mcueno2")
			User.addFriend("pburd2", "t1000")
			User.addFriend("pburd2", "ooman")
			User.addFriend("pburd2", "bobama")
			User.addFriend("mcueno2", "bobama")
			User.addFriend("mcueno2", "hal")
			User.addFriend("mcueno2", "t1000")
			User.addFriend("mcueno2", "pburd2")
			User.addFriend("pburd2", "arnold")
			User.addFriend("mcueno2", "arnold")
			User.addFriend("pburd2", "happy:)")
			User.addFriend("mcueno2", "happy:)")
			User.addFriend("pburd2", "hal")
			User.addFriend("pburd2", "mrrogers")
			User.addFriend("mcueno2", "mrrogers")
			User.addFriend("pburd2", "mc")
			User.addFriend("mcueno2", "mc")
			User.addFriend("pburd2", "magicmike")
			User.addFriend("mcueno2", "magicmike")

		}

		//  create a conversation with associated conversation members
		if (Conversation.findAll.isEmpty) {
			val convMems = Seq("mcueno2", "bobama", "hal", "ooman", "magicmike")
			val myConversation = Conversation(Id(1), "Crazy partisan scream fest!", "pburd2", Some(date("2012-11-29")))
			Conversation.createConversation(myConversation, convMems)
			val convMems1 = Seq("mcueno2", "ricflair", "hal", "ooman", "t1000", "arnold")
			val myConversation1 = Conversation(Id(2), "Freestyle Rap Battle!", "pburd2", Some(date("2012-12-24")))
			Conversation.createConversation(myConversation1, convMems1)

		}
		
		if (Message.findAll.isEmpty) {

			Seq(
				Message(
					Id(1),
					"hal",
					"I was designed in Champaign-Urbana Illinois.",
					"message url",
					Some(date("2012-11-10"))
				),
				Message(
					Id(2),
					"bobama",
					"I used to Illinois, now I live in the Whitehouse. Boom!",
					"message url",
					Some(date("2012-11-11"))
				),
				Message(
					Id(3),
					"mcueno2",
					"Hey Hal, what is love?",
					"message url",
					Some(date("2012-11-12"))
				),
				Message(
					Id(4),
					"pburd2",
					"Hey Barrack, when is your buddy The Donald going to join Vocoloco",
					"message url",
					Some(date("2012-11-13"))
				),
				Message(
					Id(5),
					"ooman",
					"You guys here about the sick square dance session this friday?",
					"message url",
					Some(date("2012-11-14"))
				),
				Message(
					Id(6),
					"bobama",
					"Hey pburd, I think he is getting a new wig. Boom! I am el presidente!",
					"message url",
					Some(date("2012-11-15"))
				),
				Message(
					Id(7),
					"ooman",
					"So who is going to the square dance, just got some fly new boots",
					"message url",
					Some(date("2012-11-16"))
				),
				Message(
					Id(8),
					"mcueno2",
					"Hey Barrack you and The Donald need to chill out",
					"message url",
					Some(date("2012-11-17"))
				),
				Message(
					Id(9),
					"magicmike",
					"audio message",
					"http://vocoloco.herokuapp.com/assets/images/cage.mp3",
					Some(date("2012-11-18"))
				)


			).foreach { messg =>
				Conversation.addMessage(Id(1), messg)
			}

			Seq(
				Message(
					Id(10),
					"pburd2",
					"Arnold what is the key to get DA'PUMP?",
					"message url",
					Some(date("2012-11-10"))
				),
				Message(
					Id(12),
					"arnold",
					"audio message",
					"http://vocoloco.herokuapp.com/assets/images/arnold7th.mp3",
					Some(date("2012-11-11"))
				),
				Message(
					Id(13),
					"mcueno2",
					"Man Govenor you are so freaking LOCO!",
					"message url",
					Some(date("2012-11-12"))
				),
				Message(
					Id(14),
					"pburd2",
					"Heck yeah he is!",
					"message url",
					Some(date("2012-11-13"))
				),
				Message(
					Id(15),
					"arnold",
					"audio message",
					"http://vocoloco.herokuapp.com/assets/images/arnoldfinal.mp3",
					Some(date("2012-11-14"))
				),
				Message(
					Id(16),
					"mcueno2",
					"Conversation2",
					"message url",
					Some(date("2012-11-15"))
				),
				Message(
					Id(17),
					"ooman",
					"Conversation2",
					"message url",
					Some(date("2012-11-16"))
				),
				Message(
					Id(18),
					"ooman",
					"Conversation2",
					"message url",
					Some(date("2012-11-17"))
				),
				Message(
					Id(19),
					"ooman",
					"Conversation2",
					"message url",
					Some(date("2012-11-18"))
				)


			).foreach { messg =>
				Conversation.addMessage(Id(2), messg)
			}


		

		}

		println("Finished populating DB.")
	





	}


}