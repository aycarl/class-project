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
      <!-- <script src="js/project_info_display.js"></script> -->

      <script type="text/javascript">

var localURL = "projects_info.php?";
var currentProjectId;
var currentProjectMember;

currentProjectMember = "<?php echo $_SESSION['username']; ?>";

$(document).ready(function(){
    //update projects if logged in otherwise display pubic projects
    displayProjects();
    displayNotifications();
    document.getElementById('user_s_name').innerHTML = "<?php echo $_SESSION['username']; ?>";
});

//SyncAjax function
function syncAjax(u){
    u = localURL + u;
    console.log(u + ' is being accessed!');
    var obj=$.ajax( {url:u, async:false} );
    return $.parseJSON(obj.responseText);
}

//display public projects
function displayProjects(){
    console.log("the displayProjects function was executed!");
    // alert(currentProjectMember + " is the current user!");


    var pd = document.getElementById("openProjects");

    var pdInfo;

    var pData = syncAjax("projects&user_info="+currentProjectMember);

    console.log(pData + ' is displayed')

    if (pData.length > 0) {
        pdInfo = '<div class = "list-group" id = "openProjects">';
        
        for (var i = 0; i < pData.length; i++) {
            // pdInfo += '<div onclick="project_info('+ pData[i].id +')"><b><h3>'+ pData[i].title +'</h3></b></div>';
            // pdInfo += '<p><small>'+pData[i].description+'</small></p>';
            pdInfo += '<a class="list-group-item" onclick="project_info('+ pData[i].id +')"><div class="row"><div class="col-sm-12"><h4 class="list-group-item-heading">'+ pData[i].title +'</h4><p class="list-group-item-text"><small>'+pData[i].description+'</small></p></div></div></a>';
        };

        //Button trigger modal
        // pdInfo += '<button type="button" class="btn btn-sm btn-default btn-block" data-toggle="modal" data-target="#newProjectModal">create new project</button>';
        // pdInfo += '<a class="list-group-item" data-toggle="modal" data-target="#newProjectModal"><div class="row<div class="col-sm-12"><i class="fa fa-plus"></i><span>New Project</span></div></div></a>';
        pdInfo += '</div>';
    }
    //check for the display of the json object
    console.log("this function was executed again!"+pData);

    $("#openProjects").replaceWith(pdInfo);

}

//display the information of a single project
function project_info(id){
    console.log("display single project info!");

    var spData = syncAjax("project_id="+id);

    var spInfo;

    console.log("project_id="+id);

    console.log(spData);

    spInfo = '<div  class = "col-lg-12" id="basicDetails">';
    spInfo += '<h3>'+ spData.title +'</h3>';
    spInfo += '<p>'+ spData.description +'</p>';
    spInfo += '<p>'+ spData.file_01 +'</p>';
    spInfo += '<p>'+ spData.file_02 +'</p>';
    spInfo += '<p>'+ spData.date_created +'</p>';
    spInfo += '</div>';

    $("#basicDetails").replaceWith(spInfo);
    project_members(id);
    displayTasks();
    currentProjectId = id;
}

//display members of project id
function project_members(id){
    console.log("list members of project " + id);

    var mData = syncAjax("list_project_members&team_project_id=" +id);
    console.log(mData);

    var mInfo = '<div  class = "col-lg-12" id="memberDetails">';
    mInfo += '<h3>Members</h3>';
    mInfo += '<ul>';
    
    for (var i = 0; i < mData.length; i++) {
        
        mInfo += '<li> <a data-toggle="modal" data-target="#assignTaskModal" ><b onclick=\"curMember('+mData[i].user_id+')\">'+mData[i].first_name+' '+mData[i].last_name+'</b> '+mData[i].clearance+'</a></li>';
        //'+mData[i].user_name+'
    };
    mInfo += '</ul>';
    mInfo += '<button type="button" class="btn btn-sm btn-default btn-block" data-toggle="modal" data-target="#addNewMemberModal">add new member</button>';
    mInfo += '</div>';
    $("#memberDetails").replaceWith(mInfo);
    non_project_members(id);
    currentProjectId = id;
    displayTasks();
}

//display non members of project id
function non_project_members(id){
    console.log("list non members of project " + id);

    var nmData = syncAjax("list_non_project_members&t_project_id=" +id);
    console.log(nmData);

    var nmInfo = '<div class="form-group" id="nonMembers">';
    
    for (var i = 0; i < nmData.length; i++) {
        
        nmInfo += '<div class="checkbox">';
            nmInfo += '<label>';
                nmInfo += '<input type="checkbox" value="" onclick="new_project_member('+nmData[i].user_id+')">';
                nmInfo += ''+nmData[i].first_name+'     '+nmData[i].last_name+' ';
            nmInfo += '</label>';
        nmInfo += '</div>';

    };
    
    nmInfo += '</div>';
    $("#nonMembers").replaceWith(nmInfo);
}

//add new member to projedt = currentProjectId
function new_project_member(userId){
    console.log("adding new member to " + currentProjectId);

    var user_id = userId;

    syncAjax("add_member&member="+user_id+"&project="+currentProjectId+"&clearance=regular");
    project_members(id);
}

