package models

import java.util.{Date}

import play.api.db._
import play.api.Play.current

import anorm._
import anorm.SqlParser._



case class Message(
	id: Pk[Long],
	user_sender: String,
	message: String,
	url: String,
	date: Option[Date]
)



object Message {

	val simple = {
		get[Pk[Long]]("message.id")~
		get[String]("message.user_sender")~
		get[String]("message.message")~
		get[String]("message.url")~
		get[Option[Date]]("message.date") map {
			case id~user_sender~message~url~date => Message(
				id,
				user_sender,
				message,
				url,
				date
			)
		}
	}

	def create(message: Message): Message = {
		DB.withConnection { implicit connection =>

			val id: Long = message.id.getOrElse {
				SQL("select nextval(\'message_seq\')").as(scalar[Long].single)
			}


			SQL(
				"""
					insert into message values (
						{id},
						{user_sender},
						{message},
						{url},
						{date}
					)
				"""
			).on(
				'id -> id,
				'user_sender -> message.user_sender,
				'message -> message.message,
				'url   -> message.url,
				'date  -> message.date
			).executeUpdate()

			message.copy(id = Id(id))

		}

	}


	def findAll: Seq[Message] = {
		DB.withConnection { implicit connection =>
			SQL(
				"select * from message"
			).as(Message.simple *)
		}
	}



	/*
		Everthing below this is garbage delete later 
	*/

	// find sent messages by a user
	// def findByUserSender(user_sender: String): Seq[Message] = {
	// 	DB.withConnection { implicit connection =>
	// 		SQL(
	// 		""" 
	// 			select * from message where user_sender = {user_sender}
	// 		"""
	// 	).on(
	// 		'user_sender ->user_sender
	// 	).as(Message.simple *)

	// 	}
	// }

	// // find received messages from a user
	// def findByUserReceiver(user_receiver: String): Seq[Message] = {
	// 	DB.withConnection { implicit connection =>
	// 		SQL(
	// 		""" 
	// 			select * from message where user_receiver = {user_receiver}
	// 		"""
	// 	).on(
	// 		'user_receiver ->user_receiver
	// 	).as(Message.simple *)

	// 	}
	// }

	// // find all messages received and sent by a user
	// def findAllRelatedMessages(username: String): Seq[Message] = {
	// 	DB.withConnection { implicit connection =>
	// 		SQL(
	// 		""" 
	// 			select * from message where user_sender = {user_sender}
	// 			or user_receiver =  {user_receiver} order by date
	// 		"""
	// 	).on(
	// 		'user_sender -> username,
	// 		'user_receiver -> username
	// 	).as(Message.simple *)

	// 	}
	// }  


}