<?php
	$database = "class_project";
	$username = "root";
	$password = "";
	$server = "localhost";

	$link = mysql_connect($server, $username, $password);

	//connect to server
	if (!$link) {
		echo "Failed to connect to MySQL server";
		echo mysql_error();
		exit();
	}

	//connect to database
	if (!mysql_select_db($database, $link)) {
		echo "Failed to select database: ". $database;
		echo mysql_error();
		exit();
	}

	//fetch all projects
	if (isset($_REQUEST['projects'])) {

		if (isset($_REQUEST['user_info'])) {
			// code... to be used to extract projects related to logged in user
			$member = $_REQUEST['user_info'];
		}
		// $user_id = 1; //hard coded for now...
		
		$query = mysql_query("SELECT * FROM projects, team_project, users WHERE projects.pr_id = team_project.project AND users.user_id = team_project.member AND users.user_name = '$member'", $link);
		$result = mysql_fetch_assoc($query);

		$rowCount = 0;

		echo "[";

		while ($result) {
			
			echo "{";
			echo "\"id\" :\"".$result["pr_id"]."\",";
			echo "\"title\" :\"".$result["title"]."\",";
			echo "\"description\" :\"".$result["description"]."\",";
			echo "\"file_01\" :\"".$result["file_01"]."\",";
			echo "\"file_02\" :\"".$result["file_02"]."\",";
			echo "\"date_created\" :\"".$result["date_created"]."\",";

			echo "\"user_lastname\" : \"".$result['last_name']."\",";
			echo "\"user_firstname\" : \"".$result['first_name']."\"";

			echo "}";

			$result = mysql_fetch_assoc($query);
			if ($result) {
				echo ",";
			}
			$rowCount++;

		}

		echo "]";
	}

	//parse project details as json object
	if (isset($_REQUEST['project_id'])) {
		
		$prj = $_REQUEST['project_id'];

		// echo "<script>console.log('inside yes!')</script>";

		$query = mysql_query("SELECT * FROM projects, team_project WHERE pr_id = '$prj' AND projects.pr_id = team_project.project", $link);
		$result = mysql_fetch_assoc($query);
		
		echo "{";
		echo "\"id\" :\"".$result["pr_id"]."\",";
		echo "\"title\" :\"".$result["title"]."\",";
		echo "\"description\" :\"".$result["description"]."\",";
		echo "\"file_01\" :\"".$result["file_01"]."\",";
		echo "\"file_02\" :\"".$result["file_02"]."\",";
		echo "\"date_created\" :\"".$result["date_created"]."\"";
		echo "}";

	}

	//parse member list as json object
	if (isset($_REQUEST['list_project_members'])) {
		
		if (isset($_REQUEST['team_project_id'])) {
			# code...
			$prj = $_REQUEST['team_project_id'];
		}

		$query = mysql_query("SELECT users.user_id 'user_id', user_name, first_name, last_name, clearance FROM projects, team_project, users WHERE projects.pr_id = team_project.project AND users.user_id = team_project.member AND pr_id = '$prj'", $link);
		$result = mysql_fetch_assoc($query);

		echo "[";

		while ($result) {

			echo "{";
			echo "\"user_id\" :\"".$result["user_id"]."\",";
			echo "\"user_name\" :\"".$result["user_name"]."\",";
			echo "\"first_name\" :\"".$result["first_name"]."\",";
			echo "\"last_name\" :\"".$result["last_name"]."\",";
			echo "\"clearance\" :\"".$result["clearance"]."\"";
			echo "}";

			$result = mysql_fetch_assoc($query);
			if ($result) {
				echo ",";
			}
		}

		echo "]";

	}

	//parse list of members who are not on a project
	if (isset($_REQUEST['list_non_project_members'])) {
		
		if (isset($_REQUEST['t_project_id'])) {
			# code...
			$prj = $_REQUEST['t_project_id'];
		}

		$query = mysql_query("SELECT * FROM (SELECT * FROM projects, team_project, users WHERE projects.pr_id = team_project.project AND users.user_id = team_project.member AND pr_id = '$prj') AS a RIGHT OUTER JOIN (SELECT * FROM users) AS b ON a.user_id = b.user_id WHERE a.pr_id IS null;", $link);
		$result = mysql_fetch_assoc($query);

		echo "[";

		while ($result) {

			echo "{";
			echo "\"user_id\" :\"".$result["user_id"]."\",";
			echo "\"user_name\" :\"".$result["user_name"]."\",";
			echo "\"first_name\" :\"".$result["first_name"]."\",";
			echo "\"last_name\" :\"".$result["last_name"]."\"";
			echo "}";

			$result = mysql_fetch_assoc($query);
			if ($result) {
				echo ",";
			}
		}

		echo "]";

	}

	//create a new project
	if (isset($_REQUEST['newProject'])) {
		# code...
		if (isset($_REQUEST['title'])) {
			$title = $_REQUEST['title'];
			// echo $title;
		}
		if (isset($_REQUEST['description'])) {
			$description = $_REQUEST['description'];
			// echo $description;
		}
		// if(isset($_REQUEST['owner_id'])){
			$owner_id = 1; // $_REQUEST['owner_id']; hard coded for now
		// }

		$query = "INSERT INTO projects (title, description, file_01, file_02) VALUES ('$title', '$description', null, null)";
		mysql_query($query, $link);

		//retrieve the id of the newly created project
		// and create a new team project with it
		$project_query = mysql_query("SELECT pr_id FROM projects WHERE title = '$title' AND description = '$description'", $link);
		$project = mysql_fetch_assoc($project_query);
		echo $project['pr_id'];
		$new_project = $project['pr_id'];

		$tproject_query = "INSERT INTO team_project (member, project, clearance) VALUES ('$owner_id', '$new_project', 'owner')";
		mysql_query($tproject_query, $link);
	}

	//add a member to a project
	if (isset($_REQUEST['add_member'])) {
		# code...
		if (isset($_REQUEST['member'])) {
			$member = $_REQUEST['member'];
		}
		if (isset($_REQUEST['project'])) {
			$project = $_REQUEST['project'];
		}
		if (isset($_REQUEST['clearance'])) {
			$clearance = $_REQUEST['clearance'];
		}

		$query = "INSERT INTO team_project (member, project, clearance) VALUES ('$member', '$project', '$clearance')";
		
		mysql_query($query, $link);
	}

	//create && assign a task to a project member
	if (isset($_REQUEST['assignTask'])) {
		# code...

		if (isset($_REQUEST['message'])) {
			$message = $_REQUEST['message'];
			// echo $message;
		}
		if (isset($_REQUEST['deadline_day'])) {
			$dday = $_REQUEST['deadline_day'];
			// echo "\n".$dday;
		}
		if (isset($_REQUEST['deadline_time'])) {
			$dtime = $_REQUEST['deadline_time'];
			// echo "\n".$dtime;
		}
		if (isset($_REQUEST['assignee'])) {
			$assignee = $_REQUEST['assignee'];
			// echo "\n".$assignee;
		}
		if (isset($_REQUEST['a_project_id'])) {
			$a_project_id = $_REQUEST['a_project_id'];
			// echo "\n".$a_project_id;
		}

		$query = "INSERT INTO tasks (message, deadline_day, deadline_time, assignee, project) VALUES ('$message', '$dday', '$dtime', '$assignee', '$a_project_id')";

		mysql_query($query, $link);
	}

	//parse list of tasks of all members
	if (isset($_REQUEST['list_tasks'])) {
		
		if (isset($_REQUEST['lt_project_id'])) {
			# code...
			$prj = $_REQUEST['lt_project_id'];
		}

		$query = mysql_query("SELECT * FROM tasks, users WHERE tasks.assignee = users.user_id AND tasks.project = '$prj';", $link);
		$result = mysql_fetch_assoc($query);

		echo "[";

		while ($result) {

			echo "{";
			echo "\"message\" :\"".$result["message"]."\",";
			echo "\"deadline_day\" :\"".$result["deadline_day"]."\",";
			echo "\"deadline_time\" :\"".$result["deadline_time"]."\",";
			echo "\"assignee\" :\"".$result["assignee"]."\",";
			echo "\"time_assigned\" :\"".$result["time_assigned"]."\",";
			echo "\"first_name\" :\"".$result["first_name"]."\",";
			echo "\"last_name\" :\"".$result["last_name"]."\"";
			echo "}";

			$result = mysql_fetch_assoc($query);
			if ($result) {
				echo ",";
			}
		}

		echo "]";

	}

?>