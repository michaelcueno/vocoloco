package models

import play.api.db._
import play.api.Play.current
import anorm._
import anorm.SqlParser._


case class User(username: String, name: String, url: String, password: String, isNew: String="false")

object User {

  // Parses User from ResultSet
  val simple = {
    get[String]("loco_user.username") ~
    get[String]("loco_user.name") ~
    get[String]("loco_user.url") ~
    get[String]("loco_user.password") map {
      case username~name~url~password => User(username, name, url, password)
    }
  }


  // maybe this method should return something
  // creates a relation between 2 users
  def addFriend(username:String, friendName:String) = {
    DB.withConnection { implicit connection =>
      SQL(
        """
        insert into friend values(
          {username}, {friendName}
        )
        """
      ).on(
        'username -> username,
        'friendName -> friendName
      ).executeUpdate()
    }
  }

  //get users friends

  // where friend.username = {username} lastline query
  def getFriends(username: String): Seq[User] = {
    DB.withConnection { implicit connection => 
      SQL(
        """
        select loco_user.* from loco_user
        join friend on friend.user_friend = loco_user.username
        where friend.username = {username}
        """
      ).on(
        'username -> username
      ).as(User.simple *)
    }
  }


  // get all users
  def findAll: Seq[User] = {
    DB.withConnection { implicit connection => 
      SQL("select * from loco_user").as(User.simple *)
    }
  }

  // add a user to the database
  def create(user: User): User = {
    DB.withConnection { implicit connection => 
      SQL(
        """
          insert into loco_user values (
            {username}, {name}, {url}, {password}
          )
        """
      ).on(
        'username -> user.username,
        'name     -> user.name,
        'url      -> user.url,
        'password -> user.password
      ).executeUpdate()

      user
    }
  }

  // retrieve a user by user name
  def findByUsername(username: String): Option[User] = {
    DB.withConnection { implicit connection => 
    	SQL("select * from loco_user where username = {username}").on(
    			'username -> username
    	).as(User.simple.singleOpt)
    }
  }
  
  // guess what this does
  def authenticate(username: String, password: String): Option[User] = {
    DB.withConnection { implicit connection => 
    	SQL(
	    	"""
	    	select * from loco_user where 
	    	username = {username} and password = {password}
	    	"""
    	).on(
    		'username -> username,
    		'password -> password
    	).as(User.simple.singleOpt)
    }
  }
  
  
}