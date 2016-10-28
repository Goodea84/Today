<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sing - Time Line</title>
    <link href="css/application.min.css" rel="stylesheet">
    <!-- as of IE9 cannot parse css files with more that 4K classes separating in two files -->
    <!--[if IE 9]>
        <link href="css/application-ie9-part2.css" rel="stylesheet">
    <![endif]-->
    <link rel="shortcut icon" href="img/favicon.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <script>
        /* yeah we need this empty stylesheet here. It's cool chrome & chromium fix
         chrome fix https://code.google.com/p/chromium/issues/detail?id=167083
         https://code.google.com/p/chromium/issues/detail?id=332189
         */
    </script>
   	<script src="script/jquery-3.1.0.min.js" type="text/javascript"></script> 
	<script src="script/jquery-ui.min.js" type="text/javascript"></script> 
	<script src="https://rawgit.com/fyneworks/multifile/2.1.0-preview/jquery.MultiFile.js" type="text/javascript"></script>
	<script src="script/jquery.form.min.js" type="text/javascript"></script>
	<script>
		$(function(){
			$.ajax({
				url: 'printImage',
				method: 'post',
				success: function(resp){
					var list = resp.list_image;
					$.each(list, function(index, val){
						$('#test12').append(
							"<img width='150px' height='150px' src='image/"+list[index].photo+"' alt='...'/>"
						);//append
					});//for-each
				}//success
			});//ajax
		});//onload
	</script>
</head>
<body>
<!--
  Main sidebar seen on the left. may be static or collapsing depending on selected state.

    * Collapsing - navigation automatically collapse when mouse leaves it and expand when enters.
    * Static - stays always open.
-->
<nav id="sidebar" class="sidebar" role="navigation">
    <!-- need this .js class to initiate slimscroll -->
    <div class="js-sidebar-content">
        <header class="logo hidden-xs">
            <a href="index.html">sing</a>
        </header>
        <!-- seems like lots of recent admin template have this feature of user info in the sidebar.
             looks good, so adding it and enhancing with notifications -->
        <div class="sidebar-status visible-xs">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <span class="thumb-sm avatar pull-right">
                    <img class="img-circle" src="demo/img/people/a5.jpg" alt="...">
                </span>
                <!-- .circle is a pretty cool way to add a bit of beauty to raw data.
                     should be used with bg-* and text-* classes for colors -->
                <span class="circle bg-warning fw-bold text-gray-dark">
                    13
                </span>
                &nbsp;
                Philip <strong>Smith</strong>
                <b class="caret"></b>
            </a>
            <!-- #notifications-dropdown-menu goes here when screen collapsed to xs or sm -->
        </div>
        <!-- main notification links are placed inside of .sidebar-nav -->
        <ul class="sidebar-nav">
          <li>
              <a href="index">
                  <span class="icon"><i class="glyphicon glyphicon-map-marker"></i></span>
                  Maps
              </a>
          </li>
          <li class="active">
              <a href="page_moveTo_gallery">
                  <span class="icon"><i class="glyphicon glyphicon-inbox"></i></span>
                  My Card
              </a>
         	</li>
       </ul>
    </div>
