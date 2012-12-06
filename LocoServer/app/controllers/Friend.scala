package controllers

import play.api._
import play.api.mvc._
import play.api.data._
import play.api.data.Forms._

import models._
import views._

// written by Patrick Burd

object FriendController extends Controller with Secured{

	def getFriends = IsAuthenticated { username => _ =>
		User.findByUsername(username).map { user =>
			Ok(xml.friends(User.getFriends(username)))
		}.getOrElse(Forbidden)
	}
}