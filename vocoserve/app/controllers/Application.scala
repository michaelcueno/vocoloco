package controllers

import play.api._
import play.api.mvc._
import play.api.data._
import play.api.data.Forms._

import models._
import views._


object Application extends Controller {
  
  def index = Action {
    Ok(html.index("Your new application is ready."))
  }
  
  
  val loginForm = Form(
	tuple(
		"username" -> text,
		"password" -> text
	) verifying("Invalid email or password", result => result match {
	  case (username, password) => User.authenticate(username, password).isDefined
	})
  )
  
  def login = Action { implicit request =>
    Ok(html.login(loginForm))
  }
  
  def authenticate = Action { implicit request =>
    loginForm.bindFromRequest.fold(
      formWithErrors => BadRequest(html.login(formWithErrors)),
      user => Redirect("/").withSession("username" -> user._1)
    )
  }
  
  def logout = Action {
    Redirect(routes.Application.login).withNewSession.flashing(
      "success" -> "You've been logged out"
    )
  }
  
  
  
}