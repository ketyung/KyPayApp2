create database if not exists kypay_db;
use kypay_db;

grant all on kypay_db.* to 'kypay_dbusr'@'localhost' identified by 'bH562fRWeRtyA#n673';

drop table if exists kypay_user;
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

drop table if exists kypay_user_address;
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

drop table if exists kypay_user_img;
create table if not exists kypay_user_img (

    id varchar(32) default 'x' NOT null,
    pid smallint(2) default 1 NOT null,
    ptype enum('P', 'I') default 'P' NOT null,
    url text,
    last_updated datetime,
    PRIMARY KEY (id,pid),
    FOREIGN KEY (id) REFERENCES kypay_user(id)

)ENGINE=INNODB;

drop table if exists kypay_user_wallet;
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


alter table kypay_user_wallet add service_wallet_id varchar(255) after type;
alter table kypay_user_wallet add service_contact_id varchar(255) after type;
alter table kypay_user_wallet add service_cust_id varchar(255) after service_contact_id;
alter table kypay_user_wallet add service_addr_id varchar(255) after type;
alter table kypay_user_wallet add service_po_sender_id varchar(255) after service_cust_id;
alter table kypay_user_wallet add service_po_ben_id varchar(255) after service_cust_id;


alter table kypay_user_wallet modify service_wallet_id varchar(128);
alter table kypay_user_wallet modify service_contact_id varchar(128);
alter table kypay_user_wallet modify service_cust_id varchar(128);
alter table kypay_user_wallet modify service_addr_id varchar(128);
alter table kypay_user_wallet modify service_po_sender_id varchar(128);
alter table kypay_user_wallet modify service_po_ben_id varchar(128);






create unique index wallet_uidx on kypay_user_wallet(id,type,currency);

drop table if exists kypay_user_payment_tx;
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

alter table kypay_user_payment_tx add note varchar(64) after method;

alter table kypay_user_payment_tx modify to_uid_type enum('B','P', 'E', 'U') default 'U' NOT null;

alter table kypay_user_payment_tx add service_payment_id varchar(128) after method;

ALTER TABLE `kypay_user_payment_tx` CHANGE `service_payment_id` `service_id` VARCHAR(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;

alter table kypay_user_payment_tx modify service_payment_id varchar(255);

alter table kypay_user_payment_tx modify method varchar(64);

alter table kypay_user_payment_tx add wallet_ref_id varchar(16) after to_uid_type;

alter table kypay_user_payment_tx add to_wallet_ref_id varchar(16) after wallet_ref_id;

alter table kypay_user_payment_tx add tx_type enum('WT', 'SM', 'RM', 'PB') after to_uid_type;


update kypay_user_payment_tx set method = 'kypay_send_money' where method = 'send_money';


drop table if exists kypay_device_token;
create table if not exists kypay_device_token (

    id varchar(32) default 'x' NOT null,
    token varchar(128) default 'xxx' NOT null,
    last_updated datetime,
    primary key(id,token)
);


alter table kypay_device_token add device_type enum('I', 'A','O') after token;


drop table if exists kypay_biller;
create table if not exists kypay_biller (

    id varchar(32) default 'x' NOT null,
    service_bid varchar(128),
    name varchar(128),
    addr_line1 varchar(255),
    addr_line2 varchar(255),
    post_code varchar(20),
    city varchar(150),
    state varchar(150),
    country varchar(5),
    icon_url varchar(255),
    status enum('A','S') default 'A',
    last_updated datetime,
    primary key(id)
);

insert into kypay_biller(id,service_bid,name,country,icon_url,last_updated)
values('sesb-88277376aga2', 'beneficiary_42f0049c56b62a6324da9d7ed14735af',
'SESB', 'MY', '/images/billers/MY/sesb.png', now());


insert into kypay_biller(id,service_bid,name,country,icon_url,last_updated)
values('astro_77363avdvd3a63', 'beneficiary_ebf65ac46c65cc7d6aac5f69d05e4ca9',
'Astro', 'MY', '/images/billers/MY/astro.png', now());


insert into kypay_biller(id,service_bid,name,country,icon_url,last_updated)
values('tm_77ggsgdvVAf390', 'beneficiary_3e90373749167aa868b02e4012c8345f',
'Telekom', 'MY', '/images/billers/MY/tm.png', now());


alter table kypay_biller add by_type enum('PN', 'AN', 'O') default 'AN';

alter table kypay_biller add number_validator varchar(128);

update kypay_biller set number_validator = '^[0-9+]{0,1}+[0-9]{5,16}$' where id = 'tm_77ggsgdvVAf390';


alter table kypay_biller add payout_method varchar(32) after service_bid;

update kypay_biller set payout_method = 'my_affinbank_bank' where id = 'sesb-88277376aga2';
update kypay_biller set payout_method = 'my_allianceislamicbank_bank' where id = 'astro_77363avdvd3a63';
update kypay_biller set payout_method = 'my_affinbank_bank' where id = 'tm_77ggsgdvVAf390';


alter table kypay_biller modify payout_method varchar(64);



drop table if exists kypay_message;
create table if not exists kypay_message (

    id varchar(32) default 'x' NOT null,
    uid varchar(32) default 'x' NOT null,
    item_id varchar(32),
    title varchar(128),
    sub_title varchar(255),
    type enum('SM', 'RM','O'),
    last_updated datetime,
    primary key(id)
);


create table if not exists kypay_seller_category (
    
    id varchar(12) default 'x' NOT null,
    name varchar(64),
    last_updated datetime,
    primary key(id)
);


insert into kypay_seller_category (id, name, last_updated)
values ('BK-YH62738L', 'Books',now());

insert into kypay_seller_category (id, name, last_updated)
values ('COL-2663BBL', 'Collectibles',now());

insert into kypay_seller_category (id, name, last_updated)
values ('HA-BH62736N', 'Home Appliances',now());

insert into kypay_seller_category (id, name, last_updated)
values ('GG-4BTHY672', 'Gadgets',now());



create table if not exists kypay_seller (

    id varchar(32) default 'x' NOT null,
    uid varchar(32) default 'x' NOT null,
    name varchar(64),
    description varchar(128),
    primary key(id)
);

create table if not exists kypay_seller_item (

    id varchar(12) default 'x' NOT null,
    seller_id varchar(32) default 'x' NOT null,
    name varchar(64),
    description varchar(128),
    price float(10,2),
    currency varchar(5),
    primary key(id,seller_id)
);


