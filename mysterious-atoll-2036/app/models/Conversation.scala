package models

import java.util.{Date}

import play.api.db._
import play.api.Play.current
import anorm._
import anorm.SqlParser._


case class Conversation(id: Pk[Long], title: String, created_by: String, date: Option[Date])


object Conversation {
	
	val simple = {
	    get[Pk[Long]]("conversation.id") ~
	    get[String]("conversation.title") ~
	    get[String]("conversation.created_by") ~
	    get[Option[Date]]("conversation.date") map {
	      case id~title~created_by~date => Conversation(id, title, created_by, date)
    	}
  	}

    def isMemOfConv(conv_id: Long, username: String): Boolean = {
      getConvMembers(Id(conv_id)).exists(_.username == username)
    }

  	def findAll : Seq[Conversation] = {
  		DB.withConnection { implicit connection => 
  			SQL("select * from conversation").as(Conversation.simple *)
  		}
  	}


  	def getConversations(username: String): Seq[Conversation] = {
  		DB.withConnection { implicit connection => 
  			SQL(
  				""" 
  					select conversation.* from conversation
  					join conv_user on conv_user.conv_id = conversation.id
  					where conv_user.username = {username}
  				"""
  			).on(
  				'username -> username
  			).as(Conversation.simple *)
  		}
  	}

  	def getConvMembers(conv_id: Pk[Long]): Seq[User] = {
  		DB.withConnection { implicit connection => 
  			SQL(
  				""" 
  					select loco_user.* from loco_user
  					join conv_user on conv_user.username = loco_user.username
  					where conv_user.conv_id = {id}
  				"""
  			).on(
  				'id -> conv_id
  			).as(User.simple *)
  		}
  	}

  	// add user to conversation may not be needed
  	def addUser = None

    def getConvMessages(conv_id: Pk[Long]): Seq[Message] = {

      DB.withConnection { implicit connection =>
        SQL(
          """
          select message.* from message
          join conv_message on conv_message.messg_id = message.id
          where conv_message.conv_id = {conv_id}
          """
        ).on(
          'conv_id -> conv_id
        ).as(Message.simple *)
      }

    }

    // TODO fix parameter to so that it takes just Long and
    // convert inside the method
    // add message to conversation
    def addMessage(conv_id: Pk[Long], message: Message): Message = {
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


        SQL(
          """
            insert into conv_message values(
              {conv_id},{messg_id}
            )
          """
        ).on(
          'conv_id -> conv_id,
          'messg_id -> id
        ).executeUpdate()

        message.copy(id = Id(id))

      }

    }


  	// create conversation
  	def createConversation(conversation: Conversation, addedUsers: Seq[String]): Conversation = {
  		DB.withConnection { implicit connection =>
  			


        val id: Long = conversation.id.getOrElse {
          SQL("select nextval(\'conversation_seq\')").as(scalar[Long].single)
        }
        // create conversation
  			SQL(
		        """
		          insert into conversation values (
		            {id}, {title}, {created_by}, {date}
		          )
		        """
	     	).on(
	        	'id 	-> id,
	        	'title  -> conversation.title,
	        	'created_by -> conversation.created_by,
	        	'date   -> conversation.date
	      	).executeUpdate()

          // add selected contacts to conversation
	      	addedUsers.foreach { user =>
	      		SQL(
	      			"""
	      			insert into conv_user values (
	      				{id}, {user}
	      			)
	      			"""
	      		).on(
	      			'id -> id,
	      			'user -> user
	      		).executeUpdate()
	      	}

	      	// add user who created conversation to conversation
	      	SQL(
	      		"""
	      		insert into conv_user values({id}, {user})
	      		"""
	      	).on('id -> id, 'user -> conversation.created_by).executeUpdate()

	      	conversation.copy(id = Id(id))
  		}
  	}

}