
CREATE TABLE [Role]
(
	id varchar(255) NOT NULL,
	roleName varchar(255),
	PRIMARY KEY (id)
);

CREATE TABLE [User]
(
	id varchar(255) NOT NULL,
	username varchar(255) NOT NULL,
	password varchar(255),
	fullName varchar(255),
	email varchar(255),
	educationLevel varchar(255),
	roleID varchar(255) NOT NULL,
	PRIMARY KEY (id),
	CONSTRAINT FKUser_Role FOREIGN KEY (roleID) REFERENCES [Role] (id)
);

CREATE TABLE [Subject]
(
	id char(8),
	[name] varchar(255),
	createdAt date,
	updatedAt date,
	semester int,
	credit int,
	PRIMARY KEY (id)
);

create table [PreRequisite]
(
	id int identity,
	subjectID char(8) not null,
	requisiteSubjectID char(8) not null,
	FOREIGN KEY (subjectID) references [Subject] (id),
	FOREIGN KEY (requisiteSubjectID) references [Subject] (id),
)

CREATE TABLE [Syllabus]
(
	id int identity NOT NULL,
	subjectID char(8) NOT NULL,
	[name] varchar(255),
	credit int,
	[description] varchar(255),
	tasks varchar(255),
	scoringScale int,
	[status] bit,
	minScore int,
	createdAt date,
	updatedAt date,
	isApproved bit,
	FOREIGN KEY (subjectID) references [Subject] (id),
	PRIMARY KEY (id)
);

CREATE TABLE [Material]
(
	id int identity NOT NULL,
	[name] varchar(255),
	[materialUrl] varchar(255),
	syllabusID int NOT NULL,
	FOREIGN KEY (syllabusID) REFERENCES [Syllabus](id),
	PRIMARY KEY (id)
);

CREATE TABLE [Curriculum]
(
	id int identity NOT NULL,
	code varchar(100) not null UNIQUE,
	[name] varchar(255) UNIQUE,
	[description] varchar(255),
	decisionNo varchar(255),
	PRIMARY KEY (id),
);

CREATE TABLE [Program_Objective]
(
	id int IDENTITY NOT NULL,
	[name] varchar(255),
	[description] varchar(255),
	PRIMARY KEY (id),
);

CREATE TABLE [Program_Learning_Objective]
(
	id int NOT NULL,
	[name] varchar(255),
	[description] varchar(255),
	PRIMARY KEY (id),
);


select * from Program_Learning_Objective

CREATE TABLE [Program_Learning_Objective_2]
(
	id int identity,
	[name] varchar(255),
	[description] varchar(255),
	PRIMARY KEY (id),
);



CREATE TABLE [Course_Learning_Objective]
(
	id int identity NOT NULL,
	[name] varchar(255),
	[description] varchar(255),
	syllabusID int NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (syllabusID) REFERENCES [Syllabus](id)
);


CREATE TABLE [CLO_to_PLO_from_Cur]
(
	PLO_ID int NOT NULL,
	CLO_ID int NOT NULL,
	curriculumID int NOT NULL,
	FOREIGN KEY (PLO_ID) REFERENCES [Program_Learning_Objective](id),
	FOREIGN KEY (CLO_ID) REFERENCES [Course_Learning_Objective](id),
	FOREIGN KEY (curriculumID) REFERENCES [Curriculum](id)
);



CREATE TABLE [PO_to_PLO]
(
	PO_ID int NOT NULL,
	PLO_ID int NOT NULL,
	FOREIGN KEY (PO_ID) REFERENCES [Program_Objective](id),
	FOREIGN KEY (PLO_ID) REFERENCES [Program_Learning_Objective](id)
);



CREATE TABLE [KnowledgeCategory]
(
	id int NOT NULL,
	[name] varchar(255) ,
	[description] varchar(255),
	subjectID char(8),
	FOREIGN KEY (subjectID) references [Subject] (id),
	PRIMARY KEY (id)
);

CREATE TABLE [Assessment]
(
	id int NOT NULL,
	[name] varchar(255),
	[type] varchar(255),
	part int,
	[weight] decimal(19, 0),
	completionCriteria varchar(255),
	duration varchar(255),
	CLO_ID int NOT NULL,
	questionType varchar(255),
	numberOfQuestion varchar(255),
	knowledgeScope varchar(255),
	gradingGuide varchar(255),
	note varchar(255),
	syllabusID int NOT NULL,
	FOREIGN KEY (CLO_ID) REFERENCES [Course_Learning_Objective](id),
	FOREIGN KEY (syllabusID) references [Syllabus] (id),
	PRIMARY KEY (ID)
);


CREATE TABLE [Session]
(
	id int NOT NULL,
	topic varchar(255),
	learningType varchar(255),
	LO_ID varchar(255),
	materials varchar(255),
	[studentTasks] varchar(255),
	syllabusID int NOT NULL,
	FOREIGN KEY (syllabusID) references [Syllabus] (id),
	PRIMARY KEY (id)
);



