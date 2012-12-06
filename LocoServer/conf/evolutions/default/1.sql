# --- Vocoloco Schema

# --- !Ups

create table loco_user (
	username 						varchar(255) not null primary key,
	name 							varchar(255) not null,
	url 							varchar(255) not null,
	password    					varchar(255) not null
);

create table friend (
	username						varchar(255) not null,
	user_friend						varchar(255) not null,
	foreign key(username)	 		references loco_user(username) on delete cascade,
	foreign key(user_friend)		references loco_user(username) on delete cascade
);


-- TODO messages do not need titles
-- TODO user_receiver is not needed will be resolved by conversation relation
create table message (
	id 								bigint	not null primary key,
	user_sender     				varchar(255) not null,
	message							varchar(255) not null,
	url								varchar(255) not null,
	date							timestamp	 not null
);


create table conversation (
	id 								bigint		 not null primary key,
	title	     					varchar(255) not null,
	created_by						varchar(255) not null,
	date							timestamp	 not null
);

-- this will be used in the authentication scheme
-- it will be a way to see if the user belongs to the conversation
--id 								bigint		 not null primary key,
create table conv_user (
	conv_id							bigint		 not null,
	username						varchar(255) not null,
	isActive						boolean 	 not null,
	foreign key(conv_id)			references conversation(id) on delete cascade,
	foreign key(username)			references loco_user(username) on delete cascade
);

create table conv_message (
	conv_id							bigint		 not null,
	messg_id						bigint		 not null,
	foreign key(conv_id)   			references conversation(id) on delete cascade,
	foreign key(messg_id)   		references message(id) on delete cascade
);


create table time_stamp (
	id 								bigint		 not null,
	username						varchar(255) not null,
	conv_id							bigint		 not null,
	time_stamp						timestamp	 not null
);

create sequence message_seq start with 1000;
create sequence conversation_seq start with 1000;
create sequence time_stamp_seq start with 1000;

# -- !Downs

drop table 	  if exists loco_user cascade;
drop table	  if exists friend;
drop table    if exists message cascade;
drop table    if exists conv_message cascade;
drop table    if exists conversation cascade;
drop table    if exists conv_user cascade;
drop table 	  if exists time_stamp;
drop sequence if exists message_seq;
drop sequence if exists conversation_seq;
drop sequence if exists time_stamp_seq;

