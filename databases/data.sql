CREATE DATABASE GYM;


CREATE TABLE IF NOT EXISTS BRACELET (

Bracelet_num 	INT	NOT NULL, 
Colour		VARCHAR(45),
PRIMARY KEY (Bracelet_num) );



CREATE TABLE IF NOT EXISTS CORONA_COMPENSATION (

Member_id		INT 		NOT NULL, 
Compensation		VARCHAR(45), 
Lockdown_duration	TIMESTAMP(6),
PRIMARY KEY (Member_id) );



CREATE TABLE IF NOT EXISTS GYM_LOCATION (

Base_id 	CHAR(3) 	NOT NULL,
Base_name 	VARCHAR(45),
Capacity 	INT,
City 		VARCHAR(45),
Street 		VARCHAR(45),
House_num 	INT,
PRIMARY KEY (Base_id));



CREATE TABLE IF NOT EXISTS TRAINER (

TRAINER_id	INT		NOT NULL,
Fname		VARCHAR(45),
Lname		VARCHAR(45),
Birthdate	DATE,	
E_mail		VARCHAR(45),
Sex		CHAR(1),
Base_id		CHAR(3)		NOT NULL,
PRIMARY KEY (Trainer_id),

FOREIGN KEY (Base_id) REFERENCES GYM_LOCATION(Base_id) );



CREATE TABLE IF NOT EXISTS SUBSCRIPTION (

Sub_name 		VARCHAR(45) NOT NULL,
Price 			FLOAT,
Contract_duration 	VARCHAR(45),
PRIMARY KEY (Sub_name));



CREATE TABLE IF NOT EXISTS MEMBER (

Member_id	INT		NOT NULL,
Fname		VARCHAR(45),
Lname		VARCHAR(45),
Birthdate	DATE,	
Sex		CHAR(1),
E_mail		VARCHAR(45),
Entry_date	DATE,
End_date	DATE,
Bracelet_num	INT,
Trainer_id	INT,
Sub_name	VARCHAR(45),
Base_id		CHAR(3),
PRIMARY KEY (Member_id),

FOREIGN KEY (Bracelet_num) REFERENCES BRACELET(Bracelet_num),
FOREIGN KEY (Trainer_id) REFERENCES TRAINER(Trainer_id),
FOREIGN KEY (Sub_name) REFERENCES SUBSCRIPTION(Sub_name),
FOREIGN KEY (base_id) REFERENCES GYM_LOCATION(Base_id) );



CREATE TABLE IF NOT EXISTS ROOM (

Room_num 	INT NOT NULL,
Room_name 	VARCHAR(45),
Capacity 	INT ,
Base_id 	CHAR(3) NOT NULL,
PRIMARY KEY (Room_num),

FOREIGN KEY (Base_id) REFERENCES GYM_LOCATION(Base_id));



CREATE TABLE IF NOT EXISTS COURSE (

Course_id 	INT 		NOT NULL,
Course_name 	VARCHAR(45),
Duration 	VARCHAR(45),
Day 		VARCHAR(45),
Time 		VARCHAR(45),
Room_num 	INT 		NOT NULL,
Base_id 	CHAR(3) 		NOT NULL,
Trainer_id 	INT 		NOT NULL,
PRIMARY KEY (Course_id),

FOREIGN KEY (Room_num) REFERENCES ROOM(Room_num), 
FOREIGN KEY (Base_id) REFERENCES GYM_LOCATION(Base_id),
FOREIGN KEY (Trainer_id) REFERENCES Trainer(Trainer_id) );








INSERT INTO BRACELET
VALUES	(5543,'blue'),
	(5542,'red'),
        (5541,'yellow'),
	(5544, 'grey'),
        (5545, 'grey'),
        (5546, 'rosa'),
        (5547, 'red'),
        (5548, 'blue'),
        (5549, 'blue'),
        (5550, 'red'),
        (5551, 'red'),
        (5552, 'black'),
        (5553, 'rosa'),
        (5554, 'black');
			
			
INSERT INTO CORONA_COMPENSATION
VALUES	(1001,'Shakeflat',null),
    	(1002,'Massageflat',null),
        (1003,'Shakeflat',null),
	(1006,'FriendVoucher',null),
        (1007,'Shakeflat',null),
        (1009,'FriendVoucher',null);

