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
	date: Option[Date],
	isNew: String = "false"
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

	def getNextId = {
      DB.withConnection { implicit connection =>
        SQL("select nextval(\'message_seq\')").as(scalar[Long].single)
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
}