</nav>
<!-- This is the white navigation bar seen on the top. A bit enhanced BS navbar. See .page-controls in _base.scss. -->
<nav class="page-controls navbar navbar-default">
    <div class="container-fluid">
        <!-- .navbar-header contains links seen on xs & sm screens -->
        <div class="navbar-header">
            <ul class="nav navbar-nav">
                <li>
                    <!-- whether to automatically collapse sidebar on mouseleave. If activated acts more like usual admin templates -->
                    <a class="hidden-sm hidden-xs" id="nav-state-toggle" href="#" title="Turn on/off sidebar collapsing" data-placement="bottom">
                        <i class="fa fa-bars fa-lg"></i>
                    </a>
                    <!-- shown on xs & sm screen. collapses and expands navigation -->
                    <a class="visible-sm visible-xs" id="nav-collapse-toggle" href="#" title="Show/hide sidebar" data-placement="bottom">
                        <span class="rounded rounded-lg bg-gray text-white visible-xs"><i class="fa fa-bars fa-lg"></i></span>
                        <i class="fa fa-bars fa-lg hidden-xs"></i>
                    </a>
                </li>
				<!-- 왼쪽 상단 리프레시 / 취소 -->
                <li class="ml-sm mr-n-xs hidden-xs"><a href="page_moveTo_gallery"><i class="fa fa-refresh fa-lg"></i></a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right visible-xs">
                <li>
                    <!-- toggles chat -->
                    <a href="#" data-toggle="chat-sidebar">
                        <span class="rounded rounded-lg bg-gray text-white"><i class="fa fa-globe fa-lg"></i></span>
                    </a>
                </li>
            </ul>
            <!-- xs & sm screen logo -->
            <a class="navbar-brand visible-xs" href="index">
                <i class="fa fa-circle text-gray mr-n-sm"></i>
                <i class="fa fa-circle text-warning"></i>
                &nbsp;
                sing
                &nbsp;
                <i class="fa fa-circle text-warning mr-n-sm"></i>
                <i class="fa fa-circle text-gray"></i>
            </a>
        </div>

        <!-- this part is hidden for xs screens -->
        <div class="collapse navbar-collapse">
            <!-- search form! link it to your search server -->
            <div class="navbar-form navbar-left">
                <div class="form-group">
                    <div class="input-group input-group-no-border">
                        <span class="input-group-addon">
                            <i class="fa fa-map-marker"></i>
                        </span>
						<!-- 지역(local) 검색 input tag -->
                        <input class="form-control" type="text" id="searchLocal" name="searchLocal" placeholder="카드 검색">
                    </div>
                </div>
            </div>
            <ul class="nav navbar-nav navbar-right">
            <s:if test="#session.loginId != null">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle dropdown-toggle-notifications" id="notifications-dropdown-toggle" data-toggle="dropdown">
                        <span class="thumb-sm avatar pull-left">
                        	<!-- 상단 이미지  -->
                        </span>
                        &nbsp;
						<strong><s:property value="#session.loginName" /></strong>&nbsp;
                        <span class="circle bg-warning fw-bold">
                            13
                        </span>
                        <b class="caret"></b></a>
                    <!-- ready to use notifications dropdown.  inspired by smartadmin template.
                         consists of three components:
                         notifications, messages, progress. leave or add what's important for you.
                         uses Sing's ajax-load plugin for async content loading. See #load-notifications-btn -->
                    <div class="dropdown-menu animated fadeInUp" id="notifications-dropdown-menu">
                        <section class="panel notifications">
                            <header class="panel-heading">
                                <div class="text-align-center mb-sm">
                                    <strong>여기서 카드를 사용할까 도우까...</strong>
                                </div>
                                <div class="btn-group btn-group-sm btn-group-justified" id="notifications-toggle" data-toggle="buttons">
                                    <label class="btn btn-default active">
                                        <!-- ajax-load plugin in action. setting data-ajax-load & data-ajax-target is the
                                             only requirement for async reloading -->
                                        <input type="radio" checked
                                               data-ajax-trigger="change"
                                               data-ajax-load="demo/ajax/notifications.html"
                                               data-ajax-target="#notifications-list"> Notifications
                                    </label>
                                    <label class="btn btn-default">
                                        <input type="radio"
                                               data-ajax-trigger="change"
                                               data-ajax-load="demo/ajax/messages.html"
                                               data-ajax-target="#notifications-list"> Messages
                                    </label>
                                    <label class="btn btn-default">
                                        <input type="radio"
                                               data-ajax-trigger="change"
                                               data-ajax-load="demo/ajax/progress.html"
                                               data-ajax-target="#notifications-list"> Progress
                                    </label>
                                </div>
                            </header>
                            <!-- notification list with .thin-scroll which styles scrollbar for webkit -->
                            <div id="notifications-list" class="list-group thin-scroll">
                                <div class="list-group-item">
                                    <span class="thumb-sm pull-left mr clearfix">
                                        <img class="img-circle" src="demo/img/people/a3.jpg" alt="...">
                                    </span>
                                    <p class="no-margin overflow-hidden">
                                        1 new user just signed up! Check out
                                        <a href="#">Monica Smith</a>'s account.
                                        <time class="help-block no-margin">
                                            2 mins ago
                                        </time>
                                    </p>
                                </div>
                                <a class="list-group-item" href="#">
                                    <span class="thumb-sm pull-left mr">
                                        <i class="glyphicon glyphicon-upload fa-lg"></i>
                                    </span>
                                    <p class="text-ellipsis no-margin">
                                        2.1.0-pre-alpha just released. </p>
                                    <time class="help-block no-margin">
                                        5h ago
                                    </time>
                                </a>
                                <a class="list-group-item" href="#">
                                    <span class="thumb-sm pull-left mr">
                                        <i class="fa fa-bolt fa-lg"></i>
                                    </span>
                                    <p class="text-ellipsis no-margin">
                                        Server load limited. </p>
                                    <time class="help-block no-margin">
                                        7h ago
                                    </time>
                                </a>
                                <div class="list-group-item">
                                    <span class="thumb-sm pull-left mr clearfix">
                                        <img class="img-circle" src="demo/img/people/a5.jpg" alt="...">
                                    </span>
                                    <p class="no-margin overflow-hidden">
                                        User <a href="#">Jeff</a> registered
                                        &nbsp;&nbsp;
                                        <button class="btn btn-xs btn-success">Allow</button>
                                        <button class="btn btn-xs btn-danger">Deny</button>
                                        <time class="help-block no-margin">
                                            12:18 AM
                                        </time>
                                    </p>
                                </div>
                                <div class="list-group-item">
                                    <span class="thumb-sm pull-left mr">
                                        <i class="fa fa-shield fa-lg"></i>
                                    </span>
                                    <p class="no-margin overflow-hidden">
                                        Instructions for changing your Envato Account password. Please
                                        check your account <a href="#">security page</a>.
                                        <time class="help-block no-margin">
                                            12:18 AM
                                        </time>
                                    </p>
                                </div>
                                <a class="list-group-item" href="#">
                                    <span class="thumb-sm pull-left mr">
                                        <span class="rounded bg-primary rounded-lg">
                                            <i class="fa fa-facebook text-white"></i>
                                        </span>
                                    </span>
                                    <p class="text-ellipsis no-margin">
                                        New <strong>76</strong> facebook likes received.</p>
                                    <time class="help-block no-margin">
                                        15 Apr 2014
                                    </time>
                                </a>
                                <a class="list-group-item" href="#">
                                    <span class="thumb-sm pull-left mr">
                                        <span class="circle circle-lg bg-gray-dark">
                                            <i class="fa fa-circle-o text-white"></i>
                                        </span>
                                    </span>
                                    <p class="text-ellipsis no-margin">
                                        Dark matter detected.</p>
                                    <time class="help-block no-margin">
                                        15 Apr 2014
                                    </time>
                                </a>
                            </div>
                            <footer class="panel-footer text-sm">
                                <!-- ajax-load button. loads demo/ajax/notifications.php to #notifications-list
                                     when clicked -->
                                <button class="btn btn-xs btn-link pull-right"
                                        id="load-notifications-btn"
                                        data-ajax-load="demo/ajax/notifications.php"
                                        data-ajax-target="#notifications-list"
                                        data-loading-text="<i class='fa fa-refresh fa-spin mr-xs'></i> Loading...">
                                    <i class="fa fa-refresh"></i>
                                </button>
                                <span class="fs-mini">Synced at: 21 Apr 2014 18:36</span>
                            </footer>
                        </section>
                    </div>
                </li>
                
                </s:if>
                <li class="dropdown">
                
                
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="fa fa-cog fa-lg"></i>
                    </a>
                    <s:if test="#session.loginId == null">
                    
                    <ul class="dropdown-menu">
 
                        <li><a class="dropdown-item trigger" href="#"><i class="fa fa-sign-out"></i> &nbsp; Log in</a></li>
                        
                    </ul>
                    </s:if>
                    
                    

                    <s:else>
                                        <ul class="dropdown-menu">
                        <li><a href="#"><i class="glyphicon glyphicon-user"></i> &nbsp; My Account</a></li>
                        <li class="divider"></li>
						<!-- 알림 숫자 개수 나타내는 방법 badge bg-danger animated bounceIn -->
                        <!-- <li><a href="#">Inbox &nbsp;&nbsp;<span class="badge bg-danger animated bounceIn">9</span></a></li> -->
                        <li><a href="customer/logout.action"><i class="fa fa-sign-out"></i> &nbsp; Log Out</a></li>
                    </ul>
                  </s:else> <!-- login menu end jhs -->
                  
                  
                </li>
                <s:if test="#session.loginId != null"><!-- 로그인 돼있을 때 -->
                <li>
                    <a href="#" data-toggle="chat-sidebar">
                        <i class="fa fa-globe fa-lg"></i>
                    </a>
                </li>
                </s:if>
            </ul>
        </div>
    </div>