INSERT INTO GYM_LOCATION
VALUES      ('FRA','Gym Frankfurt',201,'Frankfurt','Smith-Allee',1),
            ('MHG','Gym Mannheim',173,'Mannheim','Wrigg-Allee',1),
            ('HAM','Gym Hamburg',212,'Hamburg','Becht-Allee',1),
            ('MUC','Gym Munich',179,'M??nchen','Datenbanken-Allee',1);


INSERT INTO TRAINER
VALUES		(10001,'Pascal','Smith','1999-07-19','pascalsmith@gym.de','M','FRA'),
		(10002,'Leon','Kebel','1999-07-10','lk@t-online.de','M','FRA'),
		(20001,'Tim','Gabel','1909-07-19','timmyg@gym.de','M','MHG'),
            	(30001,'Peter','Smith','1996-06-16','petersmith@gym.de','M','HAM'),
            	(40001,'Hansi','Mueller','1991-09-26','hansimueller@gym.de','M','MUC');

INSERT INTO SUBSCRIPTION
VALUES      ('Standard3',39.99,'104 Weeks'),
            ('Premium2',49.99,'104 Weeks'),
            ('Luxus1',54.99,'52 Weeks');


INSERT INTO MEMBER
VALUES	(1001,'Jonas','Fink','1988-05-22','M','jonasfink@gmail.com','2020-01-10','2022-01-10',5543,10001,'Premium2','FRA'),
	(1002,'Marc','Auel','1998-09-12','M','marc.auel@gmail.com','2020-06-10','2022-06-10',5542,10001,'Premium2','FRA'),	
        (1003,'Simone','Petersen','1977-03-12','F','simonesemail@outlook.com','2018-06-10','2021-06-10',5541,10002,'Standard3','FRA'),
        (1004,'Philipe','Werner','1978-05-14','M','pwprivat@gmail.com','2020-06-15','2022-06-15',5544,10001,'Standard3','FRA'),
        (1005,'Armin','Lasche','1948-05-24','M','allll@gmail.com','2019-06-15','2021-06-15',5545,10002,'Standard3','FRA'),
        (1006,'Jana','Schmitt','2001-07-14','W','jjsjsjs@gmail.com','2020-05-25','2022-05-25',5546,20001,'Standard3','MHG'),
        (1007,'Jan','Schmitt','2001-04-14','M','jjs@gmail.com','2020-05-25','2022-05-25',null,20001,'Standard3','MHG'),
        (1008,'Sabrina','Schornsteiner','2000-07-18','W','jermail@gmail.com','2020-05-25','2022-05-25',5547,null,'Standard3','MHG'),
        (1009,'Tobias','Schmitzke','2001-05-13','M','ts@gmail.com','2020-05-25','2022-05-25',5548,20001,'Standard3','MHG'),
        (1010,'Tonia','Schmitzke','2001-04-14','W','tssss@gmail.com','2020-04-25','2022-04-25',5549,null,'Premium2','MHG'),
        (1011,'Lisa','Stein','2000-05-13','W','lslsls@gmail.com','2020-05-25','2022-05-25',5550,20001,'Standard3','MHG'),
        (1012,'Rudolph','Argstein','1989-03-13','M','rudomail@gmail.com','2020-05-25','2023-05-25',5551,20001,'Standard3','MHG'),
        (1013,'Mehmet','Boazatti','2000-05-22','M','memetsm@gmail.com','2019-05-25','2022-05-25',null,null,'Standard3','MHG'),
        (1014,'Manuel','Adler','1980-04-22','M','madler@gmail.com','2019-05-25','2022-05-25',5552,30001,'Standard3','HAM'),
        (1015,'Sandra','Uhlig','1960-05-24','W','suhlig@gmail.com','2019-05-25','2022-05-25',5553,30001,'Standard3','HAM'),
        (1016,'Manuela','Schmidt','1990-04-12','W','mschmidt@gmail.com','2019-04-25','2022-04-25',5554,40001,'Standard3','MUC'),
        (1017,'Sebastian','Thon','1999-05-28','M','sthon@web.com','2019-05-15','2022-05-15',null,40001,'Standard3','MUC');

