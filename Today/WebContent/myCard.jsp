<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sing - Gallery</title>
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
    
    <script src="script/jquery-3.1.0.min.js" type="text/javascript"></script> 
	<script src="script/jquery-ui.min.js" type="text/javascript"></script>
	<script>
	
		$(document).ready(function() {
			
			
			var card_id;
	
			$('#Shares').click(function() {
				$('#popup_layer, #overlay_t').show();
				card_id = $('.card_id').val();
				//$('#popup_layer').css("top", Math.max(0, $(window).scrollTop() + 100) + "px"); 
				// $('#popup_layer').css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px"); 
			});
			$('#overlay_t, .close').click(function(e) {
				e.preventDefault();
				$('#popup_layer, #overlay_t').hide();
			});
			
			$('#sendCard').click(function(){
				
		        $("input:checkbox[name='friend_check']:checked").each(function(index, item){
		        	//customer_id 확인
		        	alert(item.value);
		        	$.ajax({
		        	method: "post"
		        	, url: "cardAdd"
		        	, dataType: "json"
		        	, data: {"card.card_id":card_id, "customer.cust_id":item.value}
		        	, success: function(response) {
						alert("success");
					}
		        });
		        });
		        	
		       // }
			});
	
		});
	</script>
   	<script src="script/jquery-3.1.0.min.js" type="text/javascript"></script> 
	<script src="script/jquery-ui.min.js" type="text/javascript"></script> 
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
            <a href="index">sing</a>
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
            <li class="active">Gallery</li>
        </ol>
        <h1 class="page-title">Media - <span class="fw-semi-bold">Images</span></h1>
        <div class="clearfix mb-lg">
            <div class="btn-group m-b-20 js-filter-options">
                <span class="btn btn-default filter active" data-group="all">All</span>
                <span class="btn btn-default filter" data-group="nature">Nature</span>
                <span class="btn btn-default filter" data-group="people">People</span>
                <span class="btn btn-default filter" data-group="space">Space</span>
            </div>
            <div class="pull-right m-b-20">
                <div class="btn-group js-sort-options">
                    <span class="btn btn-default sort active" data-sort-order="asc"><i class="fa fa-sort-numeric-asc"></i></span>
                    <span class="btn btn-default sort" data-sort-order="desc"><i class="fa fa-sort-numeric-desc"></i></span>
                </div>
            </div>
        </div>
        
        <!-- 카드시작 card start : 전혜선 -->
        <div class="row gallery" id="grid">
        <s:iterator value="clist"> 
            <div class="col-sm-6 col-md-3 gallery-item" data-groups='["nature"]' data-title="Mountains"><!--분류,이름(아마 순서정렬)  -->
                <div class="thumbnail">
                    <a href="../demo/img/pictures/13.jpg"><img src="demo/img/pictures/1.jpg" alt="..."></a><!-- 클릭하면나오는이미지,이미지 -->
                    <div class="caption">
                        <h5 class="mt-0 mb-xs"><s:property value="loca_name" /></h5><!-- 이름 -->
                        <input type="hidden" class="card_id" value="<s:property value="card_id" />"> 
                        <ul class="post-links">
                            <li><a href="#"><s:property value="date" /></a></li><!-- 날짜 -->
                            <li><a href="#"><span class="text-danger"><i class="fa fa-heart-o"></i> Like</span></a></li> <!-- 옆에 추천수도 입력 -->
                            <li><a href="#">Details</a></li> <!-- 코스명보여줄까 없앨까 -->
                            <li><a href="#" id="Shares">Shares</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            </s:iterator>

            <div class="col-sm-6 col-md-3 js-shuffle-sizer"></div>
        </div>
    </main>
</div>
	<div id="overlay_t"></div>
	<div id="popup_layer">
		<section class="widget widget-login animated fadeInUp test">
			<header>
				<h3>My Friends List</h3>
			</header>
			<div class="widget-body">
				<h5 class="sidebar-nav-title">FriendList</h5>

				<div class="list-group chat-sidebar-user-group">
					<s:iterator value="flist">

						<div class="list-group-item">
							<!-- <a href="#"><i id="eee"	class="glyphicon glyphicon-envelope pull-right"></i></a> --> 
							<a href="#"><i class="glyphicon glyphicon-info-sign pull-right"></i></a>
							<!-- <i class="fa fa-circle text-success pull-right"></i> -->
							<!-- <i class="fa fa-circle text-success pull-right"></i> -->
							<span class="thumb-sm pull-left mr"> 
							<img id="friendimg" class="img-circle" src="<s:property value='cust_image' />"alt="..."> <!-- 사진 -->
							</span>
							<h5 class="message-sender">
								<s:property value="name" />
							</h5>
							<input type="checkbox" name="friend_check" class="friend_check" value="<s:property value='cust_id' />">
							<!-- 이름 -->
							<!--  <p class="message-preview">Hey! What's up? So many times since we</p>  -->
							<!--  프리뷰 -->
						</div>
					</s:iterator>
					<input type="button" value="공유" id="sendCard">

				</div>
			</div>
		</section>
	</div>
	<!-- loginform end jhs -->


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
<script src="vendor/shufflejs/dist/jquery.shuffle.modernizr.min.js"></script>
<script src="vendor/magnific-popup/dist/jquery.magnific-popup.min.js"></script>
<!-- page specific js -->
<script src="js/gallery.js"></script>
</body>
</html>