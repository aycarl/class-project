insert into team_project (project, member, authority) values (1, 1, 'owner'), (2, 1, 'owner'), (3, 1, 'owner'), (4, 1, 'owner');

insert into team_project (project, member, authority) values (1, 3, 'student'), (2, 2, 'regular'), (4, 2, 'regular');

insert into users (first_name, last_name, user_name, pass_key, authority) values 
	('Student', 'One', 'student.one', SHa1('student'), 'Standard User',
	('Student', 'Two', 'student.two', SHa1('student'), 'Standard User'),
	('Student', 'Three', 'student.three', SHa1('student'), 'Standard User'),
	('Student', 'Four', 'student.four', SHa1('student'), 'Standard User');

SELECT user_name, first_name, last_name, clearance FROM projects, team_project, users WHERE projects.pr_id = team_project.project AND users.user_id = team_project.member AND pr_id = '$prj';

SELECT * FROM (SELECT * FROM projects, team_project, users WHERE projects.pr_id = team_project.project AND users.user_id = team_project.member AND pr_id = 2) AS a RIGHT OUTER JOIN (SELECT * FROM users) AS b ON a.user_id = b.user_id WHERE a.pr_id IS null;

