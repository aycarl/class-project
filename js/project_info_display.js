
var localURL = "projects_info.php?";
var currentProjectId;
var currentProjectMember;

$(document).ready(function(){
    //update projects if logged in otherwise display pubic projects
    displayProjects();
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

    var pd = document.getElementById("openProjects");

    var pdInfo;

    var pData = syncAjax("projects");

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
    syncAjax("assignTask&deadline_time="+time+"&deadline_day="+day+"&message="+message+"&a_project_id="+a_project_id+"&assignee="+assignee);
    console.log("Task assigned to user" + 1);
    document.getElementById("taskForm").reset();
    displayTasks();
}

//set current member var
function curMember(memID){
    alert("member ID " + memID + " has been set!");
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
        
        tInfo += '<li>'+tData[i].message+' asigneed to <b>'+ tData[i].first_name +'     '+ tData[i].last_name +'</b>\n at '+ tData[i].time_assigned +'</li>';
        
    };
    tInfo += '</ul>';
    // tInfo += '<button type="button" class="btn btn-sm btn-default btn-block" data-toggle="modal" data-target="#assignTaskModal">Task</button>';
    tInfo += '</div>';
    $("#projectTasks").replaceWith(tInfo);
    // alert("tasks are being displayed");
    currentProjectId = id;
}




                        // <div class="panel panel-default">

                        //   <div class="panel-heading clearfix">
                        //     <h3 class="panel-title pull-left">Notes</h3>

                        //     <div class="btn-group pull-right">
                        //       <a class="btn btn-primary" href="#"
                        //         data-toggle="modal"
                        //         data-target="#editModal">
                        //           <i class="fa fa-plus"></i>
                        //           <span>Add</span>
                        //       </a>
                        //     </div>
                            
                        //   </div>

                        //   <div class="list-group">

                        //     <a class="list-group-item pjax" href="/notes/id">
                        //       <h4 class="list-group-item-heading">Subject</h4>
                        //       <p class="list-group-item-text">Date</p>
                        //     </a>
                            
                        //     <a class="list-group-item pjax" href="/notes/id">
                        //       <h4 class="list-group-item-heading">Subject</h4>
                        //       <p class="list-group-item-text">Date</p>
                        //     </a>
                            
                        //   </div>
                          
                        // </div>