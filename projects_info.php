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
		
		$query = mysql_query("SELECT * FROM projects", $link);
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
			echo "\"date_created\" :\"".$result["date_created"]."\"";
			echo "}";

			$result = mysql_fetch_assoc($query);
			if ($result) {
				echo ",";
			}
			$rowCount++;

		}

		echo "]";
	}

	if (isset($_REQUEST['project_id'])) {
		
		$prj = $_REQUEST['project_id'];

		// echo "<script>console.log('inside yes!')</script>";

		$query = mysql_query("SELECT * FROM projects WHERE pr_id = '$prj'", $link);
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

	// elseif (isset($_REQUEST[''])) {
	// 	# code...
	// }
?>