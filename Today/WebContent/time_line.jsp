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
	
	<!-- 유병훈 페이지 열릴 때마다 사진 가져오는 script -->
	<script>
		$(function(){
			var name = '<%= session.getAttribute("loginId") %>';
			$.ajax({
				url: 'printImage',
				method: 'post',
				success: function(resp){
					var list = resp.list_image;
					$.each(list, function(index, val){
						$('#'+list[index].item_id).append(
							"<a class='allImage img_"+list[index].item_id+"' href='#'><img class='demo_image' src='image/"+name+"/"+list[index].item_id+"/"+list[index].photo+"' alt='...'/></a>"
						);//append
					});//for-each
				}//success
			});//ajax
			
			
			

			$(".replyBtn").on('click',function(){
				var appid;
				
				
				  if (this.id == "wreply1") {
					  appid = $('#div1');
				  }
				  if (this.id == "wreply2") {
					  appid = $('#div2');
				  }
				  if (this.id == "wreply3") {
					  appid = $('#div3');
				  }
				  if (this.id == "wreply4") {
					  appid = $('#div4');
				  }
				  if (this.id == "wreply5") {
					  appid = $('#div5');
				  }

				var recontent = $(this).parent().children('#recontent').val();
				var item_id = $(this).parent().children('input[type="hidden"]').val();


				
		 		$.ajax({
					url : "reply"
					, dataType  : "json"
					, data : {"reply.item_id":item_id,"reply.content":recontent}
					, success : function(resp){
						appid.append("<li><span class='thumb-xs avatar pull-left mr-sm'><img class='img-circle' src='"+resp.reply.re_image+"' alt='...'>"
								+"</span><div class='comment-body'><h6 class='author fw-semi-bold'>"+resp.reply.re_name+"<small>"
								+resp.reply.re_date+"</small></h6><p>"+resp.reply.content+"</p></div></li>");

					}
				});
				
				
			});
		});//onload
	</script>
	<!-- 유병훈 페이지 열릴 때마다 사진 가져오는 script 끝 -->
	
</head>
<body>
<!--
  Main sidebar seen on the left. may be static or collapsing depending on selected state.

    * Collapsing - navigation automatically collapse when mouse leaves it and expand when enters.
    * Static - stays always open.
-->

<!-- 사이드바 -->
<nav id="sidebar" class="sidebar" role="navigation">
    <!-- need this .js class to initiate slimscroll -->
    <div class="js-sidebar-content">
        <header class="logo hidden-xs">
            <a href="index"><img src="img/index_logo_min.png"></a>
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
        <br/>
        <h5 class="sidebar-nav-title">Hello <strong><s:property value="#session.loginName" /></strong> <a class="action-link" href="#"><i class="fa fa-map-marker"></i></a></h5>
        <ul class="sidebar-nav">
          <li>
              <a href="index" data-no-pjax>
                  <span class="icon"><i class="glyphicon glyphicon-map-marker"></i></span>
                  Maps
              </a>
          </li>
          <li class="active" data-no-pjax>
              <a href="page_moveTo_gallery">
                  <span class="icon"><i class="glyphicon glyphicon-inbox"></i></span>
                  My Card
              </a>
         	</li>
       </ul>
    </div>
</nav>
<!-- 사이드바 끝 -->

<!-- 상단 바 -->
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
                  
 <!-- 상단 바 끝 -->
 
 <!-- 오른쪽 바 -->                 
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
<!-- 오른쪽 바 끝 -->    

