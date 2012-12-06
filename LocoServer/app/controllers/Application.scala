package controllers

import play.api._
import play.api.mvc._
import play.api.data._
import play.api.data.Forms._

import models._
import views._

// written by Patrick Burd
object Application extends Controller {
    
  val loginForm = Form(
	tuple(
		"username" -> text,
		"password" -> text
	) verifying("Invalid email or password", result => result match {
	  case (username, password) => User.authenticate(username, password).isDefined
	 })
  )

  def index = Action {
    Redirect("/login")
  }
  
  def login = Action { implicit request =>
    println("Just hit login")
    Ok(html.login(loginForm))
  }
  
  def authenticate = Action { implicit request =>
    loginForm.bindFromRequest.fold(
      formWithErrors => BadRequest(html.login(formWithErrors)),
      user => Redirect("/conversations").withSession("username" -> user._1)
    )
  }
  
  def logout = Action {
    Redirect(routes.Application.login).withNewSession
  }

}

trait Secured {

  private def username(request:RequestHeader) = request.session.get("username")

  private def onUnauthorized(request: RequestHeader) = Results.Redirect(routes.Application.login)
  
  // TODO create a wrapper around action so that you can optionally pass in a 
  // a non-standard parser
  def IsAuthenticated(f: => String => Request[AnyContent] => Result) = Security.Authenticated(username, onUnauthorized) { user =>
    Action(request => f(user)(request))
  }

  def IsMemberOf(conv_id: Long)(f: => String => Request[AnyContent] => Result) = IsAuthenticated { user => request =>
    if(Conversation.isMemOfConv(conv_id, user)) {
      f(user)(request)
    } else {
      Results.Forbidden
    }
  }
  
  // a wrapper class
  case class IsMemberOfWrapper[A](action: Action[A]) extends Action[A] {
    
    def apply(request: Request[A]): Result = {
      action(request)
    }
    
    lazy val parser = action.parser
    
  }
  
//  def otherWay[A](action: Action[A]): Action[A] = {
//    Action(action.parser) { request =>
//      
//    }
//  }
  

}

