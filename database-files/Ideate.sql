DROP DATABASE Ideate;
CREATE DATABASE Ideate;
USE Ideate;


CREATE TABLE IF NOT EXISTS General_Member (
    member_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    member_name varchar(50) NOT NULL,
    member_major varchar(50) NOT NULL,
    member_year INTEGER NOT NULL,
    member_email varchar(75) NOT NULL
);

CREATE TABLE IF NOT EXISTS Advisor (
    advisor_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    advisor_name varchar(50) NOT NULL,
    advisor_email varchar(75) NOT NULL
);

CREATE TABLE IF NOT EXISTS Office_Hours (
    session_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    session_startTime DATETIME,
    session_endTime DATETIME,
    advisor_id INTEGER NOT NULL,
    CONSTRAINT FOREIGN KEY (advisor_id) REFERENCES Advisor (advisor_id)
);

CREATE TABLE IF NOT EXISTS Member_Advisor (
    member_id INTEGER NOT NULL,
    advisor_id INTEGER NOT NULL,
    INDEX member_id_member_advisor (member_id),
    INDEX advisor_id_member_advisor (advisor_id),
    PRIMARY KEY(member_id, advisor_id),
    CONSTRAINT FOREIGN KEY (member_id) REFERENCES General_Member (member_id),
    CONSTRAINT FOREIGN KEY (advisor_id) REFERENCES Advisor (advisor_id)
);

CREATE TABLE IF NOT EXISTS Group_Meeting (
    meeting_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    meeting_startTime DATETIME,
    meeting_endTime DATETIME
);

CREATE TABLE IF NOT EXISTS Member_Meeting (
    member_id INTEGER NOT NULL,
    meeting_id INTEGER NOT NULL,
    INDEX member_id_member_meeting (member_id),
    INDEX meeting_id_member_meeting (meeting_id),
    PRIMARY KEY(member_id, meeting_id),
    CONSTRAINT FOREIGN KEY (member_id) REFERENCES General_Member (member_id),
    CONSTRAINT FOREIGN KEY (meeting_id) REFERENCES Group_Meeting (meeting_id)
);


CREATE TABLE IF NOT EXISTS Guest_Speaker (
    speaker_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    speaker_name varchar(50) NOT NULL,
    speaker_phone varchar(20),
    speaker_email varchar(75) NOT NULL,
    advisor_id INTEGER NOT NULL,
    CONSTRAINT FOREIGN KEY (advisor_id) REFERENCES Advisor (advisor_id)
);