<!-- 메인 내용 -->
<div class="content-wrap">
    <!-- main page content. the place to put widgets in. usually consists of .row > .col-md-* > .widget.  -->
    <main id="content" class="content" role="main">
        <ol class="breadcrumb">
            <li>YOU ARE HERE</li>
            <li class="active">Time Line</li>
        </ol>
        <h1 class="page-title">Events - <span class="fw-semi-bold">Feed</span></h1>
        <ul class="timeline">
        
	        <s:iterator value="itemlist" status="cust_stat"> <!-- 만약 item_id가 1이면 replylist1을 뿌리고.. 이렇게..? -->
	        	<!-- 홀수면 if문 분기처리 -->
		        <s:if test="# cust_stat.odd == true">
		            <li class="on-left"><!-- 아이템노드+사진+댓글 --> <!-- 여기서 왼쪽 오른쪽...... -->
		                <time class="event-time" datetime="2014-05-19 03:04"><!-- 노드부분 -->
		                    <%-- <span class="date">yesterday</span> --%>
		                    <span class="time"><s:property value="title"/></span><!-- 일겹살 뜨는 부분 -->
		                    <%-- <span class="time"><s:property value="item_name"/><span class="fw-semi-bold">am</span></span> --%>
		                </time>
			            
		            	<span class="event-icon event-icon-danger"><!-- 아이콘 (아이템) -->
		                    <i class="glyphicon glyphicon-cutlery"></i>
		                </span>
		                
		                <section class="event"><!-- 사진 담길 곳....... -->
		                    <span class="thumb-sm avatar pull-left mr-sm">
		                        <img class="img-circle" src="demo/img/people/a2.jpg" alt="...">
		                    </span>
		                    <h4 class="event-heading"><a href="#">Jessica Nilson</a> <small>@jess</small></h4>
		                    <p class="fs-sm text-muted">10:12 am - Publicly near Minsk</p>
		                    
		                    <div class="event-map" id='<s:property value="itemlist[#cust_stat.index].item_id"/>'>	
		                    	<a href="#">
		                        	<img class="demo_image" src="demo/img/pictures/8.jpg"/>
		                        </a>
		                    </div>

		                    <footer><!-- 사진 담기는 부분 아래부터 댓글 쓰는 부분까지 -->
			                        <div class="clearfix">
			                            <ul class="post-links mt-sm pull-left">
			                                <li><a href="#">1 hour</a></li>
			                                <li><a href="#"><span class="text-danger"><i class="fa fa-heart-o"></i> Like</span></a></li>
			                                <li><a href="#">Comment</a></li>
			                            </ul>
			                            <ul class="post-links mt-sm pull-right">
		                            		<li>
		                            			<input type="hidden" class="item_no" value='<s:property value="itemlist[#cust_stat.index].item_id"/>'/>
		                            			<a class="photo_upload" href="#"><span class="text-danger"><i class="fa fa-file-photo-o"></i> Photo</span></a><!-- 사진 업로드 버튼 -->
		                            		</li>
		                            	</ul>
		                          	</div> 
		                          	
									<%-- 좋아요 누른 사람들 뜨는 부분 일단 주석 처리 
										<!-- 좋아요 누른 사람들 시작 -->
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
			                            <!-- 좋아요 누른 사람들 끝 --> --%>
		                        
		                        <!-- 댓글 부분 시작 -->
		                        <ul>
		                            <s:if test="iterator_id==1">
		                            <div class="post-comments mt-sm" id=div1>
		                            <s:iterator value="replylist1">
		                            
		                            <li>
		                            	<!-- 댓글 작성자 사진 -->
		                                <span class="thumb-xs avatar pull-left mr-sm">
		                                    <img class="img-circle" src="<s:property value='re_image' />" alt="...">
		                                </span>
		                                <!-- 댓글 내용 -->
		                                <div class="comment-body">
		                                    <h6 class="author fw-semi-bold"><s:property value="re_name" /> <small><s:property value="re_date" /></small></h6>
		                                    <p><s:property value="content" /></p>
		                                </div>
		                            </li>
		                            </s:iterator>
		                            </div>
		                       <div class="post-comments mt-sm">
		                      <li>
		                            	<!-- 댓글 작성란의 쓰는이의 사진 -->
		                                <span class="thumb-xs avatar pull-left mr-sm">
		                                    <img class="img-circle" src="<s:property value="cust_img" />" alt="...">
		                                </span>
		                                <!-- 댓글 입력란 -->
								<s:form id="replyform" action="reply" method="post">
		                                <div class="comment-body">
											<input class="form-control input-sm recontent" type="text" id="recontent" name="recontent" />
											<input type="hidden" value="<s:property value='item_id'/>" id="item_id" name="item_id" class="item_id" />
											<a class="replyBtn" href="#" id="wreply1">전송 </a> 
		                                </div>
								</s:form>
		                       </li>
		                       </div>
		                       
		                       
		                            </s:if>
		                            
		                   			<s:if test="iterator_id==3">
		                   			<div id=div3 class="post-comments mt-sm">
		                            <s:iterator value="replylist3">
		                            <li>
		                            	<!-- 댓글 작성자 사진 -->
		                                <span class="thumb-xs avatar pull-left mr-sm">
		                                    <img class="img-circle" src="<s:property value='re_image' />" alt="...">
		                                </span>
		                                <!-- 댓글 내용 -->
		                                <div class="comment-body">
		                                    <h6 class="author fw-semi-bold"><s:property value="re_name" /> <small><s:property value="re_date" /></small></h6>
		                                    <p><s:property value="content" /></p>
		                                </div>
		                            </li>
		                            </s:iterator>
		                            </div>
		                            <div class="post-comments mt-sm">
		                         <li>
		                            	<!-- 댓글 작성란의 쓰는이의 사진 -->
		                                <span class="thumb-xs avatar pull-left mr-sm">
		                                    <img class="img-circle" src="<s:property value="cust_img" />" alt="...">
		                                </span>
		                                <!-- 댓글 입력란 -->
								<s:form id="replyform" action="reply" method="post">
		                                <div class="comment-body">
											<input class="form-control input-sm recontent" type="text" id="recontent" name="recontent" />
											<input type="hidden" value="<s:property value='item_id'/>" id="item_id" name="item_id" class="item_id" />
											<a class="replyBtn" href="#" id="wreply3">전송 </a> 
		                                </div>
								</s:form>
		                            </li>
		                            </div>
		                            </s:if>
		                           <s:if test="iterator_id==5">
		                            <div id=div5 class="post-comments mt-sm">
		                            <s:iterator value="replylist5">
		                            <li>
		                            	<!-- 댓글 작성자 사진 -->
		                                <span class="thumb-xs avatar pull-left mr-sm">
		                                    <img class="img-circle" src="<s:property value='re_image' />" alt="...">
		                                </span>
		                                <!-- 댓글 내용 -->
		                                <div class="comment-body">
		                                    <h6 class="author fw-semi-bold"><s:property value="re_name" /> <small><s:property value="re_date" /></small></h6>
		                                    <p><s:property value="content" /></p>
		                                </div>
		                            </li>
		                            </s:iterator>
		                            </div>
		                            <div class="post-comments mt-sm">
		                          <li>
		                            	<!-- 댓글 작성란의 쓰는이의 사진 -->
		                                <span class="thumb-xs avatar pull-left mr-sm">
		                                    <img class="img-circle" src="<s:property value="cust_img" />" alt="...">
		                                </span>
		                                <!-- 댓글 입력란 -->
								<s:form id="replyform" action="reply" method="post">
		                                <div class="comment-body">
											<input class="form-control input-sm recontent" type="text" id="recontent" name="recontent" />
											<input type="hidden" value="<s:property value='item_id'/>" id="item_id" name="item_id" class="item_id" />
											<a class="replyBtn" href="#" id="wreply5">전송 </a> 
		                                </div>
								</s:form>
		                            </li>
		                            </div>
		                            </s:if>
		                        </ul>
		                        <!-- 댓글 부분 끝 -->
		                    </footer>
		                </section>
		            </li>
		            </s:if>
	            
	            	<!-- 오른쪽(짝수면)으로 나뉘는 부분 시작 -->
		            <s:else>
		            <li class="on-right">
		                <time class="event-time" datetime="2014-05-19 03:04"><!-- 노드부분 -->
		                    <%-- <span class="date">yesterday</span> --%>
		                    <span class="time"><s:property value="title"/></span><!-- 일겹살 뜨는 부분 -->
		                    <%-- <span class="time"><s:property value="item_name"/><span class="fw-semi-bold">am</span></span> --%>
		                </time>
			            
		            	<span class="event-icon event-icon-danger"><!-- 아이콘 (아이템) -->
		                    <i class="glyphicon glyphicon-cutlery"></i>
		                </span>
		                
		                <section class="event"><!-- 사진 담길 곳....... -->
		                    <span class="thumb-sm avatar pull-left mr-sm">
		                        <img class="img-circle" src="demo/img/people/a2.jpg" alt="...">
		                    </span>
		                    <h4 class="event-heading"><a href="#">Jessica Nilson</a> <small>@jess</small></h4>
		                    <p class="fs-sm text-muted">10:12 am - Publicly near Minsk</p>
		                    
		                   	<!--  사진 업로드 하면 바로 담기는 div 태그, 이걸 밑에 div로 옮겨야 할 듯. -->
		                    <div class="event-map" id='<s:property value="itemlist[#cust_stat.index].item_id"/>'>	
		                   		<a href="#">
		                        	<img class="demo_image" src="demo/img/pictures/8.jpg"/>
		                        </a>
		                    </div>
		                   
		                    <!-- 현재 디폴트로 쓰고 있는 사진. 사진이 꽉 차지 않는 건 div보다 img의 width가 작기 때문! -->
		                   <!-- <div class="event-image">
		                        <a href="demo/img/pictures/8.jpg">
		                        	<img src="demo/img/pictures/8.jpg"/>
		                        </a>
		                    </div> -->

		                    <footer><!-- 사진 담기는 부분 아래부터 댓글 쓰는 부분까지 -->
		                        <div class="clearfix">
		                            <ul class="post-links mt-sm pull-left">
		                                <li><a href="#">1 hour</a></li>
		                                <li><a href="#"><span class="text-danger"><i class="fa fa-heart-o"></i> Like</span></a></li>
		                                <li><a href="#">Comment</a></li>
		                            </ul>
		                            <ul class="post-links mt-sm pull-right">
	                            		<li>
	                            			<input type="hidden" class="item_no" value='<s:property value="itemlist[#cust_stat.index].item_id"/>'/>
	                            			<a class="photo_upload" href="#"><span class="text-danger"><i class="fa fa-file-photo-o"></i> Photo</span></a><!-- 사진 업로드 버튼 -->
	                            		</li>
		                            </ul>
									
						<%-- 	사람들 좋아요 누르는 거 필요없을 거 같아서 일단 주석처리 함	
									<!-- 좋아요 누른 사람들 시작 -->
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
		                            <!-- 좋아요 누른 사람들 끝 --> --%>
		                        </div>
		                        
		                        <!-- 댓글 부분 시작 -->
		                        <ul>
		                            
		                            <s:if test="iterator_id==2">
		                            <div class="post-comments mt-sm" id=div2>
		                            <s:iterator value="replylist2">
		                            <li>
		                            	<!-- 댓글 작성자 사진 -->
		                                <span class="thumb-xs avatar pull-left mr-sm">
		                                    <img class="img-circle" src="<s:property value='re_image' />" alt="...">
		                                </span>
		                                <!-- 댓글 내용 -->
		                                <div class="comment-body">
		                                    <h6 class="author fw-semi-bold"><s:property value="re_name" /> <small><s:property value="re_date" /></small></h6>
		                                    <p><s:property value="content" /></p>
		                                </div>
		                            </li>
		                            </s:iterator>
		                            </div>
		                      <div class="post-comments mt-sm">
		                      <li>
		                            	<!-- 댓글 작성란의 쓰는이의 사진 -->
		                                <span class="thumb-xs avatar pull-left mr-sm">
		                                    <img class="img-circle" src="<s:property value="cust_img" />" alt="...">
		                                </span>
		                                <!-- 댓글 입력란 -->
								<s:form id="replyform" action="reply" method="post">
		                                <div class="comment-body">
											<input class="form-control input-sm recontent" type="text" id="recontent" name="recontent" />
											<input type="hidden" value="<s:property value='item_id'/>" id="item_id" name="item_id" class="item_id" />
											<a class="replyBtn" href="#" id="wreply2">전송 </a> 
		                                </div>
								</s:form>
		                       </li>
		                       </div>
		                            </s:if>
		                   			<s:if test="iterator_id==4">
		                            <div id=div4 class="post-comments mt-sm">
		                            <s:iterator value="replylist4">
		                            <li>
		                            	<!-- 댓글 작성자 사진 -->
		                                <span class="thumb-xs avatar pull-left mr-sm">
		                                    <img class="img-circle" src="<s:property value='re_image' />" alt="...">
		                                </span>
		                                <!-- 댓글 내용 -->
		                                <div class="comment-body">
		                                    <h6 class="author fw-semi-bold"><s:property value="re_name" /> <small><s:property value="re_date" /></small></h6>
		                                    <p><s:property value="content" /></p>
		                                </div>
		                            </li>
		                            </s:iterator>
		                            </div>
		                            <div class="post-comments mt-sm">
		                         <li>
		                            	<!-- 댓글 작성란의 쓰는이의 사진 -->
		                                <span class="thumb-xs avatar pull-left mr-sm">
		                                    <img class="img-circle" src="<s:property value="cust_img" />" alt="...">
		                                </span>
		                                <!-- 댓글 입력란 -->
								<s:form id="replyform" action="reply" method="post">
		                                <div class="comment-body">
											<input class="form-control input-sm recontent" type="text" id="recontent" name="recontent" />
											<input type="hidden" value="<s:property value='item_id'/>" id="item_id" name="item_id" class="item_id" />
											<a class="replyBtn" href="#" id="wreply4">전송 </a> 
		                                </div>
								</s:form>
		                            </li>
		                            </div>
		                            </s:if>
		                        </ul>
		                        <!-- 댓글 부분 끝 -->
		                    </footer>
		                </section>
		            </li>
		            </s:else>
		            <!-- 오른쪽으로 나뉘는 부분 끝 -->
            </s:iterator>
        </ul>
    </main>