//create a new project -- yet to be fully implement
function createProject(){
    console.log('not yet people! :');
    var title = document.getElementById('inputProjectTitle').value;
    var description = document.getElementById('inputProjectDescription').value;
    syncAjax("newProject&title="+title+"&description="+description);
    alert("New project successfully added! \n but without a file!");
    displayProjects();
}

//assign a task
function assignTask(){
    //('$message', '$deadline_day', '$deadline_time', '$assignee', '$project')
    //deadlineDay, deadlineTime, inputTaskDescription
    var day = document.getElementById('deadlineDay').value;
    var time = document.getElementById('deadlineTime').value;
    var message = document.getElementById('inputTaskDescription').value;
    var a_project_id = currentProjectId;
    var assignee = currentProjectMember;
    document.getElementById("taskForm").reset();
    syncAjax("assignTask&deadline_time="+time+"&deadline_day="+day+"&message="+message+"&a_project_id="+a_project_id+"&assignee="+assignee);
    console.log("Task assigned to user" + 1);
    displayTasks();
}

//set current member var
function curMember(memID){
    // alert("member ID " + memID + " has been set!");
    currentProjectMember = memID;
}

//display tasks
function displayTasks(){
    console.log("display tasks for each group member in project " + currentProjectId);

    var tData = syncAjax("list_tasks&lt_project_id=" +currentProjectId);
    console.log(tData);

    var tInfo = '<div  class = "col-lg-12" id="projectTasks">';
    tInfo += '<h3>Tasks</h3>';
    tInfo += '<ul>';
    
    for (var i = 0; i < tData.length; i++) {
        
        tInfo += '<li>\"'+tData[i].message+'\" asigneed to <b>'+ tData[i].first_name +'     '+ tData[i].last_name +'</b>\n at '+ tData[i].time_assigned +'</li>';
        
    };
    tInfo += '</ul>';
    // tInfo += '<button type="button" class="btn btn-sm btn-default btn-block" data-toggle="modal" data-target="#assignTaskModal">Task</button>';
    tInfo += '</div>';
    $("#projectTasks").replaceWith(tInfo);
    // alert("tasks are being displayed");
    // currentProjectId = id;
}

//display tasks for personal notifications
function displayNotifications(){
    console.log("display all tasks for current member in project ");

    var tData = syncAjax("notifications&p_user_info=" +currentProjectMember);
    console.log(tData);

    var tInfo = '<div  class = "col-lg-12" id="projectTasks">';
    tInfo += '<h3>Tasks</h3>';
    tInfo += '<ul>';
    
    for (var i = 0; i < tData.length; i++) {
        
        tInfo += '<li> Complete\"'+tData[i].message+'\" <b>\n by '+ tData[i].deadline_time + ' on ' + tData[i].deadline_day+'</b></li>';
        
    };
    tInfo += '</ul>';
    // tInfo += '<button type="button" class="btn btn-sm btn-default btn-block" data-toggle="modal" data-target="#assignTaskModal">Task</button>';
    tInfo += '</div>';
    document.getElementById('notificationCount').innerHTML = tData.length;
    $("#notifications").replaceWith(tInfo);
    // alert("tasks are being displayed");
    // currentProjectId = id;
}

function joinProject(){
  var projectID = document.getElementById('pID').value;
  // var projectName = document.getElementById('pName').value;
  document.getElementById("projectForm").reset();
  if (projectID != null) {
    syncAjax("add_member&member="+currentProjectMember+"&project="+projectID+"&clearance=regular");
  } else {
    alert('Enter a project ID!');
  };
}

      </script>

  </head>
  <body>
      <!-- Navbar -->
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="./index.php"><i class="fa fa-home fa-lg"></i>Class Project</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
          <ul class="nav navbar-nav">
            <li class="title"><a href="./#" data-toggle="modal" data-target="#joinProjectModal">Join a project</a></li>
            <!-- <li><a href="./start_a_project.php">Start a project</a></li>
            <li><a href="./howitworks.php">How it works</a></li> -->
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <li><a class="btn pull-right">Welcome <b><span id="user_s_name"></span></b></a></li>
            <li><a class="btn pull-right">Notifications <b><span id="notificationCount"></span></b></a></li>
            <li><a href="logout.php" class="btn pull-right">Log out</a></li>
            <li></li>
          </ul>
        </div><!-- /.navbar-collapse -->
      </div><!-- /.container-fluid -->
    </nav>


          <div class="container-fluid">
              <div class="row">
                  <!-- <div class = "col-lg-4" >
                  </div> -->
                  <div class = "col-lg-6" >
                      <div class="panel-body">
                          <div class="row">
                              <div class="col-xs-9">
                                <h4>My Projects</h4>
                                <!-- <div class="form-group">
                                    <input type="text" class="form-control" placeholder="Search Projects...">
                                    <i class="fa fa-search"></i>
                                </div> -->
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
<?php 
  include 'footer.html';
?>