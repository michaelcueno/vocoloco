package controllers

import play.api._
import play.api.mvc._
import play.api.data._
import play.api.data.Forms._

import java.util.{Date}

import anorm._

import models._
import views._

import scala.collection.mutable.ListBuffer

import play.api.http.Writeable
import fly.play.aws.auth.AwsCredentials
import fly.play.s3._


object ListUtil {
  def removeDupsStrings(elements: List[String]):List[String] = {
    if (elements.isEmpty)
      elements
    else
      elements.head :: removeDupsStrings(for (x <- elements.tail if x != elements.head) yield x)
  }

  def removeDupsUser(elements: List[User]):List[User] = {
    if (elements.isEmpty)
      elements
    else
      elements.head :: removeDupsUser(for (x <- elements.tail if x.username != elements.head.username || (x.username == elements.head.username && (x.isNew == "true" && elements.head.isNew != "false") )) yield x)
  }

  // def removeDupsUser(elements: List[User]):List[User] = {
  //   if (elements.isEmpty)
  //     elements
  //   else
  //     elements.head :: removeDupsUser(for (x <- elements.tail if x.username == elements.head.username  && x.isNew == "true" && elements.head.isNew == false) yield x)
  // }
}




object ConversationController extends Controller with Secured {

	val bucket = S3("soundtest")


	def deleteConversation(conv_id: Long) = IsMemberOf(conv_id) { user => implicit request =>
		println("Entered conversation")
		println(conv_id+" "+user)
		Conversation.deleteConversation(Id(conv_id), user)
		Ok("Conversation deleted")
	}


	// TODO: DO filter 
	def getConversations = IsAuthenticated { username => _ =>
		User.findByUsername(username).map { user =>

			val lb = new ListBuffer[(Conversation, List[User], Int)]()
			
			var msgCount = 0

			val conversations = Conversation.getConversations(user.username)
			
			for (c <- conversations) {

				val newestTimeStamp = TimeStamp
					.getNewestTimeStamp(username, c.id).toList.sort((a,b) => a.time_stamp.get.compareTo(b.time_stamp.get) > 0)

				val msgs = Conversation.getConvMessages(c.id)


				var newMsgs : Seq[Message]  = null
				if (newestTimeStamp.length != 0	) {
					newMsgs = msgs.filter(msg => msg.date.get.compareTo(newestTimeStamp(0).time_stamp.get) > 0)

					println("There was a time_stamp and here it is conv_id="+c.id+" username="+username)
					println(newestTimeStamp)
					msgCount = newMsgs.length
					
				} else {
					println("There was no time_stamp and here it is conv_id="+c.id+" username="+username)
					msgCount = 0 
					println(newestTimeStamp)
					newMsgs = msgs
				}

				val conversationMembers = ListUtil.removeDupsUser(Conversation.getConvMembers(c.id).filter(_.username != user.username).toList).toList


				// returns users who sent a message as a string in order
				val usersThatSent = ListUtil.removeDupsStrings(newMsgs.map( m=> m.user_sender).filter(_.length != 0).toList)


				// return a list of Users in order that they have sent a string
				val newMessageSenders = ListUtil.removeDupsUser { usersThatSent.map { u => 
							conversationMembers.filter( _.username == u)
						}.filter(_.length != 0).flatMap(x => x).toList.map { u =>
							u.copy(isNew="true")
						}
						
				}

				val messageSenders = ListUtil.removeDupsUser(newMessageSenders.union(conversationMembers))

				lb += ((c, ListUtil.removeDupsUser(messageSenders), newMsgs.length))

			}
			Ok(xml.conversations(lb.toList))
		}.getOrElse(Forbidden)
	}