</div>
<!-- 메인 내용 끝 -->
			<!-- 사진 업로드 부분 -->
			<div id="overlay_photo"></div> 
			<div id="popup_layer_photo">
			<section class="widget widget-login animated fadeInUp">
				<form id="uploadPic" action="userImage" method="post" theme="simple" enctype="multipart/form-data">           
					<div style="border: 1px solid #cccccc; padding: 10px">
						<header>
							<img src="img/makeTimeLine/camera_ico.png">
						</header>
						<div class="widget-body">
							<br/><br/>
							<input type="file" id="upload" value="upload" name="userImage" multiple class="multi with-preview" maxlength="2" accept="gif|jpg|png"/>
						</div>
					</div>
					<br/>
					<a id="upload_pic_btn" class="btn btn-warning" href="#">PHOTO CHOICE&nbsp;
						<span class="circle bg-white">
							<i class="glyphicon glyphicon-arrow-up text-warning"></i>
						</span>
					</a>
					
					<a id="upload_btn" class="btn btn-info" href="#">SEND&nbsp;
						<span class="circle bg-white">
							<i class="fa fa-arrow-right text-info"></i>
						</span>
					</a>
					<input type="submit" id="upload_real_btn" value="등록"/>
					<input type="hidden" id="item_number" name="item_number" value=""/>
					
					
				</form>
			</section>
			</div>
			<!-- 사진 업로드 부분 끝 -->
			
			<!-- 사진 보이기  -->
			<div id="overlay_view_photo"></div> 
			<div id="popup_layer_view_photo">
		         <section class="widget widget-login animated fadeInUp">
		             <header>
		                 <h3>Photo</h3>
		             </header>
		             <div class="widget-body view_photo">
						<br/><br/><!-- 사진 담기는 보이는 부분 -->
						
		             </div>
		         </section>
			</div>
			<!-- 사진 보이기  끝 -->
			
			<!-- 다른 script와 합치면 ajaxForm 오류가 날 수 있음 -->
    		 <script>
    		 	//사진 클릭 시 팝업 효과
    		 	var temp;
    		 	var i;
    		 	
    		 	$('.event-map').on('click', function(){
    		 		temp = "";
    		 		i = 0;
    		 		$('.view_photo').append("<a id='chevron-left-btn' href='#'><i id='chevron-left' class='glyphicon glyphicon-chevron-left'></i></a>");
    		 		$('.view_photo').append("<a id='chevron-right-btn' href='#'><i id='chevron-right' class='glyphicon glyphicon-chevron-right'></i></a>");
    		 		$('#popup_layer_view_photo, #overlay_view_photo').show();
    		 		temp = $(this).children().children();
    		 		var length = temp.length;
    		 		//최초 클릭 시 가장 최근에 저장한 값을 보임.
    		 		$('.view_photo').append("<img class='attatched_pic' src='"+temp[length-1].src+"'/>");
    		 		i = length-1;//초기값은 가장 끝의 index
    		 		if(i===0){
    		 			$('#chevron-right-btn').css('display', 'none');
    		 			$('#chevron-left-btn').css('display', 'none');
    		 		}else if(i===1){
    		 			$('#chevron-right-btn').css('display', 'none');
    		 			$('#chevron-left-btn').css('display', 'none');
    		 			$('.view_photo').append("<h3 id='pics_no'>"+i+" of "+(length-1)+"</h3>");
    		 		}else{
    		 			$('#chevron-left-btn').css('display', '');
    		 			$('.view_photo').append("<h3 id='pics_no'>"+i+" of "+(length-1)+"</h3>");
    		 		}
    		 		//최초 사진 수와 총 사진 개수를 보여주는 h3태그. 가장 끝에 것을 먼저 보여줌.
    		 		
    		 		$('#chevron-right-btn').css('display', 'none');
   		 			
    		 		//왼쪽 버튼 클릭
    		 		$('#chevron-left-btn').on('click', function(){
    		 			i--;
    		 			$('#chevron-right-btn').css('display', '');
    		 			$('#chevron-left-btn').css('display', '');
    		 			if(i<2){
   		 					$('#chevron-left-btn').css('display', 'none');
    		 			}
    		 				$('.view_photo').children('.attatched_pic').remove();
    		 				$('.view_photo').children('#pics_no').remove();
	    		 			$('.view_photo').append("<img class='attatched_pic' src='"+temp[i].src+"'/>");
	    		 			$('.view_photo').append("<h3 id='pics_no'>"+(i)+" of "+(length-1)+"</h3>");
    		 		});//왼쪽 버튼 클릭
    		 		
    		 		
    		 		//오른쪽 버튼 클릭
					$('#chevron-right-btn').on('click', function(){
    		 			i++;
						$('#chevron-right-btn').css('display', '');
						$('#chevron-left-btn').css('display', '');
						if(i>=(length-1)){
							$('#chevron-right-btn').css('display', 'none');
						}
							$('.view_photo').children('.attatched_pic').remove();
    		 				$('.view_photo').children('#pics_no').remove();
	    		 			$('.view_photo').append("<img class='attatched_pic' src='"+temp[i].src+"'/>");
	    		 			$('.view_photo').append("<h3 id='pics_no'>"+(i)+" of "+(length-1)+"</h3>");
    		 		});//오른쪽 버튼 클릭
    		 	});//사진 클릭 시 팝업 효과
    		 	
    		 	//사진 이외 부분 클릭 시 사라지는 효과
    		 	$('#overlay_view_photo, .close').click(function(e){ 
    		        e.preventDefault(); 
    		        $('#chevron-right-btn').remove();
    		        $('#chevron-left-btn').remove();
    		        $('#popup_layer_view_photo, #overlay_view_photo').hide(); 
    		        $('.view_photo').children('.attatched_pic').remove();
    		        $('.view_photo').children('#pics_no').remove();
    		    });//사진 이외 부분 클릭 시 사라지는 효과
    		    
    		    
    		 
   			 	$('.photo_upload').on('click', function(){
    				$('#popup_layer_photo, #overlay_photo').show(); 
    			});//사진 올리기 아이콘 클릭 시, 팝업 효과
    		
    		    $('#overlay_photo, .close').click(function(e){ 
    		        e.preventDefault(); 
    		        $('#popup_layer_photo, #overlay_photo').hide(); 
    		    });//팝업 효과 나타났을 때, 다른 부분 클릭하면 사라지는 효과
    		    
    		 	$('.photo_upload').on('click', function(){
    		 		var temp = $(this).parent().children('.item_no').val();
    		 		$('#item_number').val(temp);
        		 	var temp2 = $('#item_number').val();
    		 	});//사진 등록할 때, 해당 item_no를 FORM안에 hidden값으로 넣고 가져감.
    		 
    			$('#upload_pic_btn').on('click', function(){
    				$('#upload').trigger('click');
    			});//사진 올리기 버튼 클릭

    			$('#upload_btn').on('click', function(){
    		 		$('#upload_real_btn').trigger('click'); 
    			});//업로드 버튼 클릭
			 	
    			
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
						var map_itemNo = data.map_itemNo;
						var map_savedFile = data.map_savedFile;
						var name = '<%= session.getAttribute("loginId") %>';
							$.each(map_itemNo, function(index, val){
								$('#'+map_itemNo[index]).append(
									"<a class='allImage img_"+map_itemNo[index]+"' href='#'><img class='demo_image' src='image/"+name+"/"+map_itemNo[index]+"/"+map_savedFile[index]+"' alt='...'/></a>"
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

<%-- <script src="js/timeline.js"></script> --%>
</body>
</html>