</nav>
<s:if test="#session.loginId != null"><!-- 로그인 돼있을 때 -->
<div class="chat-sidebar" id="chat">
    <div class="chat-sidebar-content">
        <header class="chat-sidebar-header">
            <h4 class="chat-sidebar-title">Friend Search</h4>
            <div class="form-group no-margin">
                <div class="input-group input-group-dark">
                    <input class="form-control fs-mini" id="chat-sidebar-search" type="text" placeholder="Search...">
                    <span class="input-group-addon">
                        <i class="fa fa-search"></i>
                    </span>
                </div>
            </div>
        </header>
        
        <div class="chat-sidebar-contacts chat-sidebar-panel open">
            <h5 class="sidebar-nav-title">FriendList</h5>
            
            <div class="list-group chat-sidebar-user-group">
            <s:iterator value="flist"> 
            
               <div class="list-group-item">
                <a href="#"><i id="eee" class="glyphicon glyphicon-envelope pull-right" ></i></a>
                <a href="#"><i class="glyphicon glyphicon-info-sign pull-right" ></i></a>
                     <!-- <i class="fa fa-circle text-success pull-right"></i> -->
                     <!-- <i class="fa fa-circle text-success pull-right"></i> -->
                    <span class="thumb-sm pull-left mr">
                        <img id="friendimg" class="img-circle" src="<s:property value='cust_image' />" alt="..." > <!-- 사진 -->
                    </span>
                    <h5 class="message-sender"><s:property value="name" /></h5> <!-- 이름 -->
                   <!--  <p class="message-preview">Hey! What's up? So many times since we</p>  --><!--  프리뷰 -->
                </div>
                         </s:iterator>
               
            </div>
                    </div>
        
    </div>