CREATE TABLE [Questions]
(
	id int NOT NULL,
	[name] varchar(255),
	details varchar(255),
	sessionID int NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (sessionID) REFERENCES [Session](id),
);

-- Manipulate


select *
from [User]
INSERT INTO [Role]
	(id, roleName)
VALUES
	('ADM', 'Admin');
INSERT INTO [Role]
	(id, roleName)
VALUES
	('STD', 'Student');
INSERT INTO [Role]
	(id, roleName)
VALUES
	('TCH', 'Teacher');

INSERT INTO [User]
	(id, username, fullName, email, educationLevel, roleID)
VALUES
	('SE160028', 'baondse160028', 'Nguyen Duy Bao', 'baondse160028@fpt.edu.vn', 'FU', 'STD');

INSERT INTO [User]
	(id, username, password, fullName, email, educationLevel, roleID)
VALUES
	('AD987654', 'admin001', '123456', 'Admin Ne', 'admin@example.com', NULL, 'ADM');
select *
from Subject



alter table KnowledgeCategory alter column name varchar(255)


alter table Course_Learning_Objective add createdAt date default GETDATE()
alter table Course_Learning_Objective add updatedAt date

insert into Course_Learning_Objective (name, description)
values ('PL01', 'Demonstrate basic knowledge of social sciences, politics and law, national security and defense, contributing to the formation of worldview and scientific methodology.')


INSERT INTO temp_table (name, col2)
SELECT col1, col2 FROM original_table
ALTER TABLE Program_Learning_Objective DROP COLUMN id
alter table Program_Learning_Objective alter column id int IDENTITY
alter table Program_Learning_Objective add createdAt date default GETDATE()
alter table Program_Learning_Objective add updatedAt date

ALTER TABLE Program_Learning_Objective DROP CONSTRAINT PK__Program___3213E83FF33459EE
ALTER TABLE PO_to_PLO DROP CONSTRAINT FK__PO_to_PLO__PLO_I__03F0984C
PK__Program___3213E83FF33459EE
FK__CLO_to_PL__PLO_I__7F2BE32F
FK__PO_to_PLO__PLO_I__03F0984C
DROP TABLE Program_Learning_Objective
select * from Program_Learning_Objective

EXEC sp_rename 'Program_Learning_Objective_2', 'Program_Learning_Objective'

ALTER TABLE CLO_to_PLO_from_Cur ADD CONSTRAINT FK__CLO_to_PL__PLO_I__7F2BE32F FOREIGN KEY (PLO_ID) REFERENCES Program_Learning_Objective(id)
ALTER TABLE PO_to_PLO ADD CONSTRAINT FK__PO_to_PLO__PLO_I__03F0984C FOREIGN KEY (PLO_ID) REFERENCES Program_Learning_Objective(id)

alter table Program_Learning_Objective alter column description varchar(500)

insert into Program_Learning_Objective (name, description)
values ('PL01', 'Demonstrate basic knowledge of social sciences, politics and law, national security and defense, contributing to the formation of worldview and scientific methodology.')

insert into Program_Learning_Objective (name, description)
values ('PLO2', 'Demonstrate an entrepreneurial, creative, critical, and problem-solving mindset.')

insert into Program_Learning_Objective (name, description)
values ('PLO3', 'Communicating and working in groups effectively in academic and practical environments.')

insert into Program_Learning_Objective (name, description)
values ('PLO4', 'Use English proficiently in communication and learning (equivalent to level 4 according to the 6-level Foreign Language Proficiency Framework for Vietnam, IELTS 6.0 or TOEFL (paper) 575-600 or TOEFL (iBT) 90 -100); and be able to communicate simply in Japanese.')

insert into Program_Learning_Objective (name, description)
values ('PLO5', 'Demonstrate professional behaviors, morality, social responsibilities and a sense of dedication to community.')

select * from Program_Learning_Objective
DELETE FROM Program_Learning_Objective

select * from Curr_to_PO as R
	inner join Program_Objective as P on R.PO_ID = P.id
select * from Program_Learning_Objective
select * from PO_to_PLO
insert into PO_to_PLO (PO_ID, PLO_ID)
values(2, 14)

insert into PO_to_PLO (PO_ID, PLO_ID)
values(2, 15)

insert into PO_to_PLO (PO_ID, PLO_ID)
values(4, 15)

insert into PO_to_PLO (PO_ID, PLO_ID)
values(6, 15)


insert into PO_to_PLO (PO_ID, PLO_ID)
values(4, 16)

insert into PO_to_PLO (PO_ID, PLO_ID)
values(6, 16)


INSERT INTO Subject
	(id, name, createdAt, semester, credit)
VALUES
	('PRF192', 'Programming Fundamentals', '2022-03-16', 1, 3);

INSERT INTO Subject
	(id, name, createdAt, semester, credit)
VALUES
	('PRO192', 'Object-Oriented Programming', '2022-03-16', 1, 3);

select *
from Subject

alter table Subject alter column id char(6) not null

ALTER TABLE Subject
	DROP CONSTRAINT PK__Subject__3213E83F0BDD1ED1;

