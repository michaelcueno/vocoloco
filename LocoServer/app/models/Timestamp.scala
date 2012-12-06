package models

import java.util.{Date}

import play.api.db._
import play.api.Play.current
import anorm._
import anorm.SqlParser._
import java.util.Calendar


// written by Patrick Burd

// create table time_stamp (
// 	id 								bigint		 not null,
// 	username						varchar(255) not null,
// 	conv_id							bigint		 not null,
// 	time_stamp						timestamp	 not null
// );


case class TimeStamp(id: Pk[Long], username: String, conv_id: Pk[Long], time_stamp: Option[Date])


object TimeStamp {

	val simple = {
		get[Pk[Long]]("time_stamp.id")~
		get[String]("time_stamp.username")~
		get[Pk[Long]]("time_stamp.conv_id")~
		get[Option[Date]]("time_stamp.time_stamp") map {
			case id~username~conv_id~time_stamp => TimeStamp(
				id,
				username,
				conv_id,
				time_stamp
			)
		}
	}

	// I know this is not dry, but heh!
	def getTimeNow = {
      val now = Calendar.getInstance
      val day = now.get(Calendar.DAY_OF_MONTH).toString
      val month = (now.get(Calendar.MONTH)+1).toString
      val year = now.get(Calendar.YEAR).toString
      val hour = now.get(Calendar.HOUR_OF_DAY).toString
      val minute = now.get(Calendar.MINUTE).toString
      val second = now.get(Calendar.SECOND).toString
      Option(date(year+"-"+month+"-"+day+" "+" "+hour+":"+minute+":"+second))
    }

    def date(str: String) = new java.text.SimpleDateFormat("yyyy-MM-dd kk:mm:ss").parse(str)


    //create sequence time_stamp_seq start with 1000;
    def getNextId = {
      DB.withConnection { implicit connection =>
        SQL("select nextval(\'time_stamp_seq\')").as(scalar[Long].single)
      }
    }


    def addNewStamp(username: String, conv_id: Pk[Long]) = {
    	DB.withConnection { implicit connection => 
    		SQL(
	    		"""
				insert into time_stamp values(
					{id}, {username}, {conv_id}, {time_stamp}
				)
	    		"""
    		).on(
    			'id -> getNextId,
    			'username -> username,
    			'conv_id -> conv_id,
    			'time_stamp -> getTimeNow
    		).executeUpdate()
    	}
    }


    // time_stamp=(select max(time_stamp) from time_stamp)
    def getNewestTimeStamp(username: String, conv_id: Pk[Long]):Seq[TimeStamp] = {
    	DB.withConnection { implicit connection =>
    		SQL(
    			"""
    			select * from time_stamp 
          where username={username} AND conv_id = {conv_id}
    			"""
    		).on(
    			'username -> username,
    			'conv_id  -> conv_id
    		).as(TimeStamp.simple *)


    	}
    }

}