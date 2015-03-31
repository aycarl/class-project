<?php
    session_start();    //start session
    if(!isset($_SESSION['username'])){  //check if the user data is in the session
        header("location: login.php");  //if not redirect back to user
    }
?>
<html>
  <head>

      <title>Class Project Home</title>

      <!-- Bootstrap Core CSS -->
      <link href="css/bootstrap.min.css" rel="stylesheet">

      <!-- Bootcards Core CSS -->
      <!-- <link href="css/bootcards.css" rel="stylesheet"> -->

      <!-- Bootcards Desktop Core CSS -->
      <link href="css/bootcards-desktop.css" rel="stylesheet">

      <!-- jQuery -->
      <script src="js/jquery.js"></script>

      <!-- Bootstrap Core JavaScript -->
      <script src="js/bootstrap.min.js"></script>

      <!-- Bootcards Core JavaScript -->
      <script src="js/bootcards.js"></script>

      <!-- self written javascipt function-->
      <script src="js/project_info_display.js"></script>

  </head>
    <body>
        <nav class="navbar navbar-default">
          <div class="container-fluid container">
              <a href="logout.php" class="btn btn-default navbar-btn navbar-right">Log out</a>
          </div><!-- /.container-fluid -->
        </nav>
        <div class="container-fluid container">
            <!-- <div class="row"> -->
                <!-- <div class="col-lg-12"> -->
                    <!-- <div class="title"> -->
                        <!-- <h1>Class Project</h1> -->
                    <!-- </div> -->
                <!-- </div> -->
            <!-- </div> -->
            <div class="row">
                <div class = "col-lg-6" >
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-xs-9">
                              <div class="form-group">
                                  <input type="text" class="form-control" placeholder="Search Projects...">
                                  <i class="fa fa-search"></i>
                              </div>
                            </div>
                            <div class="col-xs-3">
                                <a class="btn btn-primary btn-sm" data-toggle="modal" data-target="#newProjectModal">
                                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 
                                    <span>New Project</span>
                                </a>
                            </div>
                        </div>              
                    </div>
                    <div id="openProjects">

                    </div>
                </div>
                <div class = "col-lg-6" id="projectDetails">
                    <div class = "col-lg-12" id="basicDetails"></div>
                    <div class = "col-lg-12" id="memberDetails"></div>
                    <div class = "col-lg-12" id="projectTasks"></div>
                </div>
            </div>
        </div>
        <!-- add a new project modal -->
        <div class="modal fade" id="newProjectModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">New Class Project</h4>
              </div>
              <div class="modal-body">
                <form action="upload.php" method="post" enctype="multipart/form-data" id="newProject">
                  <div class="form-group">
                    <label for="inputProjectTitle">Title</label>
                    <input type="text" class="form-control" id="inputProjectTitle" placeholder="Enter project title">
                  </div>
                  <div class="form-group">
                    <label for="inputProjectDescription">Description</label>
                    <textarea class="form-control" rows="3" id="inputProjectDescription" placeholder="some description will do"></textarea>
                    <!-- <input type="password" class="form-control" > -->
                  </div>
                  <div class="form-group">
                    <label for="inputFile">File input</label>
                    <input type="file" name="fileToUpload" id="exampleInputFile">
                    <p class="help-block">upload your first file (optional)</p>
                  </div>
                  <input type="submit" value="Upload Image" name="submit">
                  <button type="button" class="btn btn-primary" onclick="createProject()">Save</button>
                </form>
              </div>
              <!-- <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              </div> -->
            </div>
          </div>
        </div>
        <!-- add a new member -->
        <div class="modal fade" id="addNewMemberModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">New Member</h4>
              </div>
              <div class="modal-body">
                  <div class="form-group" id="nonMembers">
                    ...
                  </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <!-- <button type="button" class="btn btn-primary" onclick="new_project_member()">Add</button> -->
              </div>
            </div>
          </div>
        </div>
        <!-- assign a task to a member -->
        <div class="modal fade" id="assignTaskModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">New task</h4>
              </div>
              <div class="modal-body">
                  <form id="taskForm">
                    <div class="form-group" id="members">
                    <label for="inputTaskDescription">Task details</label>
                    <textarea class="form-control" rows="3" id="inputTaskDescription" placeholder="What should he/she do?"></textarea>
                  </div>
                  <div class="form-group" id="deadlineDateAndTime">
                    <label for="deadline">Deadline</label>
                    <input type="date" name="deadlineDay" id="deadlineDay">
                    <input type="time" name="deadlineTime" id="deadlineTime"> 
                  </div>
                  </form> 
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="assignTask()">Assign</button>
              </div>
            </div>
          </div>
        </div>
    </body>
</html>