ALTER TABLE Knowledge
	DROP CONSTRAINT FK__Knowledge__subje__7B5B524B;

ALTER TABLE Syllabus
	DROP CONSTRAINT FK__Syllabus__subjec__6383C8BA;


select *
from PreRequisite
INSERT INTO PreRequisite
	(subjectID, requisiteSubjectID)
VALUES
	('PRO192', 'PRF192');


alter table Syllabus drop column [name]
ALTER TABLE Syllabus DROP CONSTRAINT UNIQUE_NAME_SYLLABUS;
alter table Syllabus alter column [name] drop CONSTRAINTS UNIQUE_NAME_SYLLABUS
ALTER TABLE Syllabus alter column [tasks] varchar(500)

INSERT INTO Syllabus (subjectID, credit, [description], tasks, scoringScale, [status], minScore, isApproved)
values('PRF192', 3, 'Understand basics of information theory, computer system and methods of software development, focus on function-oriented programming design, coding, testing and discipline in programming.
Explain basic concepts of programming, function-oriented programming design, modularity, understand and coding programs using C', '- Students must attend more than 80% of contact sessions in order to be accepted to the final examination.
<br>- Student is responsible to do all assigned exercises given by instructor in class or at home and submit on time
<br>- Use laptop in class only for learning purpose <br>- Promptly access to the FU CMS at http://cms.fpt.edu.vn for up-to-date course information', 10, 1, 5, 1)

select * from Syllabus

ALTER TABLE KnowledgeCategory
		ADD CONSTRAINT [UNIQUE_NAME_KNOWLEDGE] UNIQUE (name)


alter table Curriculum add viName nvarchar(255)
alter table Curriculum add createdAt date default GETDATE()
alter table Curriculum add updatedAt date
alter table Curriculum alter column description varchar(max)

insert into Curriculum
	(code, name, viName, description, decisionNo)
values
	('BIT_SE_K16C', 'Bachelor Program of Information Technology, Software Engineering Major', N'Chương trình cử nhân ngành CNTT, chuyên ngành Kỹ thuật phần mềm', '1. Training Objectives <br>1.1 General objective: <br>Training Information Technology (IT)/Software Engineering (SE) specialty engineers with personality and capacity to meet the needs of society, mastering professional knowledge and practice, being able to organize, implement and promote the creativity in jobs related to the trained specialty as well as pursue further education and research. <br>The training program aims to: <br>a) To equip students with fundamental knowledge of mathematics and the IT industry together with fundamental and specialized methodologies, technologies related to the trained specialty ; <br>b) Train students the necessary virtues and skills in the professional working environment, know how to apply specialized knowledge of SE specialty into practical work <br>c) Provide students with a strong foundation in foreign languages, science, culture and society, promoting their autonomy and creativity in study, work and life', '1095/QĐ-ĐHFPT dated 11/28/2022')

select *
from Curriculum


alter table Program_Objective add createdAt date default GETDATE()
alter table Program_Objective add updatedAt date
alter table Program_Objective alter column description varchar(500)
insert into Program_Objective
	(name, description)
values
	('PO1', 'Having basic knowledge of social sciences, politics and law, security and defense, foundational knowledge of the IT industry & in-depth knowledge of the specialized training: techniques, methods, technologies, in-depth application areas; development trends in the world; at the same time understand the overall market, context, functions and tasks of the professions in the specialized training.')


insert into Program_Objective
	(name, description)
values
	('PO2', 'Be able to work as a full member of a professional team in the field of training: participate in designing, selecting techniques and technologies in line with development trends, solving technical problems; understand technology trends and user requirements; can do the complete solution development plan; performance management and change management in his or her part of the job; understand state policies in specialized fields.')

insert into Program_Objective
	(name, description)
values
	('PO3', 'Mastering professional skills and soft skills of 21st century citizens (thinking skills, work skills, skills in using work tools, life skills in a global society.)')

insert into Program_Objective
	(name, description)
values
	('PO4', 'Can use English well in study and work and a second foreign language in normal communication.')

	insert into Program_Objective
	(name, description)
values
	('PO5', 'Honesty, high discipline in study and work, know how to work effectively in groups; know how to behave culturally at work and in society; dynamic, creative and willing to learn constantly. Demonstrate professional attitude and behavior with the ability to conceive of ideas, design, implement and operate systems in the context of corporation and society.')

CREATE TABLE [Curr_to_PO]
(
	curriculumID int NOT NULL,
	PO_ID int NOT NULL,
	FOREIGN KEY (curriculumID) REFERENCES [curriculum](id),
	FOREIGN KEY (PO_ID) REFERENCES [Program_Objective](id)
);

insert into Curr_to_PO(curriculumID, PO_ID)
values (2, 2)

insert into Curr_to_PO(curriculumID, PO_ID)
values (2, 3)

insert into Curr_to_PO(curriculumID, PO_ID)
values (2, 4)

insert into Curr_to_PO(curriculumID, PO_ID)
values (2, 5)

insert into Curr_to_PO(curriculumID, PO_ID)
values (2, 6)

select * from Curr_to_PO
select * from Program_Objective