	def getConversation(conv_id: Long) = IsMemberOf(conv_id) { user => implicit request =>


		// TODO: update time stamp!!!!!!!!!
		println("Just added TimeStamp for "+conv_id)
		TimeStamp.addNewStamp(user, Id(conv_id))
		println(TimeStamp.getNewestTimeStamp(user, Id(conv_id)).toString)


		
		val lb = new ListBuffer[(Message, User)]()
		val mems = Conversation.getConvMembers(Id(conv_id))

		
		for (c <- Conversation.getConvMessages(Id(conv_id))) {
			if (c.message == "audio message") {
				//val msgWithAmazonUrl = c.copy(url = fileUrlServer(c.url))

				lb += ((c, mems.find(_.username == c.user_sender).getOrElse(User("DNE","DNE","/assets/images/default.jpg","DNE"))))
			} else {
				lb += ((c, mems.find(_.username == c.user_sender).getOrElse(User("DNE","DNE","/assets/images/default.jpg","DNE"))))
			}	
		}

		Ok(xml.conversation(lb.toList, conv_id))
	}

	def getConversationBak(conv_id: Long) = IsMemberOf(conv_id) { user => implicit request =>
		println(user)
		val lb = new ListBuffer[(Message, User)]()
		val mems = Conversation.getConvMembers(Id(conv_id))
		for (c <- Conversation.getConvMessages(Id(conv_id))) {
			lb += ((c, mems.find(_.username == c.user_sender).getOrElse(User("DNE","DNE","/assets/images/default.jpg","DNE"))))	
		}
		Ok(xml.conversation(lb.toList, conv_id))
	}

	// payload will need to be xml to deal with arbitrary size of members of conversation
	def createConversation = IsAuthenticated { username => implicit request =>
		User.findByUsername(username).map { user => 

			var id_mut = -1.toLong
			request.body.asXml.map { xml =>

				println("Inside create conversation!")
				val id = Conversation.getNextId
				id_mut = id
				println(id)
				val title = (xml \ "title").text	
				println(title)
				val users = (xml \\ "username").map { contact => contact.text}
				println(users)
				val date = Conversation.getTimeNow
				println(date)
				val conv = Conversation(Id(id), title, user.username, date)
				Conversation.createConversation(conv, users)
			}
			Ok(""+id_mut)
		}.getOrElse(Forbidden)
	}

	def respondText(conv_id: Long) = IsMemberOf(conv_id) { user => implicit request =>
		
		request.body.asXml.map { xml => 
			val message = (xml \\ "message").text
			println(user)
			println(conv_id)

			println("I am message" + message)
			val msgId = Message.getNextId
			val date = Conversation.getTimeNow
			val msg = Message(Id(msgId), user, message, "message url", date)
			println(msg)
			Conversation.addMessage(Id(conv_id), msg)

		}
		Ok("Success")
	}

	// Add laterwhen respond to audio
	// // begin amazon shit
	// def submit = Action { implicit request =>
	// 	fileUrlServer(" ")
	// 	Ok(html.submit.apply)
	// }

	// helper method create seceret url's for 60 minutes
	def fileUrlServer(fileName: String):String = bucket.url(fileName, 60000)

	def respondAudio(conv_id: Long) = Action(parse.multipartFormData) { request =>
	  	// this is dumby data
		val user = "pburd2"

		request.body.file("test").map { f =>
			println("This is for conv "+conv_id)
			println("Inside file parse")
		  	import java.io.File
		  	import scala.io.Source._
		  	val contentType = f.contentType
			
			println("write temp file")
		  	f.ref.moveTo(new File(f.filename.toString()))
			
			val tempFile = new File(f.filename.toString())

			if (tempFile.exists()) {

				val msgId = Message.getNextId
				val date = Conversation.getTimeNow

				println("Found the temp file")
				val source = fromFile(f.filename.toString())
				// convert to byte array
		  		val byteArray = source.map(_.toByte).toArray
		  		source.close()
		  		val result = bucket + BucketFile(f.filename.toString(), "text/plain", byteArray)

		  		result.map { 
			  		case Left(error) => {
			  			println("Could not write file")
			  		 	Ok("Error writing file")
			  			throw new Exception("Error: " )
			  		}
			  		case Right(success) => {
			  			println("Saved file now writing to database")
			  			val msg = Message(Id(msgId), user, "audio message", f.filename.toString(), date)			  			
			  			println(msg)
			  			println(conv_id)
			  			Conversation.addMessage(Id(1), msg)
			  		}
			    }
			}

		Ok("Succeed") 
	  }.getOrElse(Ok("Fail"))
	}
}