INSERT INTO ROOM
VALUES      (101,'Bodyweight-Area',64,'FRA'),
            (102,'Weightlift-Area',83,'FRA'),
            (103,'Crossfit-Area',32,'FRA'),
            (104,'Sauna',22,'FRA'),
       	    (105,'Pool',10,'FRA'),
            (201,'Bodyweight-Area',42,'MHG'),
            (202,'Weightlift-Area',79,'MHG'),
            (203,'Crossfit-Area',31,'MHG'),
            (204,'Sauna',21,'MHG'),
            (301,'Bodyweight-Area',71,'HAM'),
            (302,'Weightlift-Area',100,'HAM'),
            (303,'Crossfit-Area',18,'HAM'),
            (304,'Sauna',23,'HAM'),
            (401,'Bodyweight-Area',53,'MUC'),
            (402,'Weightlift-Area',77,'MUC'),
            (403,'Crossfit-Area',30,'MUC'),
            (404,'Sauna',19,'MUC');
			


INSERT INTO COURSE
VALUES      (10,'Bodyweight only','30 min','Monday','6PM',101,'FRA',10001),
            (20,'Bodyweight only','30 min','Monday','6PM',201,'MHG',20001),
            (30,'Bodyweight only','30 min','Monday','6PM',301,'HAM',30001),
            (40,'Bodyweight only','30 min','Monday','6PM',401,'MUC',40001),
            (11,'Start Up','45 min','Wednesday','5PM',101,'FRA',10001),
            (21,'Start Up','45 min','Wednesday','5PM',201,'MHG',20001),
            (31,'Start Up','45 min','Wednesday','5PM',301,'HAM',30001),
            (41,'Start Up','45 min','Wednesday','5PM',401,'MUC',40001),
            (12,'Active Recovery Mobility','30 min','Saturday','9AM',101,'FRA',10001),
            (22,'Active Recovery Mobility','30 min','Saturday','9AM',201,'MHG',20001),
            (32,'Active Recovery Mobility','30 min','Saturday','9AM',301,'HAM',30001),
            (42,'Active Recovery Mobility','30 min','Saturday','9AM',401,'MUC',40001),
            (13,'Gym Strong','30 min','Tuesday','8PM',102,'FRA',10001),
            (23,'Gym Strong','30 min','Tuesday','8PM',202,'MHG',20001),
            (33,'Gym Strong','30 min','Tuesday','8PM',302,'HAM',30001),
            (43,'Gym Strong','30 min','Tuesday','8PM',402,'MUC',40001),
            (14,'Swing Shift','30 min','Thursday','7PM',102,'FRA',10001),
            (24,'Swing Shift','30 min','Thursday','7PM',202,'MHG',20001),
	    (34,'Swing Shift','30 min','Thursday','7PM',302,'HAM',30001),
            (44,'Swing Shift','30 min','Thursday','7PM',402,'MUC',40001),
	    (15,'Power Up','45 min','Sunday','10AM',102,'FRA',10001),
            (25,'Power Up','45 min','Sunday','10AM',202,'MHG',20001),
            (35,'Power Up','45 min','Sunday','10AM',302,'HAM',30001),
            (45,'Power Up','45 min','Sunday','10AM',402,'MUC',40001),
            (16,'Metabolic Boost','30 min','Monday','3PM',103,'FRA',10001),
            (26,'Metabolic Boost','30 min','Monday','3PM',203,'MHG',20001),
            (36,'Metabolic Boost','30 min','Monday','3PM',303,'HAM',30001),
            (46,'Metabolic Boost','30 min','Monday','3PM',403,'MUC',40001),
            (17,'Plank Jump','30 min','Friday','5PM',103,'FRA',10001),
	    (27,'Plank Jump','30 min','Friday','5PM',203,'MHG',20001),
            (37,'Plank Jump','30 min','Friday','5PM',303,'HAM',30001),
            (47,'Plank Jump','30 min','Friday','5PM',403,'MUC',40001),
            (18,'The Fast 15','45 min','Sunday','10AM',103,'FRA',10001),
            (28,'The Fast 15','45 min','Sunday','10AM',203,'MHG',20001),
            (38,'The Fast 15','45 min','Sunday','10AM',303,'HAM',30001),
            (48,'The Fast 15','45 min','Sunday','10AM',403,'MUC',40001);




CREATE VIEW Trainer_Overview AS
SELECT t.Fname, t.Lname, g.base_name, g.street, g.house_num, g.city
FROM TRAINER t, GYM_LOCATION g
WHERE t.Base_id = g.Base_id
