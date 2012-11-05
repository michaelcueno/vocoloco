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

object ConversationController extends Controller with Secured {

	//get all conversations by user
	def getConversations = IsAuthenticated { username => _ =>
		User.findByUsername(username).map { user =>
			val lb = new ListBuffer[(Conversation, List[User])]()

			for (c <- Conversation.getConversations(user.username)) {
				lb += ((c, Conversation.getConvMembers(c.id).filter(_.username != user.username).toList))
			}
			Ok(xml.conversations(lb.toList))
		}.getOrElse(Forbidden)
	}

	// serve all messages in a given conversation
	def getConversation(conv_id: Long) = IsMemberOf(conv_id) { user => implicit request =>
		println(user)
		val lb = new ListBuffer[(Message, User)]()
		val mems = Conversation.getConvMembers(Id(conv_id))
		for (c <- Conversation.getConvMessages(Id(conv_id))) {
			lb += ((c, mems.find(_.username == c.user_sender).getOrElse(User("DNE","DNE","/assets/images/default.jpg","DNE"))))	
		}
		Ok(xml.conversation(lb.toList, conv_id))
	}

	// payload will need to be xml to deal with arbitrary size of members of conversation
	def createConversation = IsAuthenticated { username => _ =>
		User.findByUsername(username).map { user =>
			Ok("TODO")
		}.getOrElse(Forbidden)
	} 

	// payload from the client will consist of xml
	// to deal with arbitrary length
	def respondConversation(conv_id: Long) = IsMemberOf(conv_id) { user => implicit request =>
	  request.body.asXml.map { xml =>
	  	println(xml)
	    (xml \\ "test" headOption).map(_.text).map { value =>
	      Ok("I am the value" + value)
	    }.getOrElse {
	      BadRequest("Missing parameter [name]")
	    }
	  }.getOrElse {
	    BadRequest("Expecting Xml data")
	  }
	}

	object XmlValidator {

		// make this an extrator! that returns a data stucture
		def validateConvResponsePayload(xml : scala.xml.NodeSeq): Boolean {

		}
	}

}