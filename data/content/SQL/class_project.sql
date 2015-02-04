CREATE SCHEMA class_project;

USE class_project;

CREATE TABLE IF NOT EXISTS users(
	user_id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(25),
	last_name VARCHAR(50),
	user_name VARCHAR(100),
	pass_key VARCHAR(40), -- sha1() ENCODING
	authority enum('Admin User','Standard User', 'Instructor')
);

insert into users (first_name, last_name, user_name, pass_key, authority) values
('Carl', 'Yao', 'carl.yao', SHA1('carl'), 'Admin User'),
('test', 'standard', 'test.standard', SHA1('password'), 'Standard User'),
('Teacher', 'One', 'teacher.one', SHa1('instructor'), 'Instructor');

-- 
CREATE TABLE IF NOT EXISTS projects(
	pr_id INT PRIMARY KEY AUTO_INCREMENT,
	title varchar(50),
	description VARCHAR(10000),
	file_01 VARCHAR(100),
	file_02 VARCHAR(100),
	date_created TIMESTAMP
);

-- drop table team_member;
insert into projects(title, description, file_01, file_02) values
('Competitive Strategy', 'Complete assignment 1 as a group (10 questions)', null, null),
('Text and Meaning', ' present chapter 1 to the class on Tuesday', null, null);

select * from projects;

CREATE TABLE IF NOT EXISTS team_project(
	tp_id INT PRIMARY KEY AUTO_INCREMENT,
	member INT,
	project INT,
	authority enum('owner','regular', 'Instructor'),

	FOREIGN KEY (member) REFERENCES users(user_id),
	FOREIGN KEY (project) REFERENCES team_project(tp_id)
);


insert into team_project (project_owner, project, member_01, member_02) values
(1, 1, 2, 3),
(2, 2, 1, 3);

select * from users, projects, team_project where users.user_id = team_project.project_owner and projects.pr_id = team_project.project;

CREATE TABLE IF NOT EXISTS tasks(
	t_id INT PRIMARY KEY AUTO_INCREMENT,
	message varchar(1000),
	deadline_day DATE,
	deadline_time TIME,
	assignee INT,
	project INT,

	FOREIGN KEY (assignee) REFERENCES users(user_id),
	FOREIGN KEY (project) REFERENCES team_project(tp_id)
);