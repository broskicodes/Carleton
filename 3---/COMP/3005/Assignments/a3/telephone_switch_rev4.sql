PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE facilities(
	portid integer NOT NULL primary key,
	facility_type varchar(10) --LINE, TRUNK, TREATMENT
	);
INSERT INTO facilities VALUES(1,'LINE');
INSERT INTO facilities VALUES(2,'LINE');
INSERT INTO facilities VALUES(3,'LINE');
INSERT INTO facilities VALUES(4,'LINE');
INSERT INTO facilities VALUES(5,'LINE');
INSERT INTO facilities VALUES(6,'LINE');
INSERT INTO facilities VALUES(7,'LINE');
INSERT INTO facilities VALUES(8,'LINE');
INSERT INTO facilities VALUES(9,'LINE');
INSERT INTO facilities VALUES(10,'LINE');
INSERT INTO facilities VALUES(11,'LINE');
INSERT INTO facilities VALUES(12,'LINE');
INSERT INTO facilities VALUES(13,'LINE');
INSERT INTO facilities VALUES(14,'LINE');
INSERT INTO facilities VALUES(15,'LINE');
INSERT INTO facilities VALUES(16,'LINE');
INSERT INTO facilities VALUES(17,'LINE');
INSERT INTO facilities VALUES(18,'LINE');
INSERT INTO facilities VALUES(19,'LINE');
INSERT INTO facilities VALUES(20,'LINE');
INSERT INTO facilities VALUES(21,'LINE');
INSERT INTO facilities VALUES(22,'LINE');
INSERT INTO facilities VALUES(23,'LINE');
INSERT INTO facilities VALUES(24,'LINE');
INSERT INTO facilities VALUES(25,'LINE');
INSERT INTO facilities VALUES(26,'LINE');
INSERT INTO facilities VALUES(27,'LINE');
INSERT INTO facilities VALUES(28,'LINE');
INSERT INTO facilities VALUES(29,'LINE');
INSERT INTO facilities VALUES(30,'LINE');
INSERT INTO facilities VALUES(31,'LINE');
INSERT INTO facilities VALUES(32,'LINE');
INSERT INTO facilities VALUES(33,'LINE');
INSERT INTO facilities VALUES(34,'LINE');
INSERT INTO facilities VALUES(35,'LINE');
INSERT INTO facilities VALUES(36,'LINE');
INSERT INTO facilities VALUES(37,'LINE');
INSERT INTO facilities VALUES(38,'LINE');
INSERT INTO facilities VALUES(39,'LINE');
INSERT INTO facilities VALUES(40,'LINE');
INSERT INTO facilities VALUES(41,'LINE');
INSERT INTO facilities VALUES(42,'LINE');
INSERT INTO facilities VALUES(43,'LINE');
INSERT INTO facilities VALUES(44,'LINE');
INSERT INTO facilities VALUES(45,'LINE');
INSERT INTO facilities VALUES(46,'LINE');
INSERT INTO facilities VALUES(47,'LINE');
INSERT INTO facilities VALUES(48,'LINE');
INSERT INTO facilities VALUES(49,'LINE');
INSERT INTO facilities VALUES(50,'LINE');
INSERT INTO facilities VALUES(100,'TRUNK');
INSERT INTO facilities VALUES(101,'TRUNK');
INSERT INTO facilities VALUES(102,'TRUNK');
INSERT INTO facilities VALUES(103,'TRUNK');
INSERT INTO facilities VALUES(104,'TRUNK');
INSERT INTO facilities VALUES(105,'TRUNK');
INSERT INTO facilities VALUES(106,'TRUNK');
INSERT INTO facilities VALUES(107,'TRUNK');
INSERT INTO facilities VALUES(500,'TREATMENT');
INSERT INTO facilities VALUES(510,'TREATMENT');
INSERT INTO facilities VALUES(520,'TREATMENT');
CREATE TABLE trunks (
	portid integer NOT NULL primary key,
	foreign_switch varchar(15), --name of switch trunk connects to
	foreign key (portid)  references facilities(portid) on delete cascade
	);
INSERT INTO trunks VALUES(100,'KANATA');
INSERT INTO trunks VALUES(101,'ORLEANS');
INSERT INTO trunks VALUES(102,'RIDEAU');
INSERT INTO trunks VALUES(103,'BASELINE');
INSERT INTO trunks VALUES(104,'SOMERSET');
INSERT INTO trunks VALUES(105,'NEPEAN');
INSERT INTO trunks VALUES(106,'BAY');
INSERT INTO trunks VALUES(107,'Innes');
CREATE TABLE treatments (
	tcode varchar(3), --treatement code
	portid integer NOT NULL primary key,
	treatment_name varchar(20), --name of treatment
	foreign key (portid) references facilities(portid) on delete cascade
	);
INSERT INTO treatments VALUES('BSY',500,'CALLED PARTY BUSY');
INSERT INTO treatments VALUES('CBY',501,'CIRCUITS BUSY');
INSERT INTO treatments VALUES('NSV',510,'NO SERVICE');
INSERT INTO treatments VALUES('INV',520,'INVALID NUMBER');
CREATE TABLE services (
	scode varchar(3) NOT NULL primary key, --service code
	service varchar(25) --name of service
	);
