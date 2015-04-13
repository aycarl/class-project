<?php
	//if the form has been submitted, then
	// 	call login function
	//	if login function return true 
	//		start session 
	//		load user profile into session 
	//		redirect to home page
	//	else
	//		set error
	//		show the login form
	//	end if
	//else 
	//	show the login form
	$msg="Login";
	if(isset($_POST['username'])){
		//the login form has been submitted
		$username=$_POST['username'];
		$password=$_POST['password'];
        // $continue = true;
		//call login to check username and password
		if(login($username,$password)){ //$continue
			session_start();	//initiate session for the current login
			loadUserProfile($username);	//load user information into the session
			header("location: index.php");	//redirect to home page
			echo "<a href='index.php'>click here</a>";	//if redirect fails, provide a link
			exit();
		}else{
			//if login returns false, then something is worng
			$msg="username or password is wrong";
		}
	}
	
	
?>
<html>
<head>
	<title>Login</title>
    <!-- <link rel="stylesheet" href="style.css"> -->
</head>
<body>
    <div id="divContent">

        <form action="login.php" method="POST">
            <table border="1" align="center" width="50%" id="margin">
                <tr><td>
                    <table  align="center" width="80%">
                        <tr >
                            <tr >
                                <td width="30%"></td>
                                <td colspan="2" align="center"><span><?php echo $msg ?></span></td>
                                <td width="30%"></td>
                            </tr>
                            <tr>
                                <td width="30%"></td>
                                <td >username</td>
                                <td><input type="text" name="username" ></td>
                                <td width="30%"></td>
                            </tr>
                            <tr>
                                <td width="30%"></td>
                                <td >password</td>
                                <td><input type="password" name="password" ></td>
                                <td  width="30%"></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td><input type="submit" name="submit" value="login"></td>
                                <td></td>
                            </tr>
                        </tr>
                    </table>
                </td></tr>
            </table>
            </form>
        </form>

    </div>
</body>
</html>

<?php

	function login($username, $password){

        include("users.php");
        $user = new users();

        if(!$user -> get_userby_username_password($username,$password)){
            // echo $password;
            return false;
        }else{
            return true;
        }
	}
	
	function loadUserProfile($username){

        
        // include("users.php");
        $user = new users();
		//load username and other informaiton into the session 
		//the user informaiton comes from the database
		$_SESSION['username'] = $username;

		$_SESSION['usertype'] = $user->get_user_clearance($username);

        $_SESSION['user_id'] = $user->get_user_id($username);

	}

    // //creates new user
    // function createNewUser(){
    //     include("users.php");

    //     $user = new users();

    //     $user->create_user($firstname, $lastname, $username, $password, $authority);
    // }
?>