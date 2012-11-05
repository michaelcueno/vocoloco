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
				User("user1","User One","/assets/images/user1.jpg" ,"userpass"),
				User("ricflair", "Ric Flair","/assets/images/ricflair.jpg", "natural1"),
				User("bobama","Barrack Obama","/assets/images/bobama.jpg","elpresidente")
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

		}

		//  create a conversation with associated conversation members
		if (Conversation.findAll.isEmpty) {
			val convMems = Seq("mcueno2", "bobama", "hal", "ooman")
			val myConversation = Conversation(Id(1), "Crazy partisan scream fest!", "pburd2", Some(date("2012-11-29")))
			Conversation.createConversation(myConversation, convMems)
			val convMems1 = Seq("mcueno2", "ricflair", "hal", "ooman", "t1000")
			val myConversation1 = Conversation(Id(2), "Freestyle Rap Battle!", "pburd2", Some(date("2012-12-24")))
			Conversation.createConversation(myConversation1, convMems1)
		}
		
		if (Message.findAll.isEmpty) {

			Seq(
				Message(
					Id(1),
					"hal",
					"Come here I have something to tell you.",
					"some url",
					Some(date("2011-11-29"))
				),
				Message(
					Id(2),
					"bobama",
					"You will flip when here this",
					"message url",
					Some(date("2011-11-29"))
				),
				Message(
					Id(3),
					"mcueno2",
					"Aliens are coming to eat my brain",
					"message url",
					Some(date("2012-10-01"))
				),
				Message(
					Id(4),
					"pburd2",
					"Vocoloco rules!",
					"message url",
					Some(date("2012-11-29"))
				),
				Message(
					Id(5),
					"ooman",
					"A public service annou....",
					"message url",
					Some(date("2012-05-29"))
				),
				Message(
					Id(6),
					"mcueno2",
					"conv 1",
					"message url",
					Some(date("2012-05-29"))
				),
				Message(
					Id(7),
					"ooman",
					"conv 1 - 1",
					"message url",
					Some(date("2012-05-29"))
				),
				Message(
					Id(8),
					"mcueno2",
					"conv 1 - 2",
					"message url",
					Some(date("2012-05-29"))
				),
				Message(
					Id(9),
					"ooman",
					"conv 3",
					"message url",
					Some(date("2012-05-29"))
				)


			).foreach { messg =>
				Conversation.addMessage(Id(1), messg)
			}

						Seq(
				Message(
					Id(10),
					"mcueno2",
					"Conversation2",
					"some url",
					Some(date("2011-11-29"))
				),
				Message(
					Id(12),
					"pburd2",
					"Conversation2",
					"message url",
					Some(date("2011-11-29"))
				),
				Message(
					Id(13),
					"mcueno2",
					"Conversation2",
					"message url",
					Some(date("2012-10-01"))
				),
				Message(
					Id(14),
					"pburd2",
					"Conversation2",
					"message url",
					Some(date("2012-11-29"))
				),
				Message(
					Id(15),
					"mcueno2",
					"Conversation2",
					"message url",
					Some(date("2012-05-29"))
				),
				Message(
					Id(16),
					"mcueno2",
					"Conversation2",
					"message url",
					Some(date("2012-05-29"))
				),
				Message(
					Id(17),
					"ooman",
					"Conversation2",
					"message url",
					Some(date("2012-05-29"))
				),
				Message(
					Id(18),
					"ooman",
					"Conversation2",
					"message url",
					Some(date("2012-05-29"))
				),
				Message(
					Id(19),
					"ooman",
					"Conversation2",
					"message url",
					Some(date("2012-05-29"))
				)


			).foreach { messg =>
				Conversation.addMessage(Id(2), messg)
			}
		}

		println("Finished populating DB.")
	





	}


}