</div>
</s:if>


<div class="content-wrap">
    <!-- main page content. the place to put widgets in. usually consists of .row > .col-md-* > .widget.  -->
    <main id="content" class="content" role="main">
        <ol class="breadcrumb">
            <li>YOU ARE HERE</li>
            <li class="active">Time Line</li>
        </ol>
        <h1 class="page-title">Events - <span class="fw-semi-bold">Feed</span></h1>
        
        <ul class="timeline">
        
        
            <li class="on-left">
            
                <time class="event-time" datetime="2014-05-19 03:04">
                    <span class="date">yesterday</span>
                    <span class="time">8:03 <span class="fw-semi-bold">pm</span></span>
                </time>
	                <span class="event-icon event-icon-success">
	                    <i class="glyphicon glyphicon-upload"></i>
	                </span>
                <section class="event">
                    <span class="thumb-sm avatar pull-left mr-sm">
                        <img class="img-circle" src="demo/img/people/a2.jpg" alt="...">
                    </span>
                    <h4 class="event-heading"><a href="#">Jessica Nilson</a> <small>@jess</small></h4>
                    <p class="fs-sm text-muted">10:12 am - Publicly near Minsk</p>
                    <div class="event-map" id="test12">
                    
                <!-- 유병훈 사진 올리기 실험 중  -->
                     </div>
           
                
                
   	<div id="overlay_photo"></div> 
	<div id="popup_layer_photo">
                <section class="widget widget-login animated fadeInUp">
                    <header>
                        <h3>Photo Upload</h3>
                    </header>
                    <div class="widget-body">
                          <form id="uploadPic" action="userImage" method="post" theme="simple" enctype="multipart/form-data">           
							<br/><br/>
	                    	<input type="file" id="upload" name="userImage" multiple class="multi with-preview" maxlength="2" accept="gif|jpg|png"/>
		                	<input type="submit" value="등록"/>
	                    </form>
                    </div>
                </section>
	</div>
	

               	<!-- 유병훈 사진 올리기 실험 중  -->
                   
                   
                   
                    <footer>
                        <ul class="post-links">
                            <li><a href="#">1 hour</a></li>
                            <li><a href="#"><span class="text-danger"><i class="fa fa-heart"></i> Like</span></a></li>
                            <li><a href="#">Comment</a></li>
                            <li><a id="photo_upload" href="#"><span class="text-danger"><i class="fa fa-file-photo-o"></i> Photo</span></a>
                        </ul>
                        <ul class="post-comments">
                            <li>
                                <span class="thumb-xs avatar pull-left mr-sm">
                                    <img class="img-circle" src="demo/img/people/a2.jpg" alt="...">
                                </span>
                                <div class="comment-body">
                                    <h6 class="author fw-semi-bold">Radrigo Gonzales <small>7 mins ago</small></h6>
                                    <p>Someone said they were the best people out there just few years ago. Don't know
                                        better options.</p>
                                </div>
                            </li>
                            <li>
                                <span class="thumb-xs avatar pull-left mr-sm">
                                    <img class="img-circle" src="demo/img/people/a4.jpg" alt="...">
                                </span>
                                <div class="comment-body">
                                    <h6 class="author fw-semi-bold">Ignacio Abad <small>6 mins ago</small></h6>
                                    <p>True. Heard absolutely the same.</p>
                                </div>
                            </li>
                            <li>
                                <span class="thumb-xs avatar pull-left mr-sm">
                                    <img class="img-circle" src="img/avatar.png" alt="...">
                                </span>
                                <div class="comment-body">
                                    <input class="form-control input-sm" type="text" placeholder="Write your comment...">
                                </div>
                            </li>
                        </ul>
                    </footer>
                </section>
            </li>
            <li>
                <time class="event-time" datetime="2014-05-19 03:04">
                    <span class="date">today</span>
                    <span class="time">9:41 <span class="fw-semi-bold">am</span></span>
                </time>
                <span class="event-icon event-icon-primary">
                    <i class="glyphicon glyphicon-comment"></i>
                </span>
                <section class="event">
                    <span class="thumb-sm avatar pull-left mr-sm">
                        <img class="img-circle" src="demo/img/people/a5.jpg" alt="...">
                    </span>
                    <h4 class="event-heading"><a href="#">Bob Nilson</a> <small><a href="#">@nils</a></small></h4>
                    <p class="fs-sm text-muted">February 22, 2014 at 01:59 PM</p>
                    <p class="fs-mini">
                        There is no such thing as maturity. There is instead an ever-evolving process of maturing.
                        Because when there is a maturity, there is ...
                    </p>
                    <footer>
                        <ul class="post-links">
                            <li><a href="#">1 hour</a></li>
                            <li><a href="#"><span class="text-danger"><i class="fa fa-heart"></i> Like</span></a></li>
                            <li><a href="#">Comment</a></li>
                        </ul>
                    </footer>
                </section>
            </li>
            <li class="on-left">
                <time class="event-time" datetime="2014-05-19 03:04">
                    <span class="date">yesterday</span>
                    <span class="time">9:03 <span class="fw-semi-bold">am</span></span>
                </time>
                <span class="event-icon event-icon-danger">
                    <i class="glyphicon glyphicon-cutlery"></i>
                </span>
                <section class="event">
                    <h4 class="event-heading"><a href="#">Jessica Smith</a> <small>@jess</small></h4>
                    <p class="fs-sm text-muted">February 22, 2014 at 01:59 PM</p>
                    <p class="fs-mini">
                        Check out this awesome photo I made in Italy last summer. Seems it was lost somewhere deep inside
                        my brand new HDD 40TB. Thanks god I found it!
                    </p>
                    <div class="event-image">
                        <a href="demo/img/pictures/8.jpg">
                            <img src="demo/img/pictures/8.jpg">
                        </a>
                    </div>
                    <footer>
                        <div class="clearfix">
                            <ul class="post-links mt-sm pull-left">
                                <li><a href="#">1 hour</a></li>
                                <li><a href="#"><span class="text-danger"><i class="fa fa-heart-o"></i> Like</span></a></li>
                                <li><a href="#">Comment</a></li>
                            </ul>

                            <span class="thumb thumb-sm pull-right">
                                <a href="#">
                                    <img class="img-circle" src="demo/img/people/a1.jpg">
                                </a>
                            </span>
                            <span class="thumb thumb-sm pull-right">
                                <a href="#"><img class="img-circle" src="demo/img/people/a5.jpg"></a>
                            </span>
                            <span class="thumb thumb-sm pull-right">
                                <a href="#"><img class="img-circle" src="demo/img/people/a3.jpg"></a>
                            </span>
                        </div>
                        <ul class="post-comments mt-sm">
                            <li>
                                <span class="thumb-xs avatar pull-left mr-sm">
                                    <img class="img-circle" src="demo/img/people/a1.jpg" alt="...">
                                </span>
                                <div class="comment-body">
                                    <h6 class="author fw-semi-bold">Ignacio Abad <small>6 mins ago</small></h6>
                                    <p>Hey, have you heard anything about that?</p>
                                </div>
                            </li>
                            <li>
                                <span class="thumb-xs avatar pull-left mr-sm">
                                    <img class="img-circle" src="img/avatar.png" alt="...">
                                </span>
                                <div class="comment-body">
                                    <input class="form-control input-sm" type="text" placeholder="Write your comment...">
                                </div>
                            </li>
                        </ul>
                    </footer>
                </section>
            </li>
            <li>
                <time class="event-time" datetime="2014-05-19 03:04">
                    <span class="date">yesterday</span>
                    <span class="time">9:03 <span class="fw-semi-bold">am</span></span>
                </time>
                <span class="event-icon">
                    <img class="img-circle" src="img/avatar.png">
                </span>
                <section class="event">
                    <span class="thumb-sm avatar pull-left mr-sm">
                        <img class="img-circle" src="demo/img/people/a6.jpg" alt="...">
                    </span>
                    <h4 class="event-heading"><a href="#">Jessica Smith</a> <small>@jess</small></h4>
                    <p class="fs-sm text-muted">9:03 am - Publicly near Minsk</p>
                    <h4>New <span class="fw-semi-bold">Project</span> Launch</h4>
                    <p class="fs-mini">
                        Let's try something different this time. Hey, do you wanna join us tonight?
                        We're planning to a launch a new project soon. Want to discuss with all of you...
                    </p>
                    <a class="mt-n-xs fs-mini text-muted" href="#">Read more...</a>
                    <footer>
                        <ul class="post-links">
                            <li><a href="#">1 hour</a></li>
                            <li><a href="#"><span class="text-danger"><i class="fa fa-heart-o"></i> Like</span></a></li>
                            <li><a href="#">Comment</a></li>
                        </ul>
                    </footer>
                </section>
            </li>
        </ul>
    </main>