CREATE TABLE IF NOT EXISTS Executive_Member (
    exec_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    exec_name varchar(50) NOT NULL,
    exec_email varchar(75) NOT NULL,
    exec_gradYear TINYINT NOT NULL,
    exec_position varchar(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS Event (
    event_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    event_title varchar(50),
    event_startTime DATETIME,
    event_endTime DATETIME,
    num_RSVPS SMALLINT,
    exec_id INTEGER NOT NULL,
    speaker_id INTEGER NOT NULL,
    CONSTRAINT FOREIGN KEY (exec_id) REFERENCES Executive_Member (exec_id),
    CONSTRAINT FOREIGN KEY (speaker_id) REFERENCES Guest_Speaker (speaker_id) ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Member_Event (
    member_id INTEGER NOT NULL,
    event_id INTEGER NOT NULL,
    INDEX member_id_member_event (member_id),
    INDEX event_id_member_event (event_id),
    PRIMARY KEY(member_id, event_id),
    CONSTRAINT FOREIGN KEY (member_id) REFERENCES General_Member (member_id),
    CONSTRAINT FOREIGN KEY (event_id) REFERENCES Event (event_id)
);

CREATE TABLE IF NOT EXISTS Member_Application (
    app_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date_submitted DATETIME,
    app_link varchar(255) NOT NULL,
    exec_id INTEGER NOT NULL,
    CONSTRAINT FOREIGN KEY (exec_id) REFERENCES Executive_Member (exec_id)
);

CREATE TABLE IF NOT EXISTS Client (
    client_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    client_name varchar(50) NOT NULL,
    client_email varchar(75) NOT NULL,
    exec_id INTEGER NOT NULL,
    CONSTRAINT FOREIGN KEY (exec_id) REFERENCES Executive_Member (exec_id)
);

CREATE TABLE IF NOT EXISTS Prospective_Client (
    prospective_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    prospective_name varchar(50) NOT NULL,
    prospective_companyName varchar(50) NOT NULL,
    prospective_email varchar(75) NOT NULL,
    exec_id INTEGER NOT NULL,
    CONSTRAINT FOREIGN KEY (exec_id) REFERENCES Executive_Member (exec_id)
);

CREATE TABLE IF NOT EXISTS Proposal (
    proposal_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    document_link varchar(255) NOT NULL,
    proposal_description varchar(255),
    advisor_id INTEGER NOT NULL,
    prospective_id INTEGER NOT NULL,
    CONSTRAINT FOREIGN KEY (advisor_id) REFERENCES Advisor (advisor_id),
    CONSTRAINT FOREIGN KEY (prospective_id) REFERENCES Prospective_Client(prospective_id)
);

CREATE TABLE IF NOT EXISTS Project (
    project_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    project_description varchar(255) NOT NULL,
    project_startDate DATE,
    project_endDate DATE,
    advisor_id INTEGER NOT NULL,
    client_id INTEGER NOT NULL,
    CONSTRAINT FOREIGN KEY (advisor_id) REFERENCES Advisor (advisor_id),
    CONSTRAINT FOREIGN KEY (client_id) REFERENCES Client (client_id)
);

CREATE TABLE IF NOT EXISTS Member_Project (
    member_id INTEGER NOT NULL,
    project_id INTEGER NOT NULL,
    INDEX member_id_member_project (member_id),
    INDEX project_id_member_project (project_id),
    PRIMARY KEY(member_id, project_id),
    CONSTRAINT FOREIGN KEY (member_id) REFERENCES General_Member (member_id),
    CONSTRAINT FOREIGN KEY (project_id) REFERENCES Project (project_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Ticket (
    ticket_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ticket_status varchar(50) NOT NULL,
    ticket_description varchar(255),
    project_id INTEGER NOT NULL,
    CONSTRAINT FOREIGN KEY (project_id) REFERENCES Project (project_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Status_Update (
    update_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    update_description varchar(255) NOT NULL,
    update_dateTime DATETIME NOT NULL,
    project_id INTEGER NOT NULL,
    member_id INTEGER NOT NULL,
    CONSTRAINT FOREIGN KEY (project_id) REFERENCES Project (project_id) ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (member_id) REFERENCES General_Member (member_id)
);




#--General_Member--

insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (1, 'Elsinore Hurry', 'Computer Science and Math', 3, 'ehurry0@google.com.hk');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (2, 'Lacie Veracruysse', 'Data Science', 1, 'lveracruysse1@bloglines.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (3, 'Davidson Pelchat', 'Cyber Security', 1, 'dpelchat2@phpbb.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (4, 'Sara Charkham', 'Cyber Security', 3, 'scharkham3@npr.org');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (5, 'Nat Badby', 'Computer Science and Business Admin', 1, 'nbadby4@hostgator.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (6, 'Brade Stit', 'Computer Science', 4, 'bstit5@indiatimes.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (7, 'Benny Dowden', 'Cyber Security', 4, 'bdowden6@dailymail.co.uk');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (8, 'Nick Arens', 'Cyber Security', 3, 'narens7@digg.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (9, 'Maren Leeburn', 'Data Science', 3, 'mleeburn8@hubpages.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (10, 'Deborah Matthews', 'Data Science', 1, 'dmatthews9@hugedomains.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (11, 'Darby Wynett', 'Computer Science and Math', 2, 'dwynetta@histats.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (12, 'Adlai Wartnaby', 'Computer Science and Business Admin', 3, 'awartnabyb@meetup.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (13, 'Livvy Exposito', 'Computer Science', 3, 'lexpositoc@vkontakte.ru');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (14, 'Jackquelin Bowcock', 'Computer Science and Math', 4, 'jbowcockd@godaddy.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (15, 'Arnaldo Lardeux', 'Computer Science and Math', 2, 'alardeuxe@engadget.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (16, 'Dario Ablitt', 'Data Science and Business Admin', 4, 'dablittf@webeden.co.uk');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (17, 'Joanna McGonigal', 'Computer Science and Business Admin', 2, 'jmcgonigalg@youku.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (18, 'Moreen Verzey', 'Computer Science and Business Admin', 1, 'mverzeyh@oakley.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (19, 'Alidia Drysdell', 'Cyber Security', 1, 'adrysdelli@cafepress.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (20, 'Marietta Borgesio', 'Computer Science', 2, 'mborgesioj@nsw.gov.au');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (21, 'Leshia Whitta', 'Computer Science and Design', 1, 'lwhittak@jimdo.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (22, 'Aloin Kember', 'Data Science and Business Admin', 4, 'akemberl@ox.ac.uk');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (23, 'Keslie Scraggs', 'Computer Science and Business Admin', 2, 'kscraggsm@google.com.hk');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (24, 'Anatola Roust', 'Computer Science and Math', 3, 'aroustn@globo.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (25, 'Daphna Myhill', 'Data Science and Business Admin', 1, 'dmyhillo@fastcompany.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (26, 'Ignace Yorston', 'Computer Science and Math', 3, 'iyorstonp@php.net');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (27, 'Jarrid Covely', 'Data Science and Business Admin', 2, 'jcovelyq@examiner.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (28, 'Kerwinn Menault', 'Computer Science', 3, 'kmenaultr@latimes.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (29, 'Ernesto Limpenny', 'Computer Science', 4, 'elimpennys@gravatar.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (30, 'Urbanus Mosson', 'Computer Science and Design', 4, 'umossont@bigcartel.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (31, 'Carlina Creagh', 'Computer Science and Math', 3, 'ccreaghu@cnbc.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (32, 'Dyana Rigney', 'Data Science and Business Admin', 3, 'drigneyv@princeton.edu');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (33, 'Birch Wiburn', 'Computer Science and Design', 2, 'bwiburnw@bravesites.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (34, 'Bethany Battany', 'Computer Science and Math', 1, 'bbattanyx@gov.uk');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (35, 'Virgie Driver', 'Computer Science and Business Admin', 4, 'vdrivery@zimbio.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (36, 'Winfred Smaleman', 'Computer Science', 3, 'wsmalemanz@jugem.jp');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (37, 'Lorrin Milmore', 'Data Science', 2, 'lmilmore10@tinyurl.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (38, 'Shermie Bansal', 'Cyber Security', 2, 'sbansal11@chronoengine.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (39, 'Illa Hiley', 'Data Science', 1, 'ihiley12@newsvine.com');
insert into General_Member (member_id, member_name, member_major, member_year, member_email) values (40, 'Finley Paddefield', 'Computer Science and Design', 4, 'fpaddefield13@1und1.de');



#--advisor---

insert into Advisor (advisor_id, advisor_name, advisor_email) values (1, 'Flory Whanstall', 'fwhanstall0@uol.com.br');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (2, 'Brew Franck', 'bfranck1@utexas.edu');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (3, 'Zorah Tomadoni', 'ztomadoni2@zimbio.com');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (4, 'Cris Heisham', 'cheisham3@usda.gov');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (5, 'Bree Karolovsky', 'bkarolovsky4@amazon.com');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (6, 'Maressa Zuker', 'mzuker5@sun.com');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (7, 'Darbee Seabrocke', 'dseabrocke6@thetimes.co.uk');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (8, 'Jerrilee Proughten', 'jproughten7@aboutads.info');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (9, 'Loleta Baldin', 'lbaldin8@blog.com');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (10, 'Douglas Tomasi', 'dtomasi9@gizmodo.com');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (11, 'Winny Oyley', 'woyleya@reddit.com');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (12, 'Hildagard Jumont', 'hjumontb@tuttocitta.it');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (13, 'Manny Guiduzzi', 'mguiduzzic@reddit.com');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (14, 'Alair Coveley', 'acoveleyd@tamu.edu');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (15, 'Christal Barlace', 'cbarlacee@furl.net');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (16, 'Royce Probbing', 'rprobbingf@is.gd');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (17, 'Chalmers Bownes', 'cbownesg@wp.com');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (18, 'Lancelot Dotson', 'ldotsonh@163.com');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (19, 'Koenraad Joskowicz', 'kjoskowiczi@baidu.com');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (20, 'Mitch Moreno', 'mmorenoj@psu.edu');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (21, 'Cirilo Mountlow', 'cmountlowk@umn.edu');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (22, 'Winn Chapier', 'wchapierl@slashdot.org');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (23, 'Iorgos Chitham', 'ichithamm@meetup.com');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (24, 'Kerry Horrell', 'khorrelln@answers.com');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (25, 'Sharlene Rosone', 'srosoneo@indiegogo.com');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (26, 'Harwell Baistow', 'hbaistowp@ihg.com');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (27, 'Jackquelin Ojeda', 'jojedaq@edublogs.org');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (28, 'Zacharie Haresnape', 'zharesnaper@wikipedia.org');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (29, 'Che Gratrex', 'cgratrexs@nba.com');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (30, 'Randolf Houldcroft', 'rhouldcroftt@naver.com');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (31, 'Vachel Leates', 'vleatesu@guardian.co.uk');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (32, 'Claudia Landsborough', 'clandsboroughv@house.gov');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (33, 'Nickola Drews', 'ndrewsw@virginia.edu');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (34, 'Lauren Bester', 'lbesterx@scientificamerican.com');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (35, 'Carley Bothen', 'cbotheny@flickr.com');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (36, 'Adriane Watting', 'awattingz@google.fr');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (37, 'Phaidra Baignard', 'pbaignard10@newsvine.com');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (38, 'Stephani Giraudou', 'sgiraudou11@blog.com');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (39, 'Sofia Rochford', 'srochford12@businessweek.com');
insert into Advisor (advisor_id, advisor_name, advisor_email) values (40, 'Lucius Shapcott', 'lshapcott13@a8.net');


#--Office_Hours-

insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (1, '2024-04-13 15:47:00', '2024-04-13 16:47:00', 31);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (2, '2024-04-17 15:09:00', '2024-04-17 16:09:00', 13);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (3, '2024-04-22 16:53:00', '2024-04-22 17:53:00', 7);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (4, '2024-04-24 15:34:00', '2024-04-24 16:34:00', 28);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (5, '2024-04-28 18:06:00', '2024-04-28 19:06:00', 9);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (6, '2024-04-30 18:24:00', '2024-04-30 19:24:00', 21);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (7, '2024-05-03 15:05:00', '2024-05-03 16:05:00', 36);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (8, '2024-05-07 16:15:00', '2024-05-07 17:15:00', 2);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (9, '2024-05-10 17:20:00', '2024-05-10 18:20:00', 5);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (10, '2024-05-14 18:18:00', '2024-05-14 19:18:00', 30);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (11, '2024-05-17 16:30:00', '2024-05-17 17:30:00', 17);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (12, '2024-05-22 17:50:00', '2024-05-22 18:50:00', 19);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (13, '2024-05-24 16:25:00', '2024-05-24 17:25:00', 11);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (14, '2024-05-28 17:58:00', '2024-05-28 18:58:00', 1);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (15, '2024-05-31 15:40:00', '2024-05-31 16:40:00', 38);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (16, '2024-06-04 15:50:00', '2024-06-04 16:50:00', 23);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (17, '2024-06-08 16:40:00', '2024-06-08 17:40:00', 15);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (18, '2024-06-11 18:31:00', '2024-06-11 19:31:00', 20);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (19, '2024-06-13 17:36:00', '2024-06-13 18:36:00', 8);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (20, '2024-06-17 16:21:00', '2024-06-17 17:21:00', 27);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (21, '2024-06-21 17:07:00', '2024-06-21 18:07:00', 14);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (22, '2024-06-25 18:01:00', '2024-06-25 19:01:00', 4);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (23, '2024-06-28 15:59:00', '2024-06-28 16:59:00', 40);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (24, '2024-07-02 16:32:00', '2024-07-02 17:32:00', 16);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (25, '2024-07-05 17:41:00', '2024-07-05 18:41:00', 34);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (26, '2024-07-09 18:17:00', '2024-07-09 19:17:00', 10);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (27, '2024-07-12 15:36:00', '2024-07-12 16:36:00', 35);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (28, '2024-07-16 16:11:00', '2024-07-16 17:11:00', 3);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (29, '2024-07-19 17:26:00', '2024-07-19 18:26:00', 32);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (30, '2024-07-23 16:43:00', '2024-07-23 17:43:00', 6);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (31, '2024-07-26 18:15:00', '2024-07-26 19:15:00', 12);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (32, '2024-07-30 15:32:00', '2024-07-30 16:32:00', 18);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (33, '2024-08-02 17:00:00', '2024-08-02 18:00:00', 26);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (34, '2024-08-06 16:38:00', '2024-08-06 17:38:00', 39);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (35, '2024-08-09 15:53:00', '2024-08-09 16:53:00', 24);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (36, '2024-08-13 17:03:00', '2024-08-13 18:03:00', 22);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (37, '2024-08-16 18:08:00', '2024-08-16 19:08:00', 25);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (38, '2024-08-20 16:45:00', '2024-08-20 17:45:00', 37);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (39, '2024-08-23 17:16:00', '2024-08-23 18:16:00', 29);
insert into Office_Hours (session_id, session_startTime, session_endTime, advisor_id) values (40, '2024-08-27 18:00:00', '2024-08-27 19:00:00', 33);




#--member_adviosr--

insert into Member_Advisor (member_id, advisor_id) values (17, 16);
insert into Member_Advisor (member_id, advisor_id) values (14, 8);
insert into Member_Advisor (member_id, advisor_id) values (29, 13);
insert into Member_Advisor (member_id, advisor_id) values (10, 10);
insert into Member_Advisor (member_id, advisor_id) values (17, 34);
insert into Member_Advisor (member_id, advisor_id) values (8, 27);
insert into Member_Advisor (member_id, advisor_id) values (14, 15);
insert into Member_Advisor (member_id, advisor_id) values (4, 32);
insert into Member_Advisor (member_id, advisor_id) values (39, 38);
insert into Member_Advisor (member_id, advisor_id) values (1, 18);
insert into Member_Advisor (member_id, advisor_id) values (2, 10);
insert into Member_Advisor (member_id, advisor_id) values (29, 3);
insert into Member_Advisor (member_id, advisor_id) values (33, 10);
insert into Member_Advisor (member_id, advisor_id) values (19, 25);
insert into Member_Advisor (member_id, advisor_id) values (37, 19);
insert into Member_Advisor (member_id, advisor_id) values (12, 5);
insert into Member_Advisor (member_id, advisor_id) values (12, 2);
insert into Member_Advisor (member_id, advisor_id) values (39, 28);
insert into Member_Advisor (member_id, advisor_id) values (9, 34);
insert into Member_Advisor (member_id, advisor_id) values (15, 2);
insert into Member_Advisor (member_id, advisor_id) values (26, 26);
insert into Member_Advisor (member_id, advisor_id) values (5, 31);
insert into Member_Advisor (member_id, advisor_id) values (14, 36);
insert into Member_Advisor (member_id, advisor_id) values (27, 9);
insert into Member_Advisor (member_id, advisor_id) values (5, 12);
insert into Member_Advisor (member_id, advisor_id) values (23, 34);
insert into Member_Advisor (member_id, advisor_id) values (37, 28);
insert into Member_Advisor (member_id, advisor_id) values (27, 20);
insert into Member_Advisor (member_id, advisor_id) values (5, 14);
insert into Member_Advisor (member_id, advisor_id) values (6, 27);
insert into Member_Advisor (member_id, advisor_id) values (36, 38);
insert into Member_Advisor (member_id, advisor_id) values (21, 1);
insert into Member_Advisor (member_id, advisor_id) values (12, 14);
insert into Member_Advisor (member_id, advisor_id) values (34, 35);
insert into Member_Advisor (member_id, advisor_id) values (8, 39);
insert into Member_Advisor (member_id, advisor_id) values (36, 14);
insert into Member_Advisor (member_id, advisor_id) values (21, 39);
insert into Member_Advisor (member_id, advisor_id) values (13, 18);
insert into Member_Advisor (member_id, advisor_id) values (1, 13);
insert into Member_Advisor (member_id, advisor_id) values (16, 36);
insert into Member_Advisor (member_id, advisor_id) values (36, 25);
insert into Member_Advisor (member_id, advisor_id) values (12, 4);
insert into Member_Advisor (member_id, advisor_id) values (22, 24);
insert into Member_Advisor (member_id, advisor_id) values (17, 18);
insert into Member_Advisor (member_id, advisor_id) values (24, 15);
insert into Member_Advisor (member_id, advisor_id) values (16, 37);
insert into Member_Advisor (member_id, advisor_id) values (2, 22);
insert into Member_Advisor (member_id, advisor_id) values (25, 22);
insert into Member_Advisor (member_id, advisor_id) values (37, 21);
insert into Member_Advisor (member_id, advisor_id) values (29, 37);
insert into Member_Advisor (member_id, advisor_id) values (12, 22);
insert into Member_Advisor (member_id, advisor_id) values (19, 32);
insert into Member_Advisor (member_id, advisor_id) values (9, 27);
insert into Member_Advisor (member_id, advisor_id) values (33, 38);
insert into Member_Advisor (member_id, advisor_id) values (20, 2);
insert into Member_Advisor (member_id, advisor_id) values (5, 10);
insert into Member_Advisor (member_id, advisor_id) values (21, 31);
insert into Member_Advisor (member_id, advisor_id) values (2, 5);
insert into Member_Advisor (member_id, advisor_id) values (28, 40);
insert into Member_Advisor (member_id, advisor_id) values (7, 23);
insert into Member_Advisor (member_id, advisor_id) values (31, 11);
insert into Member_Advisor (member_id, advisor_id) values (15, 29);
insert into Member_Advisor (member_id, advisor_id) values (21, 27);
insert into Member_Advisor (member_id, advisor_id) values (33, 35);
insert into Member_Advisor (member_id, advisor_id) values (25, 12);
insert into Member_Advisor (member_id, advisor_id) values (22, 1);
insert into Member_Advisor (member_id, advisor_id) values (20, 5);
insert into Member_Advisor (member_id, advisor_id) values (11, 18);
insert into Member_Advisor (member_id, advisor_id) values (37, 9);
insert into Member_Advisor (member_id, advisor_id) values (2, 17);
insert into Member_Advisor (member_id, advisor_id) values (34, 15);
insert into Member_Advisor (member_id, advisor_id) values (13, 33);
insert into Member_Advisor (member_id, advisor_id) values (14, 20);
insert into Member_Advisor (member_id, advisor_id) values (17, 38);
insert into Member_Advisor (member_id, advisor_id) values (24, 23);
insert into Member_Advisor (member_id, advisor_id) values (28, 8);
insert into Member_Advisor (member_id, advisor_id) values (4, 40);
insert into Member_Advisor (member_id, advisor_id) values (3, 35);
insert into Member_Advisor (member_id, advisor_id) values (38, 39);
insert into Member_Advisor (member_id, advisor_id) values (6, 4);
insert into Member_Advisor (member_id, advisor_id) values (30, 24);
insert into Member_Advisor (member_id, advisor_id) values (16, 29);
insert into Member_Advisor (member_id, advisor_id) values (16, 28);
insert into Member_Advisor (member_id, advisor_id) values (40, 40);
insert into Member_Advisor (member_id, advisor_id) values (5, 13);
insert into Member_Advisor (member_id, advisor_id) values (11, 22);
insert into Member_Advisor (member_id, advisor_id) values (12, 7);
insert into Member_Advisor (member_id, advisor_id) values (10, 25);
insert into Member_Advisor (member_id, advisor_id) values (2, 26);
insert into Member_Advisor (member_id, advisor_id) values (40, 24);
insert into Member_Advisor (member_id, advisor_id) values (29, 33);
insert into Member_Advisor (member_id, advisor_id) values (13, 4);
insert into Member_Advisor (member_id, advisor_id) values (35, 27);
insert into Member_Advisor (member_id, advisor_id) values (32, 29);
insert into Member_Advisor (member_id, advisor_id) values (22, 10);
insert into Member_Advisor (member_id, advisor_id) values (12, 31);
insert into Member_Advisor (member_id, advisor_id) values (2, 20);
insert into Member_Advisor (member_id, advisor_id) values (4, 19);
insert into Member_Advisor (member_id, advisor_id) values (2, 15);
insert into Member_Advisor (member_id, advisor_id) values (38, 9);
insert into Member_Advisor (member_id, advisor_id) values (7, 3);
insert into Member_Advisor (member_id, advisor_id) values (3, 33);
insert into Member_Advisor (member_id, advisor_id) values (23, 7);
insert into Member_Advisor (member_id, advisor_id) values (33, 15);
insert into Member_Advisor (member_id, advisor_id) values (10, 19);
insert into Member_Advisor (member_id, advisor_id) values (15, 28);
insert into Member_Advisor (member_id, advisor_id) values (16, 34);
insert into Member_Advisor (member_id, advisor_id) values (9, 30);
insert into Member_Advisor (member_id, advisor_id) values (13, 16);
insert into Member_Advisor (member_id, advisor_id) values (11, 32);
insert into Member_Advisor (member_id, advisor_id) values (39, 5);
insert into Member_Advisor (member_id, advisor_id) values (29, 15);
insert into Member_Advisor (member_id, advisor_id) values (6, 14);
insert into Member_Advisor (member_id, advisor_id) values (5, 4);
insert into Member_Advisor (member_id, advisor_id) values (4, 33);
insert into Member_Advisor (member_id, advisor_id) values (15, 7);
insert into Member_Advisor (member_id, advisor_id) values (40, 38);
insert into Member_Advisor (member_id, advisor_id) values (20, 25);
insert into Member_Advisor (member_id, advisor_id) values (15, 36);
insert into Member_Advisor (member_id, advisor_id) values (3, 31);
insert into Member_Advisor (member_id, advisor_id) values (33, 1);
insert into Member_Advisor (member_id, advisor_id) values (25, 24);
insert into Member_Advisor (member_id, advisor_id) values (3, 5);
insert into Member_Advisor (member_id, advisor_id) values (3, 21);
insert into Member_Advisor (member_id, advisor_id) values (36, 35);
insert into Member_Advisor (member_id, advisor_id) values (40, 34);
insert into Member_Advisor (member_id, advisor_id) values (10, 27);
insert into Member_Advisor (member_id, advisor_id) values (11, 29);
insert into Member_Advisor (member_id, advisor_id) values (18, 6);
insert into Member_Advisor (member_id, advisor_id) values (1, 37);


#--Group_Meeting--

insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-04-10 19:00:00', '2024-04-10 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-04-12 19:00:00', '2024-04-12 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-04-15 19:00:00', '2024-04-15 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-04-17 19:00:00', '2024-04-17 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-04-19 19:00:00', '2024-04-19 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-04-22 19:00:00', '2024-04-22 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-04-24 19:00:00', '2024-04-24 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-04-26 19:00:00', '2024-04-26 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-04-29 19:00:00', '2024-04-29 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-05-01 19:00:00', '2024-05-01 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-05-03 19:00:00', '2024-05-03 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-05-06 19:00:00', '2024-05-06 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-05-08 19:00:00', '2024-05-08 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-05-10 19:00:00', '2024-05-10 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-05-13 19:00:00', '2024-05-13 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-05-15 19:00:00', '2024-05-15 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-05-17 19:00:00', '2024-05-17 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-05-20 19:00:00', '2024-05-20 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-05-22 19:00:00', '2024-05-22 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-05-24 19:00:00', '2024-05-24 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-05-27 19:00:00', '2024-05-27 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-05-29 19:00:00', '2024-05-29 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-05-31 19:00:00', '2024-05-31 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-06-03 19:00:00', '2024-06-03 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-06-05 19:00:00', '2024-06-05 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-06-07 19:00:00', '2024-06-07 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-06-10 19:00:00', '2024-06-10 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-06-12 19:00:00', '2024-06-12 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-06-14 19:00:00', '2024-06-14 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-06-17 19:00:00', '2024-06-17 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-06-19 19:00:00', '2024-06-19 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-06-21 19:00:00', '2024-06-21 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-06-24 19:00:00', '2024-06-24 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-06-26 19:00:00', '2024-06-26 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-06-28 19:00:00', '2024-06-28 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-07-01 19:00:00', '2024-07-01 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-07-03 19:00:00', '2024-07-03 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-07-05 19:00:00', '2024-07-05 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-07-08 19:00:00', '2024-07-08 20:00:00');
insert into Group_Meeting (meeting_startTime, meeting_endTime) values ('2024-07-10 19:00:00', '2024-07-10 20:00:00');



#--member_meeting--


insert into Member_Meeting (member_id, meeting_id) values (9, 36);
insert into Member_Meeting (member_id, meeting_id) values (32, 6);
insert into Member_Meeting (member_id, meeting_id) values (26, 8);
insert into Member_Meeting (member_id, meeting_id) values (35, 14);
insert into Member_Meeting (member_id, meeting_id) values (11, 8);
insert into Member_Meeting (member_id, meeting_id) values (20, 11);
insert into Member_Meeting (member_id, meeting_id) values (10, 15);
insert into Member_Meeting (member_id, meeting_id) values (8, 38);
insert into Member_Meeting (member_id, meeting_id) values (4, 14);
insert into Member_Meeting (member_id, meeting_id) values (11, 23);
insert into Member_Meeting (member_id, meeting_id) values (33, 4);
insert into Member_Meeting (member_id, meeting_id) values (5, 14);
insert into Member_Meeting (member_id, meeting_id) values (10, 37);
insert into Member_Meeting (member_id, meeting_id) values (36, 1);
insert into Member_Meeting (member_id, meeting_id) values (28, 18);
insert into Member_Meeting (member_id, meeting_id) values (5, 13);
insert into Member_Meeting (member_id, meeting_id) values (20, 13);
insert into Member_Meeting (member_id, meeting_id) values (13, 15);
insert into Member_Meeting (member_id, meeting_id) values (11, 13);
insert into Member_Meeting (member_id, meeting_id) values (8, 2);
insert into Member_Meeting (member_id, meeting_id) values (3, 35);
insert into Member_Meeting (member_id, meeting_id) values (32, 1);
insert into Member_Meeting (member_id, meeting_id) values (8, 9);
insert into Member_Meeting (member_id, meeting_id) values (26, 27);
insert into Member_Meeting (member_id, meeting_id) values (25, 33);
insert into Member_Meeting (member_id, meeting_id) values (18, 34);
insert into Member_Meeting (member_id, meeting_id) values (30, 38);
insert into Member_Meeting (member_id, meeting_id) values (16, 34);
insert into Member_Meeting (member_id, meeting_id) values (12, 32);
insert into Member_Meeting (member_id, meeting_id) values (20, 33);
insert into Member_Meeting (member_id, meeting_id) values (22, 5);
insert into Member_Meeting (member_id, meeting_id) values (7, 6);
insert into Member_Meeting (member_id, meeting_id) values (40, 18);
insert into Member_Meeting (member_id, meeting_id) values (33, 6);
insert into Member_Meeting (member_id, meeting_id) values (18, 9);
insert into Member_Meeting (member_id, meeting_id) values (26, 36);
insert into Member_Meeting (member_id, meeting_id) values (8, 11);
insert into Member_Meeting (member_id, meeting_id) values (21, 32);
insert into Member_Meeting (member_id, meeting_id) values (11, 35);
insert into Member_Meeting (member_id, meeting_id) values (29, 8);
insert into Member_Meeting (member_id, meeting_id) values (34, 21);
insert into Member_Meeting (member_id, meeting_id) values (6, 39);
insert into Member_Meeting (member_id, meeting_id) values (25, 17);
insert into Member_Meeting (member_id, meeting_id) values (19, 38);
insert into Member_Meeting (member_id, meeting_id) values (19, 34);
insert into Member_Meeting (member_id, meeting_id) values (2, 30);
insert into Member_Meeting (member_id, meeting_id) values (19, 12);
insert into Member_Meeting (member_id, meeting_id) values (21, 25);
insert into Member_Meeting (member_id, meeting_id) values (11, 19);
insert into Member_Meeting (member_id, meeting_id) values (24, 5);
insert into Member_Meeting (member_id, meeting_id) values (32, 8);
insert into Member_Meeting (member_id, meeting_id) values (19, 30);
insert into Member_Meeting (member_id, meeting_id) values (16, 27);
insert into Member_Meeting (member_id, meeting_id) values (23, 21);
insert into Member_Meeting (member_id, meeting_id) values (21, 38);
insert into Member_Meeting (member_id, meeting_id) values (5, 17);
insert into Member_Meeting (member_id, meeting_id) values (37, 39);
insert into Member_Meeting (member_id, meeting_id) values (25, 34);
insert into Member_Meeting (member_id, meeting_id) values (30, 25);
insert into Member_Meeting (member_id, meeting_id) values (3, 3);
insert into Member_Meeting (member_id, meeting_id) values (15, 26);
insert into Member_Meeting (member_id, meeting_id) values (29, 29);
insert into Member_Meeting (member_id, meeting_id) values (15, 12);
insert into Member_Meeting (member_id, meeting_id) values (39, 2);
insert into Member_Meeting (member_id, meeting_id) values (6, 10);
insert into Member_Meeting (member_id, meeting_id) values (16, 9);
insert into Member_Meeting (member_id, meeting_id) values (9, 26);
insert into Member_Meeting (member_id, meeting_id) values (20, 26);
insert into Member_Meeting (member_id, meeting_id) values (2, 32);
insert into Member_Meeting (member_id, meeting_id) values (8, 30);
insert into Member_Meeting (member_id, meeting_id) values (26, 16);
insert into Member_Meeting (member_id, meeting_id) values (4, 19);
insert into Member_Meeting (member_id, meeting_id) values (18, 7);
insert into Member_Meeting (member_id, meeting_id) values (36, 2);
insert into Member_Meeting (member_id, meeting_id) values (12, 33);
insert into Member_Meeting (member_id, meeting_id) values (36, 20);
insert into Member_Meeting (member_id, meeting_id) values (27, 32);
insert into Member_Meeting (member_id, meeting_id) values (16, 24);
insert into Member_Meeting (member_id, meeting_id) values (40, 31);
insert into Member_Meeting (member_id, meeting_id) values (36, 33);
insert into Member_Meeting (member_id, meeting_id) values (8, 21);
insert into Member_Meeting (member_id, meeting_id) values (34, 33);
insert into Member_Meeting (member_id, meeting_id) values (13, 27);
insert into Member_Meeting (member_id, meeting_id) values (12, 23);
insert into Member_Meeting (member_id, meeting_id) values (31, 34);
insert into Member_Meeting (member_id, meeting_id) values (33, 13);
insert into Member_Meeting (member_id, meeting_id) values (3, 27);
insert into Member_Meeting (member_id, meeting_id) values (14, 14);
insert into Member_Meeting (member_id, meeting_id) values (23, 30);
insert into Member_Meeting (member_id, meeting_id) values (40, 23);
insert into Member_Meeting (member_id, meeting_id) values (11, 32);
insert into Member_Meeting (member_id, meeting_id) values (17, 38);
insert into Member_Meeting (member_id, meeting_id) values (19, 29);
insert into Member_Meeting (member_id, meeting_id) values (6, 16);
insert into Member_Meeting (member_id, meeting_id) values (23, 14);
insert into Member_Meeting (member_id, meeting_id) values (6, 28);
insert into Member_Meeting (member_id, meeting_id) values (6, 31);
insert into Member_Meeting (member_id, meeting_id) values (3, 29);
insert into Member_Meeting (member_id, meeting_id) values (17, 9);
insert into Member_Meeting (member_id, meeting_id) values (38, 40);
insert into Member_Meeting (member_id, meeting_id) values (30, 13);
insert into Member_Meeting (member_id, meeting_id) values (19, 7);
insert into Member_Meeting (member_id, meeting_id) values (33, 35);
insert into Member_Meeting (member_id, meeting_id) values (3, 11);
insert into Member_Meeting (member_id, meeting_id) values (15, 11);
insert into Member_Meeting (member_id, meeting_id) values (37, 8);
insert into Member_Meeting (member_id, meeting_id) values (7, 25);
insert into Member_Meeting (member_id, meeting_id) values (27, 18);
insert into Member_Meeting (member_id, meeting_id) values (8, 34);
insert into Member_Meeting (member_id, meeting_id) values (29, 37);
insert into Member_Meeting (member_id, meeting_id) values (16, 35);
insert into Member_Meeting (member_id, meeting_id) values (16, 16);
insert into Member_Meeting (member_id, meeting_id) values (2, 18);
insert into Member_Meeting (member_id, meeting_id) values (12, 12);
insert into Member_Meeting (member_id, meeting_id) values (8, 19);
insert into Member_Meeting (member_id, meeting_id) values (23, 15);
insert into Member_Meeting (member_id, meeting_id) values (16, 2);
insert into Member_Meeting (member_id, meeting_id) values (23, 1);
insert into Member_Meeting (member_id, meeting_id) values (7, 13);
insert into Member_Meeting (member_id, meeting_id) values (7, 14);
insert into Member_Meeting (member_id, meeting_id) values (5, 36);
insert into Member_Meeting (member_id, meeting_id) values (3, 14);
insert into Member_Meeting (member_id, meeting_id) values (35, 15);
insert into Member_Meeting (member_id, meeting_id) values (29, 34);
insert into Member_Meeting (member_id, meeting_id) values (27, 13);
insert into Member_Meeting (member_id, meeting_id) values (22, 2);
insert into Member_Meeting (member_id, meeting_id) values (21, 28);
insert into Member_Meeting (member_id, meeting_id) values (5, 8);
insert into Member_Meeting (member_id, meeting_id) values (17, 31);
insert into Member_Meeting (member_id, meeting_id) values (31, 14);


#--Guest Speaker --

insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (1, 'Katlin Sandiland', '(576) 7266045', 'ksandiland0@go.com', 13);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (2, 'Krista Phelan', '(608) 8503527', 'kphelan1@github.com', 37);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (3, 'Ev Belderson', '(921) 2039898', 'ebelderson2@wikipedia.org', 27);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (4, 'Tito Cronin', '(124) 6609948', 'tcronin3@google.de', 17);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (5, 'Revkah Kilfether', '(354) 4326786', 'rkilfether4@jimdo.com', 16);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (6, 'Antonia Habercham', '(207) 5566612', 'ahabercham5@mtv.com', 17);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (7, 'Silvio Shuard', '(207) 3751965', 'sshuard6@squarespace.com', 7);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (8, 'Vitoria Snalham', '(734) 2714686', 'vsnalham7@nationalgeographic.com', 28);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (9, 'Alta Paradise', '(973) 2839390', 'aparadise8@census.gov', 31);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (10, 'Avram Yeldon', '(669) 8223368', 'ayeldon9@paypal.com', 34);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (11, 'Husain Skillern', '(820) 9786733', 'hskillerna@ehow.com', 4);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (12, 'Jon Vayne', '(715) 9313917', 'jvayneb@hao123.com', 27);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (13, 'Adriaens Trass', '(801) 3215798', 'atrassc@photobucket.com', 17);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (14, 'Blakelee Agneau', '(735) 8727759', 'bagneaud@boston.com', 23);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (15, 'Darcey Piletic', '(204) 8199376', 'dpiletice@ebay.com', 24);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (16, 'Faye Pflieger', '(211) 6544651', 'fpfliegerf@hugedomains.com', 18);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (17, 'Sigismondo Geram', '(598) 5075844', 'sgeramg@cdc.gov', 20);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (18, 'Wat Spadotto', '(872) 1552189', 'wspadottoh@walmart.com', 40);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (19, 'Stacee Goosey', '(488) 4401133', 'sgooseyi@goo.gl', 19);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (20, 'Caron Mockford', '(771) 7893082', 'cmockfordj@twitter.com', 3);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (21, 'Dorolisa Clemett', '(972) 3589112', 'dclemettk@economist.com', 18);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (22, 'Bernadene Lurriman', '(337) 8666318', 'blurrimanl@com.com', 6);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (23, 'Allsun De Wolfe', '(517) 9748616', 'adem@upenn.edu', 26);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (24, 'Evered Denidge', '(957) 5567173', 'edenidgen@odnoklassniki.ru', 33);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (25, 'Stevy Brill', '(799) 1728619', 'sbrillo@irs.gov', 24);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (26, 'Baldwin Toghill', '(224) 8284922', 'btoghillp@virginia.edu', 25);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (27, 'Kenyon Kennaird', '(212) 4423062', 'kkennairdq@wordpress.com', 30);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (28, 'Frederick Tetther', '(893) 3182816', 'ftettherr@microsoft.com', 20);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (29, 'Gabbi Cheater', '(900) 2475817', 'gcheaters@canalblog.com', 26);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (30, 'Novelia Brampton', '(325) 2241559', 'nbramptont@360.cn', 14);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (31, 'Vasili Bricknall', '(941) 2167132', 'vbricknallu@istockphoto.com', 23);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (32, 'Corbett Morrice', '(963) 4664784', 'cmorricev@wunderground.com', 1);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (33, 'Rory Elce', '(874) 2626902', 'relcew@goodreads.com', 2);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (34, 'Darb Cortese', '(248) 1514634', 'dcortesex@mozilla.com', 23);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (35, 'Roby Lumly', '(648) 4266643', 'rlumlyy@cdbaby.com', 31);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (36, 'Dru Hallede', '(473) 3711497', 'dhalledez@uol.com.br', 30);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (37, 'Cherilynn Flooks', '(128) 4727643', 'cflooks10@marriott.com', 17);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (38, 'Margaretha De Launde', '(213) 7645125', 'mde11@ox.ac.uk', 32);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (39, 'Marga Collum', '(860) 6486471', 'mcollum12@studiopress.com', 39);
insert into Guest_Speaker (speaker_id, speaker_name, speaker_phone, speaker_email, advisor_id) values (40, 'Bartlett Baile', '(449) 2064840', 'bbaile13@people.com.cn', 40);


#--executive_member--

insert into Executive_Member (exec_id, exec_name, exec_email, exec_gradYear, exec_position) values (1, 'Rubin Petranek', 'rpetranek0@about.com', 4, 'President');
insert into Executive_Member (exec_id, exec_name, exec_email, exec_gradYear, exec_position) values (2, 'Ardine Pandey', 'apandey1@i2i.jp', 4, 'Vice President');
insert into Executive_Member (exec_id, exec_name, exec_email, exec_gradYear, exec_position) values (3, 'Angelique Boakes', 'aboakes2@addtoany.com', 4, 'Secretry');
insert into Executive_Member (exec_id, exec_name, exec_email, exec_gradYear, exec_position) values (4, 'Livvyy Devoy', 'ldevoy3@cbslocal.com', 4, 'Treasurer');
insert into Executive_Member (exec_id, exec_name, exec_email, exec_gradYear, exec_position) values (5, 'Sherwynd Hartgill', 'shartgill4@bloglines.com', 2, 'Exec Member');
insert into Executive_Member (exec_id, exec_name, exec_email, exec_gradYear, exec_position) values (6, 'Alexa Poynzer', 'apoynzer5@kickstarter.com', 3, 'Exec Member');
insert into Executive_Member (exec_id, exec_name, exec_email, exec_gradYear, exec_position) values (7, 'Robert Wellman', 'rwellman6@macromedia.com', 3, 'Exec Member');
insert into Executive_Member (exec_id, exec_name, exec_email, exec_gradYear, exec_position) values (8, 'Zachary Joseland', 'zjoseland7@mashable.com', 2, 'Exec Member');
insert into Executive_Member (exec_id, exec_name, exec_email, exec_gradYear, exec_position) values (9, 'Nicky Hardistry', 'nhardistry8@umn.edu', 2, 'Exec Member');
insert into Executive_Member (exec_id, exec_name, exec_email, exec_gradYear, exec_position) values (10, 'Darryl Pellington', 'dpellington9@networkadvertising.org', 2, 'Exec Member');


#--event--

insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (1, 'Collaborative Bootcamp - Backend APIs', '2024-04-10 16:00:00', '2024-04-10 17:30:00', 32, 1, 1);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (2, 'Advanced Workshop - Cloud Computing', '2024-04-17 16:00:00', '2024-04-17 17:30:00', 37, 2, 2);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (3, 'Hands-on Bootcamp - Mobile App Design', '2024-04-24 16:00:00', '2024-04-24 17:30:00', 22, 3, 3);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (4, 'Creative Workshop - Cybersecurity', '2024-05-01 16:00:00', '2024-05-01 17:30:00', 31, 5, 4);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (5, 'Professional Bootcamp - Backend APIs', '2024-05-08 16:00:00', '2024-05-08 17:30:00', 29, 1, 5);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (6, 'Hands-on Bootcamp - Data Science', '2024-05-15 16:00:00', '2024-05-15 17:30:00', 38, 4, 6);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (7, 'Professional Bootcamp - Database Management', '2024-05-22 16:00:00', '2024-05-22 17:30:00', 36, 6, 7);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (8, 'Creative Bootcamp - Mobile App Design', '2024-05-29 16:00:00', '2024-05-29 17:30:00', 21, 7, 8);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (9, 'Practical Workshop - Client Project Management', '2024-06-05 16:00:00', '2024-06-05 17:30:00', 22, 8, 9);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (10, 'Essential Bootcamp - Data Science', '2024-06-12 16:00:00', '2024-06-12 17:30:00', 39, 3, 10);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (11, 'Hands-on Workshop - Backend APIs', '2024-06-19 16:00:00', '2024-06-19 17:30:00', 26, 6, 11);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (12, 'Creative Bootcamp - Frontend Development', '2024-06-26 16:00:00', '2024-06-26 17:30:00', 26, 3, 12);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (13, 'Collaborative Bootcamp - Database Management', '2024-07-03 16:00:00', '2024-07-03 17:30:00', 40, 6, 13);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (14, 'Hands-on Workshop - Frontend Development', '2024-07-10 16:00:00', '2024-07-10 17:30:00', 31, 4, 14);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (15, 'Professional Bootcamp - Client Communication', '2024-07-17 16:00:00', '2024-07-17 17:30:00', 40, 1, 15);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (16, 'Collaborative Bootcamp - Cybersecurity', '2024-07-24 16:00:00', '2024-07-24 17:30:00', 28, 1, 16);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (17, 'Creative Bootcamp - Building Client Relationships', '2024-07-31 16:00:00', '2024-07-31 17:30:00', 30, 7, 17);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (18, 'Professional Workshop - Mobile App Design', '2024-08-07 16:00:00', '2024-08-07 17:30:00', 26, 2, 18);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (19, 'Hands-on Bootcamp - Cloud Computing', '2024-08-14 16:00:00', '2024-08-14 17:30:00', 37, 9, 19);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (20, 'Creative Bootcamp - Data Science', '2024-08-21 16:00:00', '2024-08-21 17:30:00', 29, 3, 20);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (21, 'Essential Bootcamp - Client Project Management', '2024-08-28 16:00:00', '2024-08-28 17:30:00', 33, 2, 21);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (22, 'Professional Bootcamp - Consulting Basics', '2024-09-04 16:00:00', '2024-09-04 17:30:00', 37, 7, 22);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (23, 'Collaborative Workshop - Client Communication', '2024-09-11 16:00:00', '2024-09-11 17:30:00', 23, 5, 23);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (24, 'Creative Workshop - Backend APIs', '2024-09-18 16:00:00', '2024-09-18 17:30:00', 31, 2, 24);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (25, 'Professional Bootcamp - Frontend Development', '2024-09-25 16:00:00', '2024-09-25 17:30:00', 32, 3, 25);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (26, 'Collaborative Workshop - Cloud Computing', '2024-10-02 16:00:00', '2024-10-02 17:30:00', 36, 1, 26);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (27, 'Hands-on Bootcamp - Building Client Relationships', '2024-10-09 16:00:00', '2024-10-09 17:30:00', 30, 3, 27);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (28, 'Essential Workshop - Consulting Basics', '2024-10-16 16:00:00', '2024-10-16 17:30:00', 22, 5, 28);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (29, 'Hands-on Bootcamp - Backend APIs', '2024-10-23 16:00:00', '2024-10-23 17:30:00', 39, 9, 29);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (30, 'Creative Bootcamp - Database Management', '2024-10-30 16:00:00', '2024-10-30 17:30:00', 24, 2, 30);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (31, 'Essential Workshop - Client-Centric Design', '2024-11-06 16:00:00', '2024-11-06 17:30:00', 22, 8, 31);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (32, 'Practical Workshop - Cloud Computing', '2024-11-13 16:00:00', '2024-11-13 17:30:00', 38, 1, 32);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (33, 'Professional Workshop - Data Science', '2024-11-20 16:00:00', '2024-11-20 17:30:00', 29, 3, 33);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (34, 'Advanced Bootcamp - Mobile App Design', '2024-11-27 16:00:00', '2024-11-27 17:30:00', 34, 3, 34);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (35, 'Hands-on Bootcamp - Frontend Development', '2024-12-04 16:00:00', '2024-12-04 17:30:00', 27, 9, 35);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (36, 'Essential Workshop - Building Client Relationships', '2024-12-11 16:00:00', '2024-12-11 17:30:00', 40, 4, 36);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (37, 'Collaborative Bootcamp - Client-Centric Design', '2024-12-18 16:00:00', '2024-12-18 17:30:00', 27, 2, 37);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (38, 'Hands-on Bootcamp - Mobile App Design', '2024-12-25 16:00:00', '2024-12-25 17:30:00', 36, 9, 38);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (39, 'Collaborative Workshop - Backend APIs', '2025-01-01 16:00:00', '2025-01-01 17:30:00', 23, 4, 39);
insert into Event (event_id, event_title, event_startTime, event_endTime, num_RSVPS, exec_id, speaker_id) values (40, 'Essential Bootcamp - Cybersecurity', '2025-01-08 16:00:00', '2025-01-08 17:30:00', 31, 3, 40);


#-- member_event --
insert into Member_Event (member_id, event_id) values (9, 32);
insert into Member_Event (member_id, event_id) values (33, 29);
insert into Member_Event (member_id, event_id) values (11, 34);
insert into Member_Event (member_id, event_id) values (32, 29);
insert into Member_Event (member_id, event_id) values (26, 24);
insert into Member_Event (member_id, event_id) values (38, 6);
insert into Member_Event (member_id, event_id) values (12, 27);
insert into Member_Event (member_id, event_id) values (23, 34);
insert into Member_Event (member_id, event_id) values (13, 18);
insert into Member_Event (member_id, event_id) values (20, 20);
insert into Member_Event (member_id, event_id) values (16, 40);
insert into Member_Event (member_id, event_id) values (21, 32);
insert into Member_Event (member_id, event_id) values (13, 15);
insert into Member_Event (member_id, event_id) values (22, 21);
insert into Member_Event (member_id, event_id) values (18, 29);
insert into Member_Event (member_id, event_id) values (14, 38);
insert into Member_Event (member_id, event_id) values (18, 26);
insert into Member_Event (member_id, event_id) values (11, 30);
insert into Member_Event (member_id, event_id) values (6, 13);
insert into Member_Event (member_id, event_id) values (7, 22);
insert into Member_Event (member_id, event_id) values (31, 1);
insert into Member_Event (member_id, event_id) values (17, 2);
insert into Member_Event (member_id, event_id) values (5, 22);
insert into Member_Event (member_id, event_id) values (4, 4);
insert into Member_Event (member_id, event_id) values (31, 18);
insert into Member_Event (member_id, event_id) values (11, 7);
insert into Member_Event (member_id, event_id) values (12, 23);
insert into Member_Event (member_id, event_id) values (34, 14);
insert into Member_Event (member_id, event_id) values (34, 24);
insert into Member_Event (member_id, event_id) values (27, 27);
insert into Member_Event (member_id, event_id) values (38, 37);
insert into Member_Event (member_id, event_id) values (33, 19);
insert into Member_Event (member_id, event_id) values (20, 40);
insert into Member_Event (member_id, event_id) values (10, 17);
insert into Member_Event (member_id, event_id) values (23, 23);
insert into Member_Event (member_id, event_id) values (7, 33);
insert into Member_Event (member_id, event_id) values (21, 28);
insert into Member_Event (member_id, event_id) values (1, 23);
insert into Member_Event (member_id, event_id) values (33, 6);
insert into Member_Event (member_id, event_id) values (5, 17);
insert into Member_Event (member_id, event_id) values (14, 40);
insert into Member_Event (member_id, event_id) values (31, 38);
insert into Member_Event (member_id, event_id) values (28, 13);
insert into Member_Event (member_id, event_id) values (34, 20);
insert into Member_Event (member_id, event_id) values (2, 4);
insert into Member_Event (member_id, event_id) values (30, 7);
insert into Member_Event (member_id, event_id) values (39, 34);
insert into Member_Event (member_id, event_id) values (22, 8);
insert into Member_Event (member_id, event_id) values (23, 28);
insert into Member_Event (member_id, event_id) values (13, 34);
insert into Member_Event (member_id, event_id) values (20, 37);
insert into Member_Event (member_id, event_id) values (16, 6);
insert into Member_Event (member_id, event_id) values (38, 19);
insert into Member_Event (member_id, event_id) values (14, 3);
insert into Member_Event (member_id, event_id) values (30, 21);
insert into Member_Event (member_id, event_id) values (11, 17);
insert into Member_Event (member_id, event_id) values (34, 6);
insert into Member_Event (member_id, event_id) values (33, 7);
insert into Member_Event (member_id, event_id) values (4, 17);
insert into Member_Event (member_id, event_id) values (26, 3);
insert into Member_Event (member_id, event_id) values (2, 38);
insert into Member_Event (member_id, event_id) values (29, 31);
insert into Member_Event (member_id, event_id) values (37, 30);
insert into Member_Event (member_id, event_id) values (4, 33);
insert into Member_Event (member_id, event_id) values (20, 22);
insert into Member_Event (member_id, event_id) values (11, 20);
insert into Member_Event (member_id, event_id) values (21, 16);
insert into Member_Event (member_id, event_id) values (16, 13);
insert into Member_Event (member_id, event_id) values (23, 32);
insert into Member_Event (member_id, event_id) values (20, 6);
insert into Member_Event (member_id, event_id) values (34, 40);
insert into Member_Event (member_id, event_id) values (22, 39);
insert into Member_Event (member_id, event_id) values (12, 6);
insert into Member_Event (member_id, event_id) values (10, 34);
insert into Member_Event (member_id, event_id) values (5, 29);
insert into Member_Event (member_id, event_id) values (16, 4);
insert into Member_Event (member_id, event_id) values (24, 19);
insert into Member_Event (member_id, event_id) values (35, 35);
insert into Member_Event (member_id, event_id) values (34, 38);
insert into Member_Event (member_id, event_id) values (14, 35);
insert into Member_Event (member_id, event_id) values (22, 4);
insert into Member_Event (member_id, event_id) values (6, 36);
insert into Member_Event (member_id, event_id) values (40, 23);
insert into Member_Event (member_id, event_id) values (13, 26);
insert into Member_Event (member_id, event_id) values (18, 40);
insert into Member_Event (member_id, event_id) values (9, 16);
insert into Member_Event (member_id, event_id) values (25, 28);
insert into Member_Event (member_id, event_id) values (34, 25);
insert into Member_Event (member_id, event_id) values (13, 30);
insert into Member_Event (member_id, event_id) values (25, 15);
insert into Member_Event (member_id, event_id) values (4, 13);
insert into Member_Event (member_id, event_id) values (2, 35);
insert into Member_Event (member_id, event_id) values (18, 8);
insert into Member_Event (member_id, event_id) values (24, 37);
insert into Member_Event (member_id, event_id) values (4, 7);
insert into Member_Event (member_id, event_id) values (17, 26);
insert into Member_Event (member_id, event_id) values (11, 40);
insert into Member_Event (member_id, event_id) values (15, 29);
insert into Member_Event (member_id, event_id) values (18, 4);
insert into Member_Event (member_id, event_id) values (9, 24);
insert into Member_Event (member_id, event_id) values (12, 10);
insert into Member_Event (member_id, event_id) values (5, 15);
insert into Member_Event (member_id, event_id) values (9, 2);
insert into Member_Event (member_id, event_id) values (9, 10);
insert into Member_Event (member_id, event_id) values (22, 12);
insert into Member_Event (member_id, event_id) values (36, 21);
insert into Member_Event (member_id, event_id) values (37, 19);
insert into Member_Event (member_id, event_id) values (4, 26);
insert into Member_Event (member_id, event_id) values (39, 23);
insert into Member_Event (member_id, event_id) values (40, 6);
insert into Member_Event (member_id, event_id) values (22, 14);
insert into Member_Event (member_id, event_id) values (4, 25);
insert into Member_Event (member_id, event_id) values (29, 13);
insert into Member_Event (member_id, event_id) values (22, 3);
insert into Member_Event (member_id, event_id) values (19, 25);
insert into Member_Event (member_id, event_id) values (4, 27);
insert into Member_Event (member_id, event_id) values (1, 28);
insert into Member_Event (member_id, event_id) values (40, 39);
insert into Member_Event (member_id, event_id) values (26, 1);
insert into Member_Event (member_id, event_id) values (29, 17);
insert into Member_Event (member_id, event_id) values (32, 13);
insert into Member_Event (member_id, event_id) values (28, 9);
insert into Member_Event (member_id, event_id) values (9, 15);
insert into Member_Event (member_id, event_id) values (7, 38);
insert into Member_Event (member_id, event_id) values (31, 23);
insert into Member_Event (member_id, event_id) values (29, 10);
insert into Member_Event (member_id, event_id) values (22, 13);
insert into Member_Event (member_id, event_id) values (39, 22);
insert into Member_Event (member_id, event_id) values (17, 4);
insert into Member_Event (member_id, event_id) values (30, 19);


#--member_applications--

insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (1, '2024-03-18 17:41:00', 'https://forms.gle/uxz2qfy98tnrk5wc', 10);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (2, '2024-03-14 09:28:00', 'https://forms.gle/w5x0cfbjz9or2h17', 1);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (3, '2024-04-07 17:08:00', 'https://forms.gle/9v6mj0x7gk5y4wzt', 2);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (4, '2024-03-22 09:39:00', 'https://forms.gle/dj1iobnzlgm2fvpw', 7);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (5, '2024-03-24 15:36:00', 'https://forms.gle/7lmdqhoib65tgzeu', 1);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (6, '2024-03-11 15:48:00', 'https://forms.gle/vqgn2m58ys4hc9ed', 9);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (7, '2024-03-22 14:09:00', 'https://forms.gle/0n3qt6zwvjdu71g4', 9);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (8, '2024-03-27 09:08:00', 'https://forms.gle/3evxhuz0k19b75ag', 8);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (9, '2024-03-18 18:14:00', 'https://forms.gle/ox0k3nszqf5g6b41', 2);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (10, '2024-04-08 20:22:00', 'https://forms.gle/t7k0bxndajyqv9or', 9);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (11, '2024-03-26 17:34:00', 'https://forms.gle/6qnzv4g2k7bndpxt', 3);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (12, '2024-03-20 20:31:00', 'https://forms.gle/yqbrw3zp5vk2n8fg', 6);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (13, '2024-04-04 14:58:00', 'https://forms.gle/t7wni8sl9c4omfep', 2);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (14, '2024-03-18 17:34:00', 'https://forms.gle/q1tfdc5euwmgnr2l', 7);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (15, '2024-03-19 11:53:00', 'https://forms.gle/9cwcm3qrzsfxehtj', 1);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (16, '2024-03-15 20:31:00', 'https://forms.gle/sryxavlzd5jk0g9i', 4);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (17, '2024-04-06 11:22:00', 'https://forms.gle/g1d4hzboqrlc39uj', 2);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (18, '2024-03-26 17:48:00', 'https://forms.gle/19jcb2r7apzysedk', 6);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (19, '2024-04-03 11:18:00', 'https://forms.gle/h7yjc59z21wqtpvm', 8);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (20, '2024-03-23 15:20:00', 'https://forms.gle/f5m0x6aygp2eu1hz', 5);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (21, '2024-04-05 08:43:00', 'https://forms.gle/3n7h6dpc0br5k7q9', 8);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (22, '2024-03-14 20:18:00', 'https://forms.gle/sq4o15mgakzlnuxd', 4);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (23, '2024-03-25 12:26:00', 'https://forms.gle/zsc17f5mgva2quxl', 1);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (24, '2024-03-29 09:30:00', 'https://forms.gle/bz5d7u4q2rshwvjt', 2);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (25, '2024-03-14 14:36:00', 'https://forms.gle/47wpt2h15fykzgu3', 1);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (26, '2024-03-18 10:17:00', 'https://forms.gle/jnd35czps4b1rwxo', 3);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (27, '2024-04-07 15:46:00', 'https://forms.gle/x4p9nlqwfamv1cd8', 1);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (28, '2024-03-20 15:13:00', 'https://forms.gle/p2dc7zvwghl39qde', 3);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (29, '2024-04-03 19:45:00', 'https://forms.gle/t9rcm8x4asov3w7h', 1);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (30, '2024-03-11 18:14:00', 'https://forms.gle/xjn35dvcqho0gwtm', 3);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (31, '2024-03-28 08:58:00', 'https://forms.gle/jtr2zgb5xcu8ha0w', 3);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (32, '2024-03-20 10:46:00', 'https://forms.gle/8roavd1bfs6n0x9t', 5);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (33, '2024-04-02 19:41:00', 'https://forms.gle/2lv5tyq98h1scz0a', 4);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (34, '2024-03-30 18:22:00', 'https://forms.gle/kb2fqpctdy5ar3wv', 3);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (35, '2024-04-02 18:37:00', 'https://forms.gle/nbrqxvza3c7jyud2', 4);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (36, '2024-03-24 14:32:00', 'https://forms.gle/7ntrxhqjzvxy2b4o', 5);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (37, '2024-03-30 11:37:00', 'https://forms.gle/tx2lpmf7g40bjkzy', 3);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (38, '2024-03-15 10:13:00', 'https://forms.gle/c8ev3ymovpjzrb0s', 2);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (39, '2024-04-01 12:39:00', 'https://forms.gle/jvp76te30nhlmqgs', 2);
insert into Member_Application (app_id, date_submitted, app_link, exec_id) values (40, '2024-04-09 09:43:00', 'https://forms.gle/5ux0mbdzt42shxna', 8);


#--client---

insert into Client (client_id, client_name, client_email, exec_id) values (1, 'Daron Ollin', 'dollin0@engadget.com', 8);
insert into Client (client_id, client_name, client_email, exec_id) values (2, 'Tomas Truss', 'ttruss1@loc.gov', 4);
insert into Client (client_id, client_name, client_email, exec_id) values (3, 'Jesse Woolham', 'jwoolham2@umn.edu', 6);
insert into Client (client_id, client_name, client_email, exec_id) values (4, 'Bibi Youngs', 'byoungs3@symantec.com', 3);
insert into Client (client_id, client_name, client_email, exec_id) values (5, 'Elfie Buckthought', 'ebuckthought4@gravatar.com', 8);
insert into Client (client_id, client_name, client_email, exec_id) values (6, 'Lezley Piscopiello', 'lpiscopiello5@163.com', 3);
insert into Client (client_id, client_name, client_email, exec_id) values (7, 'Egor De la Perrelle', 'ede6@home.pl', 7);
insert into Client (client_id, client_name, client_email, exec_id) values (8, 'Sayer Bradock', 'sbradock7@privacy.gov.au', 3);
insert into Client (client_id, client_name, client_email, exec_id) values (9, 'Darby Ellard', 'dellard8@washingtonpost.com', 2);
insert into Client (client_id, client_name, client_email, exec_id) values (10, 'Gaby Hammant', 'ghammant9@t.co', 5);
insert into Client (client_id, client_name, client_email, exec_id) values (11, 'Lucita Maddin', 'lmaddina@bigcartel.com', 8);
insert into Client (client_id, client_name, client_email, exec_id) values (12, 'Larine Berthomieu', 'lberthomieub@icio.us', 9);
insert into Client (client_id, client_name, client_email, exec_id) values (13, 'Simone Dreier', 'sdreierc@wordpress.com', 1);
insert into Client (client_id, client_name, client_email, exec_id) values (14, 'Doyle Danigel', 'ddanigeld@live.com', 9);
insert into Client (client_id, client_name, client_email, exec_id) values (15, 'Clementine Antrack', 'cantracke@cisco.com', 5);
insert into Client (client_id, client_name, client_email, exec_id) values (16, 'Eryn Madge', 'emadgef@rediff.com', 1);
insert into Client (client_id, client_name, client_email, exec_id) values (17, 'Stanley Pendleton', 'spendletong@amazon.co.jp', 6);
insert into Client (client_id, client_name, client_email, exec_id) values (18, 'Job Shrigley', 'jshrigleyh@washingtonpost.com', 2);
insert into Client (client_id, client_name, client_email, exec_id) values (19, 'Theodor Fausch', 'tfauschi@geocities.com', 3);
insert into Client (client_id, client_name, client_email, exec_id) values (20, 'Beulah Firk', 'bfirkj@about.com', 5);
insert into Client (client_id, client_name, client_email, exec_id) values (21, 'Lona Gooder', 'lgooderk@answers.com', 9);
insert into Client (client_id, client_name, client_email, exec_id) values (22, 'Georgina Lawtey', 'glawteyl@tiny.cc', 4);
insert into Client (client_id, client_name, client_email, exec_id) values (23, 'Laurena Hanway', 'lhanwaym@ed.gov', 6);
insert into Client (client_id, client_name, client_email, exec_id) values (24, 'Ricki Overstreet', 'roverstreetn@yellowbook.com', 2);
insert into Client (client_id, client_name, client_email, exec_id) values (25, 'Bernarr Graser', 'bgrasero@sina.com.cn', 2);
insert into Client (client_id, client_name, client_email, exec_id) values (26, 'Alysia Pollok', 'apollokp@themeforest.net', 7);
insert into Client (client_id, client_name, client_email, exec_id) values (27, 'Juditha Osipenko', 'josipenkoq@amazon.de', 9);
insert into Client (client_id, client_name, client_email, exec_id) values (28, 'Nelia Pond-Jones', 'npondjonesr@answers.com', 1);
insert into Client (client_id, client_name, client_email, exec_id) values (29, 'Aubree Boncore', 'aboncores@bluehost.com', 1);
insert into Client (client_id, client_name, client_email, exec_id) values (30, 'Edeline Vlasov', 'evlasovt@google.nl', 2);
insert into Client (client_id, client_name, client_email, exec_id) values (31, 'Lesya Drayson', 'ldraysonu@vistaprint.com', 3);
insert into Client (client_id, client_name, client_email, exec_id) values (32, 'Carlene Mathan', 'cmathanv@cbslocal.com', 2);
insert into Client (client_id, client_name, client_email, exec_id) values (33, 'Seamus Bettleson', 'sbettlesonw@privacy.gov.au', 6);
insert into Client (client_id, client_name, client_email, exec_id) values (34, 'Linc Beamond', 'lbeamondx@biglobe.ne.jp', 5);
insert into Client (client_id, client_name, client_email, exec_id) values (35, 'Whit Mathon', 'wmathony@blinklist.com', 7);
insert into Client (client_id, client_name, client_email, exec_id) values (36, 'Elsworth Sartain', 'esartainz@google.nl', 1);
insert into Client (client_id, client_name, client_email, exec_id) values (37, 'Petronilla Abbitt', 'pabbitt10@desdev.cn', 2);
insert into Client (client_id, client_name, client_email, exec_id) values (38, 'Harris McCurley', 'hmccurley11@tinyurl.com', 2);
insert into Client (client_id, client_name, client_email, exec_id) values (39, 'Dominic Spadelli', 'dspadelli12@lycos.com', 1);
insert into Client (client_id, client_name, client_email, exec_id) values (40, 'Anna Adey', 'aadey13@ow.ly', 9);

#--prospective client --

insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (1, 'Michael Peterson', 'Johnson Inc', 'michael.peterson@example.com', 2);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (2, 'Olivia Hughes', 'Smith Group', 'olivia.hughes@example.com', 4);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (3, 'Ethan Ramirez', 'Baker and Sons', 'ethan.ramirez@example.com', 9);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (4, 'Sophia Price', 'Taylor, PLC', 'sophia.price@example.com', 8);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (5, 'William Bennett', 'Anderson, Ltd', 'william.bennett@example.com', 6);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (6, 'Isabella Jenkins', 'Brown-Williams', 'isabella.jenkins@example.com', 7);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (7, 'James Torres', 'Adams LLC', 'james.torres@example.com', 1);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (8, 'Mia Bryant', 'White-Hernandez', 'mia.bryant@example.com', 5);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (9, 'Alexander Russell', 'Martin Ltd.', 'alexander.russell@example.com', 4);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (10, 'Charlotte Griffin', 'Thompson Group', 'charlotte.griffin@example.com', 3);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (11, 'Benjamin Butler', 'Lopez, Inc', 'benjamin.butler@example.com', 8);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (12, 'Amelia Hayes', 'Gonzalez, Ltd', 'amelia.hayes@example.com', 9);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (13, 'Daniel Simmons', 'Wilson PLC', 'daniel.simmons@example.com', 2);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (14, 'Evelyn Perry', 'Clark Group', 'evelyn.perry@example.com', 3);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (15, 'Matthew Coleman', 'Lewis Inc.', 'matthew.coleman@example.com', 7);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (16, 'Abigail Foster', 'Robinson LLC', 'abigail.foster@example.com', 1);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (17, 'Joseph Sanders', 'Walker PLC', 'joseph.sanders@example.com', 6);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (18, 'Emily Barnes', 'Hall Ltd.', 'emily.barnes@example.com', 4);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (19, 'David Powell', 'Allen and Sons', 'david.powell@example.com', 2);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (20, 'Elizabeth Perry', 'Young-Hall', 'elizabeth.perry@example.com', 5);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (21, 'Christopher Morris', 'King PLC', 'christopher.morris@example.com', 7);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (22, 'Sofia Bell', 'Wright and Sons', 'sofia.bell@example.com', 1);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (23, 'Andrew Murphy', 'Scott, Ltd', 'andrew.murphy@example.com', 8);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (24, 'Avery Brooks', 'Green-Kelly', 'avery.brooks@example.com', 6);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (25, 'Joshua Rivera', 'Howard PLC', 'joshua.rivera@example.com', 6);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (26, 'Ella Sanders', 'Baker Inc.', 'ella.sanders@example.com', 2);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (27, 'Logan Price', 'Hernandez Ltd.', 'logan.price@example.com', 1);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (28, 'Grace Reed', 'Nelson LLC', 'grace.reed@example.com', 1);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (29, 'Henry Cox', 'Carter Group', 'henry.cox@example.com', 3);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (30, 'Scarlett Ward', 'Mitchell Ltd.', 'scarlett.ward@example.com', 4);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (31, 'Jackson Bailey', 'Perez Inc', 'jackson.bailey@example.com', 2);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (32, 'Victoria Howard', 'Roberts and Sons', 'victoria.howard@example.com', 7);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (33, 'Sebastian Griffin', 'Turner PLC', 'sebastian.griffin@example.com', 1);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (34, 'Lily Richardson', 'Phillips PLC', 'lily.richardson@example.com', 3);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (35, 'Aiden Wood', 'Campbell Group', 'aiden.wood@example.com', 8);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (36, 'Hannah Ross', 'Parker, PLC', 'hannah.ross@example.com', 2);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (37, 'Samuel James', 'Evans Inc.', 'samuel.james@example.com', 3);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (38, 'Chloe Watson', 'Edwards Group', 'chloe.watson@example.com', 4);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (39, 'Luke Scott', 'Collins, Ltd', 'luke.scott@example.com', 3);
insert into Prospective_Client (prospective_id, prospective_name, prospective_companyName, prospective_email, exec_id) values (40, 'Zoey Patterson', 'Stewart LLC', 'zoey.patterson@example.com', 9);


# --proposal---

insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (1, 'https://docs.google.com/document/d/x1a2b3c4d5e6f7g8', 'Proposal for a new e-commerce website for a local boutique.', 8, 1);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (2, 'https://docs.google.com/document/d/x9h8g7f6e5d4c3b2', 'Mobile app idea for a food delivery startup.', 14, 2);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (3, 'https://docs.google.com/document/d/x2g3h4f5d6e7c8b9', 'CRM platform development proposal for a real estate firm.', 26, 3);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (4, 'https://docs.google.com/document/d/x7f6e5d4c3b2a1g9', 'Website redesign proposal for a marketing agency.', 3, 4);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (5, 'https://docs.google.com/document/d/x3b4c5d6e7f8g9h0', 'SaaS tool for small business accounting.', 29, 5);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (6, 'https://docs.google.com/document/d/x8h9g0f1e2d3c4b5', 'Proposal for a mobile banking app for freelancers.', 12, 6);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (7, 'https://docs.google.com/document/d/x4c5d6e7f8g9h0a1', 'Inventory management software for a retail chain.', 31, 7);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (8, 'https://docs.google.com/document/d/x9g0f1e2d3c4b5a6', 'Custom analytics dashboard for a logistics company.', 20, 8);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (9, 'https://docs.google.com/document/d/x5d6e7f8g9h0a1b2', 'E-learning platform proposal for online courses.', 7, 9);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (10, 'https://docs.google.com/document/d/x0f1e2d3c4b5a6g7', 'Mobile fitness app for personal trainers.', 2, 10);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (11, 'https://docs.google.com/document/d/x6e7f8g9h0a1b2c3', 'Proposal for a client booking system for spas.', 17, 11);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (12, 'https://docs.google.com/document/d/x1f2e3d4c5b6a7g8', 'Document automation system for a law firm.', 33, 12);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (13, 'https://docs.google.com/document/d/x7g8h9f0e1d2c3b4', 'Proposal to build a loyalty rewards app for a cafe.', 10, 13);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (14, 'https://docs.google.com/document/d/x2d3c4b5a6g7h8f9', 'New marketing website for a non-profit organization.', 35, 14);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (15, 'https://docs.google.com/document/d/x8h9f0e1d2c3b4a5', 'Marketplace app for local artists to sell artwork.', 5, 15);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (16, 'https://docs.google.com/document/d/x3e4d5c6b7a8g9h0', 'Donation platform for community fundraising events.', 38, 16);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (17, 'https://docs.google.com/document/d/x9f0e1d2c3b4a5g6', 'Property rental management software.', 16, 17);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (18, 'https://docs.google.com/document/d/x4d5c6b7a8g9h0f1', 'New employee onboarding portal for a corporation.', 6, 18);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (19, 'https://docs.google.com/document/d/x0e1d2c3b4a5g6h7', 'Time-tracking app for remote teams.', 27, 19);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (20, 'https://docs.google.com/document/d/x5c6b7a8g9h0f1e2', 'Proposal for a virtual event platform.', 11, 20);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (21, 'https://docs.google.com/document/d/x1d2c3b4a5g6h7f8', 'Data visualization software for financial analysts.', 19, 21);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (22, 'https://docs.google.com/document/d/x6b7a8g9h0f1e2d3', 'Customized POS system for small restaurants.', 36, 22);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (23, 'https://docs.google.com/document/d/x2c3b4a5g6h7f8e9', 'Proposal for a healthcare appointment booking app.', 13, 23);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (24, 'https://docs.google.com/document/d/x7a8g9h0f1e2d3c4', 'Fleet tracking software for transportation companies.', 25, 24);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (25, 'https://docs.google.com/document/d/x3b4a5g6h7f8e9d0', 'Proposal for a digital signage solution for malls.', 28, 25);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (26, 'https://docs.google.com/document/d/x8g9h0f1e2d3c4b5', 'On-demand home cleaning service app.', 9, 26);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (27, 'https://docs.google.com/document/d/x4a5g6h7f8e9d0b1', 'Platform for matching tutors with students.', 22, 27);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (28, 'https://docs.google.com/document/d/x9h0f1e2d3c4b5a6', 'Proposal for a project bidding platform.', 24, 28);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (29, 'https://docs.google.com/document/d/x5g6h7f8e9d0b1c2', 'Event management software for wedding planners.', 15, 29);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (30, 'https://docs.google.com/document/d/x0f1e2d3c4b5a6g7', 'Custom software for tracking student attendance.', 30, 30);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (31, 'https://docs.google.com/document/d/x6h7f8e9d0b1c2d3', 'B2B wholesale ordering platform.', 21, 31);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (32, 'https://docs.google.com/document/d/x2f3e4d5c6b7a8g9', 'Proposal for a customizable CRM system.', 34, 32);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (33, 'https://docs.google.com/document/d/x7e8d9c0b1a2g3f4', 'HR portal for employee performance reviews.', 37, 33);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (34, 'https://docs.google.com/document/d/x3f4d5c6b7a8g9h0', 'Marketplace for handmade goods.', 4, 34);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (35, 'https://docs.google.com/document/d/x8d9c0b1a2g3f4e5', 'Proposal for a mobile loyalty card system.', 18, 35);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (36, 'https://docs.google.com/document/d/x4d5c6b7a8g9h0e1', 'Virtual reality training platform.', 32, 36);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (37, 'https://docs.google.com/document/d/x9c0b1a2g3f4e5d6', 'Proposal for a corporate wellness app.', 1, 37);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (38, 'https://docs.google.com/document/d/x5b6a7g8h9d0c1e2', 'Crowdfunding website for startups.', 23, 38);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (39, 'https://docs.google.com/document/d/x0a1g2h3d4c5b6e7', 'Mobile event scheduling app.', 40, 39);
insert into Proposal (proposal_id, document_link, proposal_description, advisor_id, prospective_id) values (40, 'https://docs.google.com/document/d/x6g7h8d9c0b1a2e3', 'Proposal for an AI chatbot for customer service.', 19, 40);



#--Project--

insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (1, 'Develop a responsive e-commerce website.', '2024-04-12', '2024-07-15', 5, 1);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (2, 'Create a mobile app for food delivery.', '2024-04-15', '2024-06-20', 18, 2);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (3, 'Design a CRM system for a real estate firm.', '2024-04-20', '2024-08-10', 32, 3);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (4, 'Build a booking system for wellness centers.', '2024-04-24', '2024-06-30', 7, 4);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (5, 'Develop an online learning platform.', '2024-04-30', '2024-07-30', 12, 5);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (6, 'Create a financial tracking app for freelancers.', '2024-05-05', '2024-08-05', 21, 6);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (7, 'Develop a client portal for document sharing.', '2024-05-10', '2024-07-15', 3, 7);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (8, 'Build a new marketing website for a nonprofit.', '2024-05-14', '2024-09-01', 16, 8);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (9, 'Create an inventory management app.', '2024-05-20', '2024-07-25', 2, 9);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (10, 'Design a loyalty rewards mobile app.', '2024-05-25', '2024-08-25', 27, 10);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (11, 'Build a job posting and hiring portal.', '2024-06-01', '2024-08-30', 10, 11);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (12, 'Create a website for a clothing brand.', '2024-06-05', '2024-08-05', 14, 12);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (13, 'Develop an app for fitness trainers.', '2024-06-10', '2024-09-10', 6, 13);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (14, 'Create a real-time delivery tracking platform.', '2024-06-14', '2024-08-20', 24, 14);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (15, 'Develop an alumni networking website.', '2024-06-20', '2024-09-25', 1, 15);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (16, 'Build a healthcare appointment system.', '2024-06-25', '2024-09-30', 29, 16);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (17, 'Create a resource sharing platform.', '2024-07-01', '2024-10-01', 35, 17);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (18, 'Develop a ride-sharing application.', '2024-07-05', '2024-09-10', 9, 18);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (19, 'Create a virtual event hosting platform.', '2024-07-10', '2024-10-10', 13, 19);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (20, 'Build a budget management tool for startups.', '2024-07-15', '2024-09-20', 11, 20);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (21, 'Create a custom chatbot for customer service.', '2024-07-20', '2024-10-20', 19, 21);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (22, 'Develop a virtual reality training platform.', '2024-07-25', '2024-10-30', 23, 22);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (23, 'Build an e-commerce app for handmade crafts.', '2024-08-01', '2024-11-01', 37, 23);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (24, 'Create a remote work productivity tracker.', '2024-08-05', '2024-11-05', 25, 24);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (25, 'Develop an app for crowdfunding campaigns.', '2024-08-10', '2024-10-15', 22, 25);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (26, 'Design a website for a consultancy agency.', '2024-08-15', '2024-10-20', 4, 26);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (27, 'Build an internal communication tool.', '2024-08-20', '2024-11-25', 15, 27);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (28, 'Develop a peer-to-peer lending platform.', '2024-08-25', '2024-11-30', 40, 28);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (29, 'Create a marketplace app for local farmers.', '2024-09-01', '2024-11-05', 36, 29);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (30, 'Develop a mobile learning app for kids.', '2024-09-05', '2024-12-05', 30, 30);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (31, 'Build an online donation platform.', '2024-09-10', '2024-12-10', 26, 31);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (32, 'Create a document management system.', '2024-09-15', '2024-12-20', 39, 32);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (33, 'Develop a ticket booking app for theaters.', '2024-09-20', '2024-12-20', 8, 33);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (34, 'Build an online pet adoption website.', '2024-09-25', '2024-11-30', 20, 34);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (35, 'Create a subscription management platform.', '2024-10-01', '2025-01-01', 17, 35);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (36, 'Develop a freelance marketplace platform.', '2024-10-05', '2025-01-10', 28, 36);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (37, 'Create a portfolio website for designers.', '2024-10-10', '2025-01-15', 34, 37);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (38, 'Build an app for real-time team collaboration.', '2024-10-15', '2025-01-20', 38, 38);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (39, 'Create an app for quick invoice generation.', '2024-10-20', '2025-01-25', 33, 39);
insert into Project (project_id, project_description, project_startDate, project_endDate, advisor_id, client_id) values (40, 'Develop a crowdfunding site for nonprofits.', '2024-10-25', '2025-01-30', 15, 40);


# --member_project--

insert into Member_Project (member_id, project_id) values (17, 23);
insert into Member_Project (member_id, project_id) values (5, 8);
insert into Member_Project (member_id, project_id) values (29, 2);
insert into Member_Project (member_id, project_id) values (12, 14);
insert into Member_Project (member_id, project_id) values (8, 35);
insert into Member_Project (member_id, project_id) values (25, 6);
insert into Member_Project (member_id, project_id) values (34, 19);
insert into Member_Project (member_id, project_id) values (3, 11);
insert into Member_Project (member_id, project_id) values (19, 31);
insert into Member_Project (member_id, project_id) values (11, 20);
insert into Member_Project (member_id, project_id) values (38, 9);
insert into Member_Project (member_id, project_id) values (21, 4);
insert into Member_Project (member_id, project_id) values (7, 30);
insert into Member_Project (member_id, project_id) values (15, 13);
insert into Member_Project (member_id, project_id) values (6, 29);
insert into Member_Project (member_id, project_id) values (37, 18);
insert into Member_Project (member_id, project_id) values (26, 2);
insert into Member_Project (member_id, project_id) values (10, 40);
insert into Member_Project (member_id, project_id) values (9, 27);
insert into Member_Project (member_id, project_id) values (1, 7);
insert into Member_Project (member_id, project_id) values (31, 22);
insert into Member_Project (member_id, project_id) values (28, 17);
insert into Member_Project (member_id, project_id) values (24, 33);
insert into Member_Project (member_id, project_id) values (13, 1);
insert into Member_Project (member_id, project_id) values (2, 12);
insert into Member_Project (member_id, project_id) values (32, 15);
insert into Member_Project (member_id, project_id) values (20, 28);
insert into Member_Project (member_id, project_id) values (22, 5);
insert into Member_Project (member_id, project_id) values (4, 26);
insert into Member_Project (member_id, project_id) values (39, 3);
insert into Member_Project (member_id, project_id) values (30, 36);
insert into Member_Project (member_id, project_id) values (14, 16);
insert into Member_Project (member_id, project_id) values (23, 32);
insert into Member_Project (member_id, project_id) values (18, 10);
insert into Member_Project (member_id, project_id) values (40, 37);
insert into Member_Project (member_id, project_id) values (36, 25);
insert into Member_Project (member_id, project_id) values (16, 21);
insert into Member_Project (member_id, project_id) values (35, 34);
insert into Member_Project (member_id, project_id) values (27, 24);
insert into Member_Project (member_id, project_id) values (33, 39);
insert into Member_Project (member_id, project_id) values (19, 5);
insert into Member_Project (member_id, project_id) values (7, 13);
insert into Member_Project (member_id, project_id) values (8, 19);
insert into Member_Project (member_id, project_id) values (5, 6);
insert into Member_Project (member_id, project_id) values (6, 31);
insert into Member_Project (member_id, project_id) values (4, 7);
insert into Member_Project (member_id, project_id) values (13, 15);
insert into Member_Project (member_id, project_id) values (22, 25);
insert into Member_Project (member_id, project_id) values (14, 22);
insert into Member_Project (member_id, project_id) values (28, 9);
insert into Member_Project (member_id, project_id) values (1, 4);
insert into Member_Project (member_id, project_id) values (11, 3);
insert into Member_Project (member_id, project_id) values (2, 17);
insert into Member_Project (member_id, project_id) values (9, 29);
insert into Member_Project (member_id, project_id) values (26, 28);
insert into Member_Project (member_id, project_id) values (3, 8);
insert into Member_Project (member_id, project_id) values (12, 40);
insert into Member_Project (member_id, project_id) values (15, 11);
insert into Member_Project (member_id, project_id) values (24, 30);
insert into Member_Project (member_id, project_id) values (27, 2);
insert into Member_Project (member_id, project_id) values (31, 12);
insert into Member_Project (member_id, project_id) values (20, 36);
insert into Member_Project (member_id, project_id) values (10, 5);
insert into Member_Project (member_id, project_id) values (37, 38);
insert into Member_Project (member_id, project_id) values (17, 18);
insert into Member_Project (member_id, project_id) values (30, 15);
insert into Member_Project (member_id, project_id) values (39, 14);
insert into Member_Project (member_id, project_id) values (34, 10);
insert into Member_Project (member_id, project_id) values (21, 24);
insert into Member_Project (member_id, project_id) values (16, 1);
insert into Member_Project (member_id, project_id) values (23, 20);
insert into Member_Project (member_id, project_id) values (32, 34);
insert into Member_Project (member_id, project_id) values (18, 16);
insert into Member_Project (member_id, project_id) values (25, 22);
insert into Member_Project (member_id, project_id) values (38, 26);
insert into Member_Project (member_id, project_id) values (35, 27);
insert into Member_Project (member_id, project_id) values (36, 23);
insert into Member_Project (member_id, project_id) values (33, 6);
insert into Member_Project (member_id, project_id) values (40, 32);
insert into Member_Project (member_id, project_id) values (29, 21);
insert into Member_Project (member_id, project_id) values (19, 33);
insert into Member_Project (member_id, project_id) values (14, 3);
insert into Member_Project (member_id, project_id) values (5, 17);
insert into Member_Project (member_id, project_id) values (3, 19);
insert into Member_Project (member_id, project_id) values (7, 10);
insert into Member_Project (member_id, project_id) values (25, 31);
insert into Member_Project (member_id, project_id) values (27, 13);
insert into Member_Project (member_id, project_id) values (1, 22);
insert into Member_Project (member_id, project_id) values (11, 8);
insert into Member_Project (member_id, project_id) values (12, 12);
insert into Member_Project (member_id, project_id) values (9, 4);
insert into Member_Project (member_id, project_id) values (22, 35);
insert into Member_Project (member_id, project_id) values (8, 7);
insert into Member_Project (member_id, project_id) values (20, 14);
insert into Member_Project (member_id, project_id) values (13, 28);
insert into Member_Project (member_id, project_id) values (6, 18);
insert into Member_Project (member_id, project_id) values (32, 1);
insert into Member_Project (member_id, project_id) values (10, 30);
insert into Member_Project (member_id, project_id) values (17, 9);
insert into Member_Project (member_id, project_id) values (30, 20);
insert into Member_Project (member_id, project_id) values (24, 11);
insert into Member_Project (member_id, project_id) values (28, 2);
insert into Member_Project (member_id, project_id) values (38, 16);
insert into Member_Project (member_id, project_id) values (12, 27);
insert into Member_Project (member_id, project_id) values (36, 36);
insert into Member_Project (member_id, project_id) values (15, 5);
insert into Member_Project (member_id, project_id) values (39, 13);
insert into Member_Project (member_id, project_id) values (26, 34);
insert into Member_Project (member_id, project_id) values (33, 38);
insert into Member_Project (member_id, project_id) values (31, 15);
insert into Member_Project (member_id, project_id) values (23, 40);
insert into Member_Project (member_id, project_id) values (35, 29);
insert into Member_Project (member_id, project_id) values (4, 37);
insert into Member_Project (member_id, project_id) values (21, 25);
insert into Member_Project (member_id, project_id) values (18, 24);
insert into Member_Project (member_id, project_id) values (16, 6);
insert into Member_Project (member_id, project_id) values (19, 26);
insert into Member_Project (member_id, project_id) values (34, 12);
insert into Member_Project (member_id, project_id) values (7, 39);
insert into Member_Project (member_id, project_id) values (40, 18);
insert into Member_Project (member_id, project_id) values (5, 30);
insert into Member_Project (member_id, project_id) values (27, 3);
insert into Member_Project (member_id, project_id) values (37, 37);
insert into Member_Project (member_id, project_id) values (29, 35);
insert into Member_Project (member_id, project_id) values (14, 26);
insert into Member_Project (member_id, project_id) values (2, 38);
insert into Member_Project (member_id, project_id) values (8, 21);
insert into Member_Project (member_id, project_id) values (6, 4);
insert into Member_Project (member_id, project_id) values (11, 23);
insert into Member_Project (member_id, project_id) values (3, 31);
insert into Member_Project (member_id, project_id) values (1, 36);
insert into Member_Project (member_id, project_id) values (31, 9);


# --ticket--

insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (1, 'in progress', 'Fix homepage banner alignment issue.', 5);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (2, 'viewed', 'Add mobile responsiveness for homepage.', 5);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (3, 'completed', 'Build login functionality for customer portal.', 12);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (4, 'in progress', 'Fix validation on login form.', 12);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (5, 'not done', 'Design landing page for event website.', 8);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (6, 'completed', 'Integrate RSVP form to event landing page.', 8);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (7, 'viewed', 'Connect payment gateway for online store.', 23);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (8, 'in progress', 'Fix cart update issue after checkout.', 23);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (9, 'completed', 'Create dashboard overview page.', 17);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (10, 'not done', 'Set up notifications on dashboard.', 17);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (11, 'in progress', 'Fix session timeout bug.', 5);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (12, 'viewed', 'Research responsive framework options.', 12);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (13, 'completed', 'Upload assets to cloud storage.', 34);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (14, 'not done', 'Integrate asset URLs to the website.', 34);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (15, 'viewed', 'Design event brochure template.', 7);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (16, 'in progress', 'Finalize branding color palette.', 7);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (17, 'completed', 'Implement dark mode for app.', 14);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (18, 'not done', 'Fix toggle switch for dark mode.', 14);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (19, 'viewed', 'Update API endpoints documentation.', 6);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (20, 'in progress', 'Test error handling for API calls.', 6);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (21, 'completed', 'Create user guide PDF.', 29);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (22, 'in progress', 'Proofread final draft of user guide.', 29);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (23, 'viewed', 'Design admin panel layout.', 18);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (24, 'not done', 'Add admin role access control.', 18);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (25, 'completed', 'Fix footer layout on mobile devices.', 31);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (26, 'viewed', 'Center footer links horizontally.', 31);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (27, 'completed', 'Set up email notifications for app.', 2);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (28, 'in progress', 'Verify SMTP server configurations.', 2);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (29, 'viewed', 'Research customer feedback tool.', 36);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (30, 'not done', 'Integrate feedback widget into dashboard.', 36);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (31, 'completed', 'Fix image cropping tool on upload.', 9);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (32, 'in progress', 'Resize thumbnails for image gallery.', 9);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (33, 'viewed', 'Update favicon across pages.', 21);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (34, 'completed', 'Optimize site metadata for SEO.', 21);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (35, 'not done', 'Fix pagination controls.', 15);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (36, 'viewed', 'Enhance pagination with lazy loading.', 15);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (37, 'completed', 'Fix search query on user directory.', 37);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (38, 'in progress', 'Add filters to user directory.', 37);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (39, 'viewed', 'Research calendar library options.', 26);
insert into Ticket (ticket_id, ticket_status, ticket_description, project_id) values (40, 'not done', 'Integrate event calendar to dashboard.', 26);


# --status update---

insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (1, 'Initial setup of project resources complete.', '2024-04-15 10:30:00', 23, 17);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (2, 'Frontend structure finalized.', '2024-04-20 11:45:00', 8, 5);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (3, 'Database schema reviewed and updated.', '2024-04-25 09:00:00', 2, 29);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (4, 'Login module completed.', '2024-05-02 15:00:00', 14, 12);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (5, 'Payment integration in progress.', '2024-05-06 13:30:00', 35, 8);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (6, 'Order tracking system initiated.', '2024-05-08 16:45:00', 6, 25);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (7, 'Admin panel design submitted.', '2024-05-10 12:00:00', 19, 34);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (8, 'API endpoint testing underway.', '2024-05-12 14:15:00', 11, 3);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (9, 'Login bug fixes completed.', '2024-05-15 17:00:00', 31, 19);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (10, 'Security audit started.', '2024-05-18 09:30:00', 20, 11);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (11, 'Mobile layout adjustments done.', '2024-05-20 16:00:00', 9, 38);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (12, 'User dashboard wireframe approved.', '2024-05-23 13:45:00', 4, 21);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (13, 'OAuth setup completed.', '2024-05-26 11:30:00', 30, 7);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (14, 'Session timeout feature added.', '2024-05-29 12:00:00', 13, 15);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (15, 'CMS module live.', '2024-06-02 10:45:00', 29, 6);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (16, 'App speed optimized by 20%.', '2024-06-05 14:30:00', 18, 37);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (17, 'Search functionality implemented.', '2024-06-08 16:30:00', 8, 24);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (18, 'Image upload issue resolved.', '2024-06-10 17:45:00', 4, 25);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (19, 'Analytics dashboard ready.', '2024-06-12 09:15:00', 14, 26);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (20, 'Deployment to staging completed.', '2024-06-14 11:00:00', 2, 28);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (21, 'Firebase setup finished.', '2024-06-16 13:00:00', 22, 31);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (22, 'Landing page video added.', '2024-06-18 15:45:00', 15, 13);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (23, 'Dynamic search filters complete.', '2024-06-21 09:30:00', 1, 16);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (24, 'File upload limit increased.', '2024-06-23 10:15:00', 32, 23);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (25, 'First version of chat feature released.', '2024-06-26 14:00:00', 25, 6);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (26, 'Minor UI bug fixes.', '2024-06-28 17:30:00', 15, 30);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (27, 'Website SEO optimization started.', '2024-07-01 09:45:00', 14, 39);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (28, 'Push notifications now live.', '2024-07-03 13:00:00', 10, 40);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (29, 'Security patches applied.', '2024-07-05 15:30:00', 36, 29);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (30, 'Data migration successfully tested.', '2024-07-07 12:00:00', 36, 36);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (31, 'Content updates pushed.', '2024-07-09 10:00:00', 7, 14);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (32, 'Support ticket system functional.', '2024-07-11 11:45:00', 30, 7);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (33, 'Project handoff scheduled.', '2024-07-13 14:30:00', 39, 33);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (34, 'New API docs published.', '2024-07-15 16:15:00', 2, 10);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (35, 'Subscription module working.', '2024-07-18 09:30:00', 21, 31);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (36, 'Social media links updated.', '2024-07-20 10:45:00', 34, 7);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (37, 'Final security review passed.', '2024-07-23 12:00:00', 18, 37);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (38, 'Beta test reports positive.', '2024-07-25 14:15:00', 27, 13);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (39, 'User onboarding tutorial built.', '2024-07-27 16:30:00', 36, 29);
insert into Status_Update (update_id, update_description, update_dateTime, project_id, member_id) values (40, 'Final delivery milestone achieved.', '2024-07-30 09:00:00', 8, 24);


