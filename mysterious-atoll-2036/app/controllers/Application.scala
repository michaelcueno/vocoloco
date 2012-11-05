package controllers

import play.api._
import play.api.mvc._
import play.api.data._
import play.api.data.Forms._

import models._
import views._


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
    println("Authenticating")
    println(request.body)
    loginForm.bindFromRequest.fold(
      formWithErrors => BadRequest(html.login(formWithErrors)),
      user => Redirect("/conversations").withSession("username" -> user._1)
      //user => Ok("Success").withSession("username" -> user._1)
    )
  }
  
  def logout = Action {
    Redirect(routes.Application.login).withNewSession
  }

}

trait Secured {

  private def username(request:RequestHeader) = request.session.get("username")

  private def onUnauthorized(request: RequestHeader) = Results.Redirect(routes.Application.login)

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

}