</div>
    		 <script>
		 		$('#uploadPic').ajaxForm({
					//보내기 전 유효성 검사가 필요할 경우
					beforeSubmit: function(data, frm, opt){
						/* 
							**data[index]안에 name, type, value(name, size, type 등 들어있음)
						$.each(data, function(index, val){
							alert(data[index].value.name);
						});
						console.log(data);
						*/
						return true;
					}, 
					//submit 이후 처리
					success: function(data, statusText){
						console.log(data);
						$('#popup_layer_photo, #overlay_photo').hide();
						var photo_array = data.list_savedFile;
							$.each(photo_array, function(index, val){
								$('#test12').append(
										"<img width='150px' height='150px' src='image/"+photo_array[index]+"' alt='...'/>"
								);//append
							});//each
						return false;
					},
					//ajax error
					error: function(e){
						alert('에러 발생');
						console.log(e);
					}
				});//ajaxForm 
             </script>
                
                
	<script>
		$('#photo_upload').on('click', function(){
			$('#popup_layer_photo, #overlay_photo').show(); 
		});//photo_upload clicked,
	
	    $('#overlay_photo, .close').click(function(e){ 
	        e.preventDefault(); 
	        $('#popup_layer_photo, #overlay_photo').hide(); 
	    });//other area clicked,
	    
	</script>


