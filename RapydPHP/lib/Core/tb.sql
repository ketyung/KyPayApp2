create database kypay_db;
use kypay_db;

grant all on kypay_db.* to 'kypay_dbusr'@'localhost' identified by 'bH562fRWeRtyA#n673';

drop table kypay_user;
create table if not exists kypay_user (

	id varchar(32) default 'x' NOT null,
	first_name VARCHAR(100) default 'x' NOT NULL,
    last_name VARCHAR(100) default 'x' NOT NULL,
    account_type enum('B', 'P','O') default 'P' NOT NULL,
    dob datetime,
	email varchar(255),
	phone_number varchar(255),
    country_code varchar(5) default 'MY' NOT NULL,
	seed smallint(3),
	stat enum('SI', 'SO') default 'SO' NOT null,
	last_stat_time datetime,
    PRIMARY KEY (id)

)ENGINE=INNODB;

create index phone_idx on kypay_user (phone_number);

create index email_idx on kypay_user (email);

alter table kypay_user add last_updated datetime;

drop table kypay_user_address;
create table if not exists kypay_user_address (
    
    id varchar(32) default 'x' NOT null,
    addr_type enum('R','W','O') default 'R' NOT null,
    line1 varchar(255),
    line2 varchar(255),
    post_code varchar(20),
    city varchar(150),
    state varchar(150),
    country varchar(5),
    PRIMARY KEY(id,addr_type),
    FOREIGN KEY (id) REFERENCES kypay_user(id)

)ENGINE=INNODB;

alter table kypay_user_address add last_updated datetime;

drop table kypay_user_img;
create table if not exists kypay_user_img (

    id varchar(32) default 'x' NOT null,
    pid smallint(2) default 1 NOT null,
    ptype enum('P', 'I') default 'P' NOT null,
    url text,
    last_updated datetime,
    PRIMARY KEY (id,pid),
    FOREIGN KEY (id) REFERENCES kypay_user(id)

)ENGINE=INNODB;

drop table kypay_user_wallet;
create table if not exists kypay_user_wallet (
    
    id varchar(32) default 'x' NOT null,
    ref_id varchar(16) default 'x' NOT null,
    balance float(10,2),
    currency varchar(5) default 'MYR' NOT null,
    type enum('B', 'P') default 'P' NOT null,
    last_updated datetime,
    PRIMARY KEY(id,ref_id),
    FOREIGN KEY (id) REFERENCES kypay_user(id)

)ENGINE=INNODB;

create unique index wallet_uidx on kypay_user_wallet(id,type,currency);

drop table kypay_user_payment_tx;
create table if not exists kypay_user_payment_tx (
    
    id varchar(32) default 'x' NOT null,
    uid varchar(32) default 'x' NOT null,
    to_uid varchar(255),
    to_uid_type enum('P', 'E', 'U') default 'U' NOT null,
    amount float(10,2),
    currency varchar(5) default 'MYR' NOT null,
    method varchar(100),
    stat enum('S', 'E', 'N') default 'N' NOT null,
    stat_message varchar(255),
    last_updated datetime,
    PRIMARY KEY(id),
    FOREIGN KEY (uid) REFERENCES kypay_user(id)

)ENGINE=INNODB;