INSERT INTO services VALUES('CWT','Call Waiting');
INSERT INTO services VALUES('CFB','Call Forward Busy');
INSERT INTO services VALUES('3WC','Conference Call');
INSERT INTO services VALUES('MSG','Message Answer');
INSERT INTO services VALUES('DSP','Call Number Display');
CREATE TABLE calls (
	call_id integer NOT NULL primary key,
	orig integer, --originator portid
	term integer, --terminator portid
	och integer,  --originator channel
	tch integer,  --terminator channel
	area varchar(3), --dialed number area code
	office varchar(3), --dialed number offce code
	stn varchar(4), --dialed number station code
	foreign key (orig)  references facilities(portid) on delete cascade,
	foreign key (term)  references facilities(portid) on delete cascade
	);
INSERT INTO calls VALUES(1,1,5,0,0,'613','221','0005');
INSERT INTO calls VALUES(2,2,25,0,0,'613','728','0025');
INSERT INTO calls VALUES(3,18,15,0,0,'613','389','0015');
INSERT INTO calls VALUES(4,6,9,0,0,'613','227','0009');
INSERT INTO calls VALUES(5,22,24,0,0,'613','712','0024');
INSERT INTO calls VALUES(6,8,102,0,2,'416','333','0029');
INSERT INTO calls VALUES(7,15,106,0,5,'416','219','0027');
INSERT INTO calls VALUES(8,21,105,0,7,'705','221','0032');
INSERT INTO calls VALUES(9,4,105,0,20,'905','657','0034');
INSERT INTO calls VALUES(10,18,107,3,18,'905','347','0033');
INSERT INTO calls VALUES(11,13,103,3,11,'819','227','0037');
INSERT INTO calls VALUES(12,105,102,10,13,'416','334','0030');
INSERT INTO calls VALUES(13,106,104,6,9,'613','457','0016');
INSERT INTO calls VALUES(14,102,105,21,23,'705','221','0038');
INSERT INTO calls VALUES(15,103,107,3,5,'905','819','0035');
INSERT INTO calls VALUES(16,107,103,4,6,'819','223','0039');
CREATE TABLE trunk_routes (
	portid integer NOT NULL,area varchar(3) NOT NULL,
	office varchar(3) NOT NULL,
	primary key (portid, area, office),
	foreign key (portid)  references trunks(portid) on delete cascade
	);
