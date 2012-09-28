package models

import play.api.db._
import play.api.Play.current
import anorm._
import anorm.SqlParser._


case class User(username: String, name: String, password: String)

object User {

  // Parses User from ResultSet
  val simple = {
    get[String]("user.username") ~
    get[String]("user.name") ~
    get[String]("user.password") map {
      case username~name~password => User(username, name, password)
    }
  }
  
  
  // retrieve a user by user name
  def findByUsername(username: String): Option[User] = {
    DB.withConnection { implicit connection => 
    	SQL("select * from user where username = {username}").on(
    			'username -> username
    	).as(User.simple.singleOpt)
    }
  }
  
  // guess what this does
  def authenticate(username: String, password: String): Option[User] = {
    DB.withConnection { implicit connection => 
    	SQL(
	    	"""
	    	select * from user where 
	    	username = {username} and password = {password}
	    	"""
    	).on(
    		'username -> username,
    		'password -> password
    	).as(User.simple.singleOpt)
    }
  }

  
  
}