<?php
	include 'thread_comments.php';

	$comments = array(  array('id'=>1, 'parent_id'=>NULL,   'text'=>'Parent'),  
	                    array('id'=>2, 'parent_id'=>1,      'text'=>'Child'),  
	                    array('id'=>3, 'parent_id'=>2,      'text'=>'Child Third level'),  
	                    array('id'=>4, 'parent_id'=>NULL,   'text'=>'Second Parent'),  
	                    array('id'=>5, 'parent_id'=>4,   'text'=>'Second Child')  
	                );  
	  
	$threaded_comments = new Threaded_comments($comments);  
	  
	$threaded_comments->print_comments();
?>