<!-- The Loader. Is shown when pjax happens -->
<div class="loader-wrap hiding hide">
    <i class="fa fa-circle-o-notch fa-spin-fast"></i>
</div>

<!-- common libraries. required for every page-->
<script src="vendor/jquery/dist/jquery.min.js"></script>
<script src="vendor/jquery-pjax/jquery.pjax.js"></script>
<script src="vendor/bootstrap-sass/assets/javascripts/bootstrap/transition.js"></script>
<script src="vendor/bootstrap-sass/assets/javascripts/bootstrap/collapse.js"></script>
<script src="vendor/bootstrap-sass/assets/javascripts/bootstrap/dropdown.js"></script>
<script src="vendor/bootstrap-sass/assets/javascripts/bootstrap/button.js"></script>
<script src="vendor/bootstrap-sass/assets/javascripts/bootstrap/tooltip.js"></script>
<script src="vendor/bootstrap-sass/assets/javascripts/bootstrap/alert.js"></script>
<script src="vendor/slimScroll/jquery.slimscroll.min.js"></script>
<script src="vendor/widgster/widgster.js"></script>
<script src="vendor/pace.js/pace.js" data-pace-options='{ "target": ".content-wrap", "ghostTime": 1000 }'></script>
<script src="vendor/jquery-touchswipe/jquery.touchSwipe.js"></script>

<!-- common app js -->
<script src="js/settings.js"></script>
<script src="js/app.js"></script>

<!-- page specific libs -->
<%-- <script src="http://maps.google.com/maps/api/js?sensor=true"></script>
<script src="vendor/gmaps/gmaps.js"></script> --%>
<script src="vendor/magnific-popup/dist/jquery.magnific-popup.min.js"></script>
<!-- page specific js -->

<script src="js/timeline.js"></script>
</body>
</html>