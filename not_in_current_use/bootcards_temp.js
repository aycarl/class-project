<div class="list-group">

  '<a class="list-group-item" onclick="project_info('+ pData[i].id +')">
    <div class="row">
      <div class="col-sm-6">
        <!-- <i class="fa fa-3x fa-building-o pull-left"></i> -->
        <h4 class="list-group-item-heading">'+ pData[i].title +'</h4>
        <p class="list-group-item-text"><small>'+pData[i].description+'</small></p>
      </div>
    </div>
  </a>'

  '<a class="list-group-item" data-toggle="modal" data-target="#newProjectModal">
      <div class="row">
        <div class="col-sm-6">
          <i class="fa fa-plus"></i>
          <span>New Project</span>
        </div>
      </div>
    </a>'

  ...

</div>

<div class="panel panel-default">

  <div class="panel-heading clearfix">
    <h3 class="panel-title pull-left">Notes</h3>

    <div class="btn-group pull-right">
      <a class="btn btn-primary" href="#"
        data-toggle="modal"
        data-target="#editModal">
          <i class="fa fa-plus"></i>
          <span>Add</span>
      </a>
    </div>
    
  </div>

  <div class="list-group">

    <a class="list-group-item pjax" href="/notes/id">
      <i class="fa fa-phone fa-2x pull-left"></i>
      <h4 class="list-group-item-heading">Subject</h4>
      <p class="list-group-item-text">Date</p>
    </a>
    
    <a class="list-group-item pjax" href="/notes/id">
      <i class="fa fa-phone fa-2x pull-left"></i>
      <h4 class="list-group-item-heading">Subject</h4>
      <p class="list-group-item-text">Date</p>
    </a>

    ...
    
  </div>
  
  <div class="panel-footer">
    <small class="pull-left">List Card Footer</small>
  </div>  

</div>