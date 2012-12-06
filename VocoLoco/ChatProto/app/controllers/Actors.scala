package actors

import play.api._

import akka.actor._
import akka.actor.Actor._

import play.api.libs.iteratee._
import play.api.libs.concurrent._

class ChatRoomActor extends Actor {
  
  import ChatRoomActor._


  
  var members  = Seq.empty[PushEnumerator[String]]

  var members1 = Map.empty[String, (String, PushEnumerator[String])]

  def receive = {
    
    case Join() => {
      lazy val channel: PushEnumerator[String] =  Enumerator.imperative[String](
        onComplete = self ! Quit(channel)
      )
      members = members :+ channel
      Logger.info("New member joined"+members.toString)
      sender ! channel
    }

    case Join1(room, user) => {
      lazy val channel1: PushEnumerator[String] =  Enumerator.imperative[String](
        onComplete = self ! Quit1(channel1)
      )

      members1 = members1 + (user ->(room,channel1))
      Logger.info("New member="+user+ " room="+room)
      sender ! channel1
    }
    
    case Quit(channel) => {
      Logger.info("Member has disconnected: " + channel)
      members = members.filterNot(_ == channel)
    }

    case Quit1(channel1) => {
      Logger.info("Entering Quit1")
      Logger.info("Member has disconnected: " + channel1)
      members1 = members1.filterNot {
        case (k, v) => v._2 == channel1
      }
    }
    
    case Message(msg) => {
      Logger.info("Got message, send it to " + (Option(members).filterNot(_.isEmpty).map(_.size + " members").getOrElse("no one")))
      members.foreach(_.push(msg))
    }

    case Message1(room, msg) => {
      Logger.info("Got message, send it to " + (Option(members).filterNot(_.isEmpty).map(_.size + " members in room"+room).getOrElse("no one")))
      members1.filter { 
        case (k, v) => v._1 == room 
      } foreach { 
        case (k,v) => v._2.push(msg)
      }
    }

    case Rooms() => {
      sender ! members1.map { case (x,v) => v._1 }
    }

    
  }
  
}

object ChatRoomActor {
  
  trait Event
  case class Join() extends Event
  case class Join1(room: String, user: String) extends Event
  case class Quit(channel: PushEnumerator[String]) extends Event
  case class Quit1(channel1: PushEnumerator[String]) extends Event
  case class Message(msg: String) extends Event
  case class Message1(room: String, msg: String) extends Event
  case class Rooms() extends Event
  lazy val system = ActorSystem("chatroom")
  lazy val ref = system.actorOf(Props[ChatRoomActor])
  
}
