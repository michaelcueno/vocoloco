package controllers

import akka.util.duration._
import play.api._
import play.api.mvc._
import play.api.libs._

import play.api.libs.iteratee._
import play.api.libs.concurrent._

import actors._
import actors.ChatRoomActor._
import akka.util.Timeout
import akka.pattern.ask
import akka.dispatch.Await

object Application extends Controller {
  
  def index = Action {
    Ok(views.html.index()) 
  }
  
  // -- Comet chat room
  
  def chatRoom = Action { implicit request =>
    Ok(views.html.room())
  }

  def chatRoom1(room: String, user:String) = Action { implicit request =>
    Ok(views.html.room1(room, user))
  }
  
  def stream = Action {
    AsyncResult {
      implicit val timeout = Timeout(5.seconds)
      (ChatRoomActor.ref ? (Join()) ).mapTo[Enumerator[String]].asPromise.map { chunks =>
        Ok.stream(chunks &> Comet( callback = "parent.message"))
      }
    }
  }

  def stream1(room: String, user: String) = Action {
    AsyncResult {
      implicit val timeout = Timeout(5.seconds)
      (ChatRoomActor.ref ? (Join1(room, user)) ).mapTo[Enumerator[String]].asPromise.map { chunks =>
        Ok.stream(chunks &> Comet( callback = "parent.message"))
      }
    }
  }

  // def rooms = Action {
  //   implicit val timeout = Timeout(5.seconds)
  //   val promiseOfRooms = Akka.future { ChatRoomActor.ref ? Rooms()}
  //   AsyncResult {
  //     implicit val timeout = Timeout(5.seconds)
  //     promiseOfRooms.orTimeout("Failed to get it", 2000).map { doItOrFail =>
  //       doItOrFail.fold(
  //         r => Ok("Got it " + promiseOfRooms.toString),
  //         timeout => InternalServerError(timeout)
  //       )
  //     }
  //   }
  // }


  def rooms = Action  {
    implicit val timeout = Timeout(5 seconds)
    Async {
        (ChatRoomActor.ref ? Rooms()).mapTo[List[String]].asPromise.map { response =>
          Ok(response.toString)      
        }      
    }
  }

  // def rooms = Action {

  //   implicit val timeout = Timeout(5 seconds)
  //   val result = Await.result(ChatRoomActor.ref ? Rooms, timeout.duration).asInstanceOf[List[String]]
  //   Ok(result.toString)
    
  // } 



  def say(message: String) = Action {
    ChatRoomActor.ref ! Message(message)
    Ok("Said " + message)
  }

  def say1(room:String, message: String) = Action {
    ChatRoomActor.ref ! Message1(room, message)
    Ok("Said " + message + " to room" + room)
  }



  def test(room: String, message: String) = Action {
    Ok(room +" "+message)
  }

}
