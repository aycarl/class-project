<?php

	
	define("DB_HOST", 'localhost');
	define("DB_NAME", 'class_project');
	define("DB_PORT", 3306);
	define("DB_USER","root");
	define("DB_PWORD","");

	class users {

		var $link;

		function users() {
			// adb::adb();
			$this->link = false;
			$this->connect();
		}


		//connect to server and database
		function connect(){
			
			$this->link = mysql_connect(DB_HOST, DB_USER, DB_PWORD);
			if (!$this->link) {
				echo "Failed to connect to MySQL server";
				echo mysql_error();
				exit();
			}

			//connect to database
			if (!mysql_select_db(DB_NAME, $this->link)) {
				echo "Failed to select database: ". DB_NAME;
				echo mysql_error();
				exit();
			}

		}
		
		// function get_all_users(){
		// 	$query=("SELECT * FROM users");
		// 	return $this->query($query);
		// }
		
		// function add_user($userId,$firstname,$lastname,$username,$usertype,$pword,$dateCreated){
		// 	$query = ("INSERT INTO users(userId,firstname,lastname,username,usertype,pword,datecreated) values(NULL,'$firstname','$lastname','$username','$usertype','$pword','$dateCreated')");
		// 	return $this->query($query);	
		// }
		
		// function search_user_by_username($username){
		// 	$query = ("SELECT * FROM users WHERE username LIKE '$username%'");
		// 	return $this->query($query);
		// }
		
		// function edit_user($firstname, $lastname,$username,$usertype,$userId){
		// 	$query = ("UPDATE users SET firstname='$firstname' , lastname='$lastname', username='$username', usertype='$usertype' WHERE userId=$userId");
		// 	return $this->query($query);
		// }
		
		// function search_byId($userId){
		// 	$query =("SELECT * FROM users WHERE userId=$userId");
  //           if(!$this->query($query)){
  //               return false;
  //           }
  //           return $this->fetch();
  //       }

        function create_user($firstname, $lastname, $username, $password, $authority){
        	// $this->connect();
            $query = mysql_query("INSERT INTO users(first_name, last_name, user_name, pass_key, authority) VALUES ('$firstname', '$lastname','$username', md5('$password', '$authority')", $this->link);
            $result = mysql_fetch_assoc($query);
            // return $result;

        }

        function get_userby_username_password($username,$password){
        	// $this->connect(); 
            $query = mysql_query("SELECT * FROM users WHERE user_name='$username' AND pass_key='$password'", $this->link);
            $result = mysql_fetch_assoc($query);
            return $result;

        }

		function get_user_clearance($username){
		// 	$this->connect();
			$query = mysql_query("SELECT authority FROM users WHERE user_name = '$username'", $this->link);
			$result = mysql_fetch_assoc($query);
			return $result;
		}

		function get_user_id($username){
        	// $this->connect(); 
            $query = mysql_query("SELECT user_id FROM users WHERE user_name='$username'", $this->link);
            $result = mysql_fetch_assoc($query);
            return $result;

        }

		
		
	/*
	 * Delete or deactivate user by status active/ inactive
	 * assume an admin that adds users and gives passwords
	 * password encryption and decryption
	 * login validation
	 * */
	
	}