INSERT INTO trunk_routes VALUES(100,'613','220');
INSERT INTO trunk_routes VALUES(100,'613','221');
INSERT INTO trunk_routes VALUES(100,'613','222');
INSERT INTO trunk_routes VALUES(100,'613','223');
INSERT INTO trunk_routes VALUES(100,'613','225');
INSERT INTO trunk_routes VALUES(100,'613','227');
INSERT INTO trunk_routes VALUES(101,'613','310');
INSERT INTO trunk_routes VALUES(101,'613','322');
INSERT INTO trunk_routes VALUES(101,'613','333');
INSERT INTO trunk_routes VALUES(101,'613','334');
INSERT INTO trunk_routes VALUES(101,'613','389');
INSERT INTO trunk_routes VALUES(102,'613','000');
INSERT INTO trunk_routes VALUES(102,'416','000');
INSERT INTO trunk_routes VALUES(102,'416','333');
INSERT INTO trunk_routes VALUES(102,'416','334');
INSERT INTO trunk_routes VALUES(102,'416','331');
INSERT INTO trunk_routes VALUES(102,'613','229');
INSERT INTO trunk_routes VALUES(103,'613','134');
INSERT INTO trunk_routes VALUES(103,'613','136');
INSERT INTO trunk_routes VALUES(103,'613','156');
INSERT INTO trunk_routes VALUES(103,'819','227');
INSERT INTO trunk_routes VALUES(103,'819','228');
INSERT INTO trunk_routes VALUES(103,'819','223');
INSERT INTO trunk_routes VALUES(104,'613','457');
INSERT INTO trunk_routes VALUES(104,'613','489');
INSERT INTO trunk_routes VALUES(104,'905','000');
INSERT INTO trunk_routes VALUES(104,'514','000');
INSERT INTO trunk_routes VALUES(104,'514','654');
INSERT INTO trunk_routes VALUES(104,'514','123');
INSERT INTO trunk_routes VALUES(105,'613','568');
INSERT INTO trunk_routes VALUES(105,'613','578');
INSERT INTO trunk_routes VALUES(105,'613','523');
INSERT INTO trunk_routes VALUES(105,'705','000');
INSERT INTO trunk_routes VALUES(105,'705','221');
INSERT INTO trunk_routes VALUES(105,'905','000');
INSERT INTO trunk_routes VALUES(105,'613','657');
INSERT INTO trunk_routes VALUES(105,'613','623');
INSERT INTO trunk_routes VALUES(105,'613','645');
INSERT INTO trunk_routes VALUES(106,'416','219');
INSERT INTO trunk_routes VALUES(106,'416','756');
INSERT INTO trunk_routes VALUES(106,'416','000');
INSERT INTO trunk_routes VALUES(105,'905','657');
INSERT INTO trunk_routes VALUES(107,'905','347');
INSERT INTO trunk_routes VALUES(107,'905','819');
INSERT INTO trunk_routes VALUES(107,'000','000');
INSERT INTO trunk_routes VALUES(107,'613','000');
INSERT INTO trunk_routes VALUES(107,'613','712');
INSERT INTO trunk_routes VALUES(107,'613','728');
INSERT INTO trunk_routes VALUES(107,'613','798');
CREATE TABLE channels (
portid integer NOT NULL,
channel integer NOT NULL,
state char(4) default 'IDLE',
primary key(portid, channel),
foreign key (portid) references facilities(portid) on delete cascade
);
INSERT INTO channels VALUES(100,0,'IDLE');
INSERT INTO channels VALUES(100,1,'IDLE');
INSERT INTO channels VALUES(100,2,'IDLE');
INSERT INTO channels VALUES(100,3,'IDLE');
INSERT INTO channels VALUES(100,4,'IDLE');
INSERT INTO channels VALUES(100,5,'IDLE');
INSERT INTO channels VALUES(100,6,'IDLE');
INSERT INTO channels VALUES(100,7,'IDLE');
INSERT INTO channels VALUES(100,8,'IDLE');
INSERT INTO channels VALUES(100,9,'IDLE');
INSERT INTO channels VALUES(100,10,'IDLE');
INSERT INTO channels VALUES(100,11,'IDLE');
INSERT INTO channels VALUES(100,12,'IDLE');
INSERT INTO channels VALUES(100,13,'IDLE');
INSERT INTO channels VALUES(100,14,'IDLE');
INSERT INTO channels VALUES(100,15,'IDLE');
INSERT INTO channels VALUES(100,16,'IDLE');
INSERT INTO channels VALUES(100,17,'IDLE');
INSERT INTO channels VALUES(100,18,'IDLE');
INSERT INTO channels VALUES(100,19,'IDLE');
INSERT INTO channels VALUES(100,20,'IDLE');
INSERT INTO channels VALUES(100,21,'IDLE');
INSERT INTO channels VALUES(100,22,'IDLE');
INSERT INTO channels VALUES(100,23,'IDLE');
INSERT INTO channels VALUES(101,0,'IDLE');
INSERT INTO channels VALUES(101,1,'IDLE');
INSERT INTO channels VALUES(101,2,'IDLE');
INSERT INTO channels VALUES(101,3,'IDLE');
INSERT INTO channels VALUES(101,4,'IDLE');
INSERT INTO channels VALUES(101,5,'IDLE');
INSERT INTO channels VALUES(101,6,'IDLE');
INSERT INTO channels VALUES(101,7,'IDLE');
INSERT INTO channels VALUES(101,8,'IDLE');
INSERT INTO channels VALUES(101,9,'IDLE');
INSERT INTO channels VALUES(101,10,'IDLE');
INSERT INTO channels VALUES(101,11,'IDLE');
INSERT INTO channels VALUES(101,12,'IDLE');
INSERT INTO channels VALUES(101,13,'IDLE');
INSERT INTO channels VALUES(101,14,'IDLE');
INSERT INTO channels VALUES(101,15,'IDLE');
INSERT INTO channels VALUES(101,16,'IDLE');
INSERT INTO channels VALUES(101,17,'IDLE');
INSERT INTO channels VALUES(101,18,'IDLE');
INSERT INTO channels VALUES(101,19,'IDLE');
INSERT INTO channels VALUES(101,20,'IDLE');
INSERT INTO channels VALUES(101,21,'IDLE');
INSERT INTO channels VALUES(101,22,'IDLE');
INSERT INTO channels VALUES(101,23,'IDLE');
INSERT INTO channels VALUES(102,0,'IDLE');
INSERT INTO channels VALUES(102,1,'IDLE');
INSERT INTO channels VALUES(102,2,'BUSY');
INSERT INTO channels VALUES(102,3,'IDLE');
INSERT INTO channels VALUES(102,4,'IDLE');
INSERT INTO channels VALUES(102,5,'IDLE');
INSERT INTO channels VALUES(102,6,'IDLE');
INSERT INTO channels VALUES(102,7,'IDLE');
INSERT INTO channels VALUES(102,8,'IDLE');
INSERT INTO channels VALUES(102,9,'IDLE');
INSERT INTO channels VALUES(102,10,'IDLE');
INSERT INTO channels VALUES(102,11,'IDLE');
INSERT INTO channels VALUES(102,12,'IDLE');
INSERT INTO channels VALUES(102,13,'BUSY');
INSERT INTO channels VALUES(102,14,'IDLE');
INSERT INTO channels VALUES(102,15,'IDLE');
INSERT INTO channels VALUES(102,16,'IDLE');
INSERT INTO channels VALUES(102,17,'IDLE');
INSERT INTO channels VALUES(102,18,'IDLE');
INSERT INTO channels VALUES(102,19,'IDLE');
INSERT INTO channels VALUES(102,20,'IDLE');
INSERT INTO channels VALUES(102,21,'BUSY');
INSERT INTO channels VALUES(102,22,'IDLE');
INSERT INTO channels VALUES(102,23,'IDLE');
INSERT INTO channels VALUES(103,0,'IDLE');
INSERT INTO channels VALUES(103,1,'IDLE');
INSERT INTO channels VALUES(103,2,'IDLE');
INSERT INTO channels VALUES(103,3,'BUSY');
INSERT INTO channels VALUES(103,4,'BUSY');
INSERT INTO channels VALUES(103,5,'IDLE');
INSERT INTO channels VALUES(103,6,'IDLE');
INSERT INTO channels VALUES(103,7,'IDLE');
INSERT INTO channels VALUES(103,8,'IDLE');
INSERT INTO channels VALUES(103,9,'IDLE');
INSERT INTO channels VALUES(103,10,'IDLE');
INSERT INTO channels VALUES(103,11,'BUSY');
INSERT INTO channels VALUES(103,12,'IDLE');
INSERT INTO channels VALUES(103,13,'IDLE');
INSERT INTO channels VALUES(103,14,'IDLE');
INSERT INTO channels VALUES(103,15,'IDLE');
INSERT INTO channels VALUES(103,16,'IDLE');
INSERT INTO channels VALUES(103,17,'IDLE');
INSERT INTO channels VALUES(103,18,'IDLE');
INSERT INTO channels VALUES(103,19,'IDLE');
INSERT INTO channels VALUES(103,20,'IDLE');
INSERT INTO channels VALUES(103,21,'IDLE');
INSERT INTO channels VALUES(103,22,'IDLE');
INSERT INTO channels VALUES(103,23,'IDLE');
INSERT INTO channels VALUES(104,0,'IDLE');
INSERT INTO channels VALUES(104,1,'IDLE');
INSERT INTO channels VALUES(104,2,'IDLE');
INSERT INTO channels VALUES(104,3,'IDLE');
INSERT INTO channels VALUES(104,4,'IDLE');
INSERT INTO channels VALUES(104,5,'IDLE');
INSERT INTO channels VALUES(104,6,'IDLE');
INSERT INTO channels VALUES(104,7,'IDLE');
INSERT INTO channels VALUES(104,8,'IDLE');
INSERT INTO channels VALUES(104,9,'BUSY');
INSERT INTO channels VALUES(104,10,'IDLE');
INSERT INTO channels VALUES(104,11,'IDLE');
INSERT INTO channels VALUES(104,12,'IDLE');
INSERT INTO channels VALUES(104,13,'IDLE');
INSERT INTO channels VALUES(104,14,'IDLE');
INSERT INTO channels VALUES(104,15,'IDLE');
INSERT INTO channels VALUES(104,16,'IDLE');
INSERT INTO channels VALUES(104,17,'IDLE');
INSERT INTO channels VALUES(104,18,'IDLE');
INSERT INTO channels VALUES(104,19,'IDLE');
INSERT INTO channels VALUES(104,20,'IDLE');
INSERT INTO channels VALUES(104,21,'IDLE');
INSERT INTO channels VALUES(104,22,'IDLE');
INSERT INTO channels VALUES(104,23,'IDLE');
INSERT INTO channels VALUES(105,0,'IDLE');
INSERT INTO channels VALUES(105,1,'IDLE');
INSERT INTO channels VALUES(105,2,'IDLE');
INSERT INTO channels VALUES(105,3,'IDLE');
INSERT INTO channels VALUES(105,4,'IDLE');
INSERT INTO channels VALUES(105,5,'IDLE');
INSERT INTO channels VALUES(105,6,'IDLE');
INSERT INTO channels VALUES(105,7,'BUSY');
INSERT INTO channels VALUES(105,8,'IDLE');
INSERT INTO channels VALUES(105,9,'IDLE');
INSERT INTO channels VALUES(105,10,'BUSY');
INSERT INTO channels VALUES(105,11,'IDLE');
INSERT INTO channels VALUES(105,12,'IDLE');
INSERT INTO channels VALUES(105,13,'IDLE');
INSERT INTO channels VALUES(105,14,'IDLE');
INSERT INTO channels VALUES(105,15,'IDLE');
INSERT INTO channels VALUES(105,16,'IDLE');
INSERT INTO channels VALUES(105,17,'IDLE');
INSERT INTO channels VALUES(105,18,'IDLE');
INSERT INTO channels VALUES(105,19,'IDLE');
INSERT INTO channels VALUES(105,20,'BUSY');
INSERT INTO channels VALUES(105,21,'IDLE');
INSERT INTO channels VALUES(105,22,'IDLE');
INSERT INTO channels VALUES(105,23,'BUSY');
INSERT INTO channels VALUES(106,0,'IDLE');
INSERT INTO channels VALUES(106,1,'IDLE');
INSERT INTO channels VALUES(106,2,'IDLE');
INSERT INTO channels VALUES(106,3,'IDLE');
INSERT INTO channels VALUES(106,4,'IDLE');
INSERT INTO channels VALUES(106,5,'BUSY');
INSERT INTO channels VALUES(106,6,'BUSY');
INSERT INTO channels VALUES(106,7,'IDLE');
INSERT INTO channels VALUES(106,8,'IDLE');
INSERT INTO channels VALUES(106,9,'IDLE');
INSERT INTO channels VALUES(106,10,'IDLE');
INSERT INTO channels VALUES(106,11,'IDLE');
INSERT INTO channels VALUES(106,12,'IDLE');
INSERT INTO channels VALUES(106,13,'IDLE');
INSERT INTO channels VALUES(106,14,'IDLE');
INSERT INTO channels VALUES(106,15,'IDLE');
INSERT INTO channels VALUES(106,16,'IDLE');
INSERT INTO channels VALUES(106,17,'IDLE');
INSERT INTO channels VALUES(106,18,'IDLE');
INSERT INTO channels VALUES(106,19,'IDLE');
INSERT INTO channels VALUES(106,20,'IDLE');
INSERT INTO channels VALUES(106,21,'IDLE');
INSERT INTO channels VALUES(106,22,'IDLE');
INSERT INTO channels VALUES(106,23,'IDLE');
INSERT INTO channels VALUES(107,0,'IDLE');
INSERT INTO channels VALUES(107,1,'IDLE');
INSERT INTO channels VALUES(107,2,'IDLE');
INSERT INTO channels VALUES(107,3,'IDLE');
INSERT INTO channels VALUES(107,4,'BUSY');
INSERT INTO channels VALUES(107,5,'BUSY');
INSERT INTO channels VALUES(107,6,'IDLE');
INSERT INTO channels VALUES(107,7,'IDLE');
INSERT INTO channels VALUES(107,8,'IDLE');
INSERT INTO channels VALUES(107,9,'IDLE');
INSERT INTO channels VALUES(107,10,'IDLE');
INSERT INTO channels VALUES(107,11,'IDLE');
INSERT INTO channels VALUES(107,12,'IDLE');
INSERT INTO channels VALUES(107,13,'IDLE');
INSERT INTO channels VALUES(107,14,'IDLE');
INSERT INTO channels VALUES(107,15,'IDLE');
INSERT INTO channels VALUES(107,16,'IDLE');
INSERT INTO channels VALUES(107,17,'IDLE');
INSERT INTO channels VALUES(107,18,'BUSY');
INSERT INTO channels VALUES(107,19,'IDLE');
INSERT INTO channels VALUES(107,20,'IDLE');
INSERT INTO channels VALUES(107,21,'IDLE');
INSERT INTO channels VALUES(107,22,'IDLE');
INSERT INTO channels VALUES(107,23,'IDLE');
INSERT INTO channels VALUES(1,0,'BUSY');
INSERT INTO channels VALUES(2,0,'BUSY');
INSERT INTO channels VALUES(3,0,'BUSY');
INSERT INTO channels VALUES(4,0,'BUSY');
INSERT INTO channels VALUES(5,0,'BUSY');
INSERT INTO channels VALUES(6,0,'BUSY');
INSERT INTO channels VALUES(7,0,'BUSY');
INSERT INTO channels VALUES(8,0,'BUSY');
INSERT INTO channels VALUES(9,0,'BUSY');
INSERT INTO channels VALUES(10,0,'IDLE');
INSERT INTO channels VALUES(11,0,'BUSY');
INSERT INTO channels VALUES(12,0,'IDLE');
INSERT INTO channels VALUES(13,0,'BUSY');
INSERT INTO channels VALUES(14,0,'BUSY');
INSERT INTO channels VALUES(15,0,'BUSY');
INSERT INTO channels VALUES(16,0,'IDLE');
INSERT INTO channels VALUES(17,0,'BUSY');
INSERT INTO channels VALUES(18,0,'BUSY');
INSERT INTO channels VALUES(19,0,'IDLE');
INSERT INTO channels VALUES(20,0,'IDLE');
INSERT INTO channels VALUES(21,0,'BUSY');
INSERT INTO channels VALUES(22,0,'BUSY');
INSERT INTO channels VALUES(23,0,'BUSY');
INSERT INTO channels VALUES(24,0,'BUSY');
INSERT INTO channels VALUES(25,0,'BUSY');
INSERT INTO channels VALUES(26,0,'IDLE');
INSERT INTO channels VALUES(27,0,'BUSY');
INSERT INTO channels VALUES(28,0,'BUSY');
INSERT INTO channels VALUES(29,0,'IDLE');
INSERT INTO channels VALUES(30,0,'IDLE');
INSERT INTO channels VALUES(31,0,'BUSY');
INSERT INTO channels VALUES(32,0,'IDLE');
INSERT INTO channels VALUES(33,0,'BUSY');
INSERT INTO channels VALUES(34,0,'BUSY');
INSERT INTO channels VALUES(35,0,'BUSY');
INSERT INTO channels VALUES(36,0,'IDLE');
INSERT INTO channels VALUES(37,0,'BUSY');
INSERT INTO channels VALUES(38,0,'BUSY');
INSERT INTO channels VALUES(39,0,'IDLE');
INSERT INTO channels VALUES(40,0,'IDLE');
INSERT INTO channels VALUES(41,0,'BUSY');
INSERT INTO channels VALUES(42,0,'IDLE');
INSERT INTO channels VALUES(43,0,'BUSY');
INSERT INTO channels VALUES(44,0,'BUSY');
INSERT INTO channels VALUES(45,0,'BUSY');
INSERT INTO channels VALUES(46,0,'IDLE');
INSERT INTO channels VALUES(47,0,'BUSY');
INSERT INTO channels VALUES(48,0,'BUSY');
INSERT INTO channels VALUES(49,0,'IDLE');
INSERT INTO channels VALUES(50,0,'IDLE');
CREATE TABLE IF NOT EXISTS "service_subscribers"
(portid integer NOT NULL references facilities(portid),
service varchar(3) NOT NULL references services(scode),
primary key(portid,service));
INSERT INTO service_subscribers VALUES(1,'MSG');
INSERT INTO service_subscribers VALUES(3,'MSG');
INSERT INTO service_subscribers VALUES(5,'MSG');
INSERT INTO service_subscribers VALUES(7,'MSG');
INSERT INTO service_subscribers VALUES(9,'MSG');
INSERT INTO service_subscribers VALUES(11,'MSG');
INSERT INTO service_subscribers VALUES(13,'MSG');
INSERT INTO service_subscribers VALUES(15,'MSG');
INSERT INTO service_subscribers VALUES(17,'MSG');
INSERT INTO service_subscribers VALUES(19,'MSG');
INSERT INTO service_subscribers VALUES(21,'MSG');
INSERT INTO service_subscribers VALUES(23,'MSG');
INSERT INTO service_subscribers VALUES(25,'MSG');
INSERT INTO service_subscribers VALUES(27,'MSG');
INSERT INTO service_subscribers VALUES(29,'MSG');
INSERT INTO service_subscribers VALUES(31,'MSG');
INSERT INTO service_subscribers VALUES(33,'MSG');
INSERT INTO service_subscribers VALUES(35,'MSG');
INSERT INTO service_subscribers VALUES(37,'MSG');
INSERT INTO service_subscribers VALUES(39,'MSG');
INSERT INTO service_subscribers VALUES(41,'MSG');
INSERT INTO service_subscribers VALUES(43,'MSG');
INSERT INTO service_subscribers VALUES(45,'MSG');
INSERT INTO service_subscribers VALUES(47,'MSG');
INSERT INTO service_subscribers VALUES(49,'MSG');
INSERT INTO service_subscribers VALUES(2,'CWT');
INSERT INTO service_subscribers VALUES(4,'CWT');
INSERT INTO service_subscribers VALUES(6,'CWT');
INSERT INTO service_subscribers VALUES(8,'CWT');
INSERT INTO service_subscribers VALUES(10,'CWT');
INSERT INTO service_subscribers VALUES(12,'CWT');
INSERT INTO service_subscribers VALUES(14,'CWT');
INSERT INTO service_subscribers VALUES(16,'CWT');
INSERT INTO service_subscribers VALUES(18,'CWT');
INSERT INTO service_subscribers VALUES(20,'CWT');
INSERT INTO service_subscribers VALUES(32,'CWT');
INSERT INTO service_subscribers VALUES(34,'CWT');
INSERT INTO service_subscribers VALUES(36,'CWT');
INSERT INTO service_subscribers VALUES(38,'CWT');
INSERT INTO service_subscribers VALUES(40,'CWT');
INSERT INTO service_subscribers VALUES(42,'CWT');
INSERT INTO service_subscribers VALUES(44,'CWT');
INSERT INTO service_subscribers VALUES(46,'CWT');
INSERT INTO service_subscribers VALUES(48,'CWT');
INSERT INTO service_subscribers VALUES(50,'CWT');
INSERT INTO service_subscribers VALUES(1,'CFB');
INSERT INTO service_subscribers VALUES(4,'CFB');
INSERT INTO service_subscribers VALUES(7,'CFB');
INSERT INTO service_subscribers VALUES(10,'CFB');
INSERT INTO service_subscribers VALUES(13,'CFB');
INSERT INTO service_subscribers VALUES(16,'CFB');
INSERT INTO service_subscribers VALUES(19,'CFB');
INSERT INTO service_subscribers VALUES(22,'CFB');
INSERT INTO service_subscribers VALUES(25,'CFB');
INSERT INTO service_subscribers VALUES(28,'CFB');
INSERT INTO service_subscribers VALUES(31,'CFB');
INSERT INTO service_subscribers VALUES(34,'CFB');
INSERT INTO service_subscribers VALUES(37,'CFB');
INSERT INTO service_subscribers VALUES(40,'CFB');
INSERT INTO service_subscribers VALUES(43,'CFB');
INSERT INTO service_subscribers VALUES(46,'CFB');
INSERT INTO service_subscribers VALUES(49,'CFB');
INSERT INTO service_subscribers VALUES(3,'DSP');
INSERT INTO service_subscribers VALUES(6,'DSP');
INSERT INTO service_subscribers VALUES(9,'DSP');
INSERT INTO service_subscribers VALUES(12,'DSP');
INSERT INTO service_subscribers VALUES(15,'DSP');
INSERT INTO service_subscribers VALUES(18,'DSP');
INSERT INTO service_subscribers VALUES(21,'DSP');
INSERT INTO service_subscribers VALUES(24,'DSP');
INSERT INTO service_subscribers VALUES(27,'DSP');
INSERT INTO service_subscribers VALUES(30,'DSP');
INSERT INTO service_subscribers VALUES(33,'DSP');
INSERT INTO service_subscribers VALUES(36,'DSP');
INSERT INTO service_subscribers VALUES(39,'DSP');
INSERT INTO service_subscribers VALUES(42,'DSP');
INSERT INTO service_subscribers VALUES(45,'DSP');
INSERT INTO service_subscribers VALUES(48,'DSP');
INSERT INTO service_subscribers VALUES(2,'3WC');
INSERT INTO service_subscribers VALUES(6,'3WC');
INSERT INTO service_subscribers VALUES(10,'3WC');
INSERT INTO service_subscribers VALUES(18,'3WC');
INSERT INTO service_subscribers VALUES(21,'3WC');
INSERT INTO service_subscribers VALUES(28,'3WC');
INSERT INTO service_subscribers VALUES(29,'3WC');
INSERT INTO service_subscribers VALUES(30,'3WC');
INSERT INTO service_subscribers VALUES(33,'3WC');
INSERT INTO service_subscribers VALUES(37,'3WC');
INSERT INTO service_subscribers VALUES(43,'3WC');
INSERT INTO service_subscribers VALUES(48,'3WC');
CREATE TABLE lines (
portid integer NOT NULL primary key,
areacode varchar(3), --subscriber area code
officecode varchar(3), --subscriber office code
stationcode varchar(4), --subscriber station code
foreign key (portid) references facilities(portid) on delete cascade );
INSERT INTO lines VALUES(1,'613','134','0001');
INSERT INTO lines VALUES(2,'613','136','0002');
INSERT INTO lines VALUES(3,'613','156','0003');
INSERT INTO lines VALUES(4,'613','220','0004');
INSERT INTO lines VALUES(5,'613','221','0005');
INSERT INTO lines VALUES(6,'613','222','0006');
INSERT INTO lines VALUES(7,'613','223','0007');
INSERT INTO lines VALUES(8,'613','226','0008');
INSERT INTO lines VALUES(9,'613','227','0009');
INSERT INTO lines VALUES(10,'613','229','0010');
INSERT INTO lines VALUES(11,'613','310','0011');
INSERT INTO lines VALUES(12,'613','322','0012');
INSERT INTO lines VALUES(13,'613','333','0013');
INSERT INTO lines VALUES(14,'613','334','0014');
INSERT INTO lines VALUES(15,'613','389','0015');
INSERT INTO lines VALUES(16,'613','457','0016');
INSERT INTO lines VALUES(17,'613','489','0017');
INSERT INTO lines VALUES(18,'613','523','0018');
INSERT INTO lines VALUES(19,'613','568','0019');
INSERT INTO lines VALUES(20,'613','578','0020');
INSERT INTO lines VALUES(21,'613','623','0021');
INSERT INTO lines VALUES(22,'613','645','0022');
INSERT INTO lines VALUES(23,'613','657','0023');
INSERT INTO lines VALUES(24,'613','712','0024');
INSERT INTO lines VALUES(25,'613','728','0025');
INSERT INTO lines VALUES(26,'613','798','0026');
INSERT INTO lines VALUES(27,'416','219','0027');
INSERT INTO lines VALUES(28,'416','331','0028');
INSERT INTO lines VALUES(29,'416','333','0029');
INSERT INTO lines VALUES(30,'416','334','0030');
INSERT INTO lines VALUES(31,'416','756','0031');
INSERT INTO lines VALUES(32,'705','221','0032');
INSERT INTO lines VALUES(33,'905','347','0033');
INSERT INTO lines VALUES(34,'905','657','0034');
INSERT INTO lines VALUES(35,'905','819','0035');
INSERT INTO lines VALUES(36,'819','223','0036');
INSERT INTO lines VALUES(37,'819','227','0037');
INSERT INTO lines VALUES(38,'705','221','0038');
INSERT INTO lines VALUES(39,'819','223','0039');
INSERT INTO lines VALUES(40,'819','227','0040');
INSERT INTO lines VALUES(41,'905','347','0041');
INSERT INTO lines VALUES(42,'905','657','0042');
INSERT INTO lines VALUES(43,'905','819','0043');
INSERT INTO lines VALUES(44,'416','219','0044');
INSERT INTO lines VALUES(45,'416','331','0045');
INSERT INTO lines VALUES(46,'416','333','0046');
INSERT INTO lines VALUES(47,'416','334','0047');
INSERT INTO lines VALUES(48,'416','756','0048');
INSERT INTO lines VALUES(49,'705','221','0049');
INSERT INTO lines VALUES(50,'819','227','0050');
CREATE TABLE subscribers (
name varchar(30) NOT NULL primary key,
portid integer NOT NULL,
address varchar(50),
foreign key (portid) references facilities (portid) );
INSERT INTO subscribers VALUES('Mats Sundin',1,'45 Elgin St.');
INSERT INTO subscribers VALUES('Jason Allison',2,'46 Elgin St.');
INSERT INTO subscribers VALUES('Eric Lindros',3,'48 Elgin St.');
INSERT INTO subscribers VALUES('Bryan MacCabe',4,'23 MacLeod St.');
INSERT INTO subscribers VALUES('Steve Nash',5,'1129 Otterson Dr.');
INSERT INTO subscribers VALUES('Michael Jordan',6,'1223 Carling Ave.');
INSERT INTO subscribers VALUES('Roger Clemens',7,'14 Hopewell Ave.');
INSERT INTO subscribers VALUES('Jack Morris',8,'23 Prince of Wales Dr.');
INSERT INTO subscribers VALUES('Roberto Alomar',9,'55 Moodie Dr.');
INSERT INTO subscribers VALUES('Joe Carter',10,'18 Summerset East.');
INSERT INTO subscribers VALUES('Wayne Grekzy',11,'45 Merviale.');
INSERT INTO subscribers VALUES('George Bell',12,'46 Colon By Dr.');
INSERT INTO subscribers VALUES('Eric Staal',13,'423 Riverside Drive.');
INSERT INTO subscribers VALUES('Roy Halladay',14,'23 Ogilvie Rd.');
INSERT INTO subscribers VALUES('Mario Lemieux',15,'1129 Bank Dr.');
INSERT INTO subscribers VALUES('Patrick Roy',16,'1223 Greenbank Ave.');
INSERT INTO subscribers VALUES('Martin Brodeur',17,'14 Baseline Ave.');
INSERT INTO subscribers VALUES('Homer Simpson',18,'123 Prince of Wales Dr.');
INSERT INTO subscribers VALUES('Bart Simpson',19,'155 Moodie Dr.');
INSERT INTO subscribers VALUES('Joe Johnson',20,'21 Sussex Dr.');
INSERT INTO subscribers VALUES('Vince Carter',21,'45 Hunt Club St.');
INSERT INTO subscribers VALUES('Ed Belfour',22,'46 Fisher St.');
INSERT INTO subscribers VALUES('Bobby Orr',23,'48 Prince Edward St.');
INSERT INTO subscribers VALUES('Bobby Hull',24,'23 Wellington St.');
INSERT INTO subscribers VALUES('Gordie Howe',25,'1129 Preston Dr.');
INSERT INTO subscribers VALUES('Larry Bird',26,'1223 Warden Ave.');
INSERT INTO subscribers VALUES('Mark Messier',27,'14 Finch Ave.');
INSERT INTO subscribers VALUES('Wade Redden',28,'23 Steeles Ave.');
INSERT INTO subscribers VALUES('Sidney Crosby',29,'55 Sheppard Ave.');
INSERT INTO subscribers VALUES('Peter Forsberg',30,'1 Kennedy Dr.');
INSERT INTO subscribers VALUES('Paul Kariya',31,'45 Midland.');
INSERT INTO subscribers VALUES('Rob Blake',32,'12 19th Ave.');
INSERT INTO subscribers VALUES('Chris Pronger',33,'48 16th Ave.');
INSERT INTO subscribers VALUES('Gary Roberts',34,'23 John St.');
INSERT INTO subscribers VALUES('Alex Mogily',35,'1129 14th Ave.');
INSERT INTO subscribers VALUES('Scott Gomez',36,'1223 Montreal Ave.');
INSERT INTO subscribers VALUES('Frank Thomas',37,'14 Hull Ave.');
INSERT INTO subscribers VALUES('Barry Bonds',38,'23 Hood Rd.');
INSERT INTO subscribers VALUES('Hank Aaron',39,'55 Denison Ave.');
INSERT INTO subscribers VALUES('Babe Ruth',40,'1 Old Kennedy.');
INSERT INTO subscribers VALUES('Ted Williams',41,'45 Birchmount Ave.');
INSERT INTO subscribers VALUES('Chris Bosh',42,'46 Queens Ave.');
INSERT INTO subscribers VALUES('Steve Sampras',43,'448 St Clare Ave.');
INSERT INTO subscribers VALUES('Kobe Bryan',44,'23 Bayview St.');
INSERT INTO subscribers VALUES('Kevin Garnett',45,'59 Mike Myers Dr.');
INSERT INTO subscribers VALUES('Larry Brown',46,'99 Blue Jays Ave.');
INSERT INTO subscribers VALUES('Brooke Shields',47,'69 College Ave.');
INSERT INTO subscribers VALUES('Matt Stajan',48,'50 LakeShore Ave.');
INSERT INTO subscribers VALUES('Tie Domi',49,'89 Spidina Rd.');
INSERT INTO subscribers VALUES('Tevor Kidd',50,'30 McCowan Ave.');
COMMIT;