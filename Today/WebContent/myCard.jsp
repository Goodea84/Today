<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>MINNANO MARKERS</title>
    <link rel="shortcut icon" href="img/favi.ico">
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
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script src="http://connect.facebook.net/en_US/all.js"></script>
	<script>
	
		$(document).ready(function() {
			
			var card_id;
			
			$('.Shares').click(function() {
				card_id = $(this).attr('href');
				$('#popup_layer, #overlay_t').show(); 
			});
			//카드 삭제
			$('.Delete').click(function() {
				card_id = $(this).attr('href');
				var thisRemove = $(this);
				
				$.ajax({
		        	method: "post"
		        	, url: "cardDelete"
		        	, async: false
		        	, dataType: "json"
		        	, data: {"card.card_id":card_id}
		        	, success: result
		    
				});//ajax end
				
				function result() {
        			//thisRemove.parent().parent().parent().parent().parent().parent().remove();
        			location.href="page_moveTo_gallery.action";
        		}
			});
			
			//김승훈 test button
			$('#test').click(function() {
				
				var card_id = $('.card_id');
				card_id.each(function(index, item){
					
					alert(item.value);
				});
				
			});
			
			$('#overlay_t, .close').click(function(e) {
				e.preventDefault();
				$('#popup_layer, #overlay_t').hide();
			});
			
			//공유버튼을 누르면 친구들에게 카드를 보낸다.
			$('#sendCard').click(function(){
				//체크된 친구들에게 카드를 보낸다. 
		        $("input:checkbox[name='friend_check']:checked").each(function(index, item){
		        	//customer_id 확인
		        	$.ajax({
		        	method: "post"
		        	, url: "cardAdd"
		        	, async: false
		        	, dataType: "json"
		        	, data: {"card.card_id":card_id, "customer.cust_id":item.value}
		        	//, async: false
		        	, success: function(response) {
							if(response.checkCard===true){
								//popup 숨기기
								$('#popup_layer, #overlay_t').hide();
								alert(response.customer.cust_id + "님에게 보내는 카드 중복입니다.");
							}else{
								//popup 숨기기
								$('#popup_layer, #overlay_t').hide();
								alert(response.customer.cust_id + "님에게 카드 전송되었습니다.");
							}
						}
		        	});//ajax end
		        });//each fucntion end
			});//click function end
			
			//카카오톡 스토리 버튼 클릭 이벤트
			$('#sendKakao').click(function(){
	        	var kakaoStr = "";
	        	$.ajax({
	        	method: "post"
	        	, url: "sendKakao"
	        	, async: false
	        	, dataType: "json"
	        	, data: {"card.card_id":card_id}
	        	, success: function(response) {	        		
		        		$(response.itemlist).each(function(index, item){
		        			kakaoStr += (index+1) + ". 가게이름 : " + item.title + "/ 주소 : " + item.address + "/ 전화번호 : " + item.phone + "\n";
		        		});
					}
	        	});//ajax end
	        	
	        	//타임라인 직접 가는 링크 달기 서버 변경시 주소값을 변경해야 함
	        	kakaoStr += "http://localhost:8888/Today/page_moveTo_timeline?card_id=" + card_id + "&checkCard=true" ;
	      		//카드 대표 사진 주가 예정
	      		shareStory(kakaoStr);
			
			});//click function end
			
			//친구 리스트 마우스오버 효과
			$( '.list-group-item-custom' ).hover(
				  function() {
				    $( this ).css('background-color', '#EAEAEA');
				  }, function() {
				    $( this ).css('background-color', 'transparent' );
				  }
			);
			// div영역 클릭시 체크박스 체크 
			$( '.list-group-item-custom' ).click(
				function() {
				    //alert(typeof($( this ).children().children('.btn')));
				    $( this ).children().children('.friend_check').trigger('click');
				  }
			);
			//카카오 스토리 공유
		    // 사용할 앱의 JavaScript 키를 설정해 주세요.
		    Kakao.init('f595a23931a22f24497af1b61613eec3');
		    // 스토리 공유 버튼을 생성합니다.
		    function shareStory(kakaoStr) {
		      Kakao.Story.share({
		        url: 'https://dev.kakao.com',
		        text: kakaoStr
	      	});
		    }
		    
		  //페이스북 공유
			   $.ajaxSetup({ cache: true });
			    $.getScript('//connect.facebook.net/en_US/sdk.js', function(){
			      FB.init({
			        appId: '1938544639706223',
			        version: 'v2.8' // or v2.0, v2.1, v2.2, v2.3
			      });     
			      $('#loginbutton,#sendFacebook').removeAttr('disabled');
			      //FB.getLoginStatus(updateStatusCallback);
			    });
			    
			    /* FB.getLoginStatus(function(){
			    	   alert('Status updated1!!');
			    	   // Your logic here
			    	});
			    
			    function updateStatusCallback(){
			    	   alert('Status updated2!!');
			    	   FB.ui(
			    			   {
			    			    method: 'share',
			    			    href: 'https://developers.facebook.com/docs/'
			    			  }, function(response){});
			    } */ 
			    $('#sendFacebook').click(function(){
			    	
			    	var kakaoStr = "";
		        	$.ajax({
		        	method: "post"
		        	, url: "sendKakao"
		        	, async: false
		        	, dataType: "json"
		        	, data: {"card.card_id":card_id}
		        	, success: function(response) {	        		
			        		$(response.itemlist).each(function(index, item){
			        			kakaoStr += (index+1) + ". 가게이름 : " + item.title + "/ 주소 : " + item.address + "/ 전화번호 : " + item.phone + "\n";
			        		});
						}
		        	});//ajax end
		        	
		        	//타임라인 직접 가는 링크 달기 서버 변경시 주소값을 변경해야 함
		        	kakaoStr += "http://203.233.196.44:8888/Today/page_moveTo_timeline?card_id=" + card_id + "&checkCard=true" ;
		      		
			    	FB.ui({
			    		  method: 'share',
			    		  href: 'https://developers.facebook.com/docs/',
			    		  quote: kakaoStr
			    		}, function(response){});
			    });	
			    
			    
			    //병훈 카드 뿌릴 때 대표사진 붙이기. 1번 아이템의 가장 최근 사진으로 가져옴. 없을 시 디폴트
			    $.ajax({
			    	method: 'post',
			    	url: 'getImageObj',
			    	success: function(resp){
						var list_itemIds = resp.item_ids;
						$.each(list_itemIds, function(index, val){
							if(val!=null){
								var image = "image/"+val.item_id+"/"+val.photo;
								$('#id'+val.item_id).attr('src', image);							
							}
						});//each
			    	}//success
			    });//ajax
			    
			    
	      	
		});//(document).ready end
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
                    Markers
                </a>
            </li>
            <li class="active" data-no-pjax>
                <a href="page_moveTo_gallery" data-no-pjax>
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
                        <input class="form-control" type="text" id="searchLocal" name="searchLocal" placeholder="Search the card">
                    </div>
                </div>
                
                <!-- <input type="button" value="test" id="test"> 김승훈 테스트버튼 -->
                
            </div>
            
           
            
            <ul class="nav navbar-nav navbar-right">
            <s:if test="#session.loginId != null">
                <li class="dropdown">
                    <a href="#" id="notifications-dropdown-toggle">
<%--                         <span class="thumb-sm avatar pull-left">
                        	<!-- 상단 이미지  -->
                        </span> --%><!-- 왼쪽으로 조금 옮김 -->
                        &nbsp;
						<strong><s:property value="#session.loginName" /></strong>&nbsp;<!-- 이름 -->
                        </a>
 
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
        <h1 class="page-title">User - <span class="fw-semi-bold">Profile</span></h1>
<!-- 프로필 : 전혜선 (수정할 수 있음)-->        
            <div class="row" >
            <div class="col-md-6">
                <section class="widget">
                    <div class="widget-body">
                        <div class="widget-top-overflow text-white">
                            <div class="height-250 overflow-hidden">
                                <img class="img-responsive" src="demo/img/pictures/19.jpg">
                            </div>
                            <div class="btn-toolbar">
                                <a href="#" class="btn btn-outline btn-sm pull-right">
                                    <i class="fa fa-twitter mr-xs"></i>
                                    Follow
                                </a>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-5 text-center">
                                <div class="post-user post-user-profile">
                                    <span class="thumb-xlg">
                                        <img class="img-circle" src="<s:property value='customer.cust_image' />" alt="...">
                                    </span>
                                    <h4 class="fw-normal"><span class="fw-semi-bold"><s:property value="customer.name" /> </span></h4>
                                    <%-- <h4 class="fw-normal">Adam <span class="fw-semi-bold"><s:property value="customer.name" /> </span></h4> --%>
                                   <!--  <p>UI/UX designer</p> -->

                                </div>
                            </div>
                            <div class="col-sm-7">
                                <div class="stats-row stats-row-profile mt text-right">
                                    <div class="stat-item">
                                        <p class="value"><s:property value="listsize" /> </p>
                                        <h5 class="name">Cards</h5>
                                    </div>
                                    <div class="stat-item">
                                        <p class="value"><s:property value="sumrecommend" /></p>
                                        <h5 class="name">Recommends</h5>
                                    </div>
                                    <div class="stat-item">
                                        <p class="value"><s:property value="follower" /></p>
                                        <h5 class="name">Followers</h5>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    
                </section>
            
            
            </div>
        </div><!-- 프로필 : 전혜선 (수정할 수 있음) end-->
          
        <h1 class="page-title">My - <span class="fw-semi-bold">Markers</span></h1>
        <div class="clearfix mb-lg">
            <div class="btn-group m-b-20 js-filter-options">
                <span class="btn btn-default filter active" data-group="all">Public</span>
                <span class="btn btn-default filter" data-group="nature">Friends</span>
                <span class="btn btn-default filter" data-group="people">Only Me</span>
                <%-- <span class="btn btn-default filter" data-group="space">Space</span> --%>
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
                <div id="aaa">
                    <a  href="page_moveTo_timeline?card_id=<s:property value='card_id' />" ><img id='id<s:property value='item1'/>' src="demo/img/pictures/1.jpg" alt="..."></a><!-- 클릭하면나오는이미지,이미지 -->
                    
                    <div class="caption">
                        <h5 class="mt-0 mb-xs"><s:property value="loca_name" /></h5><!-- 이름 -->
                        <ul class="post-links">
                            <li><a href="#"><s:property value="date" /></a></li><!-- 날짜 -->
                            <li><a href="#"><span class="text-danger"><i class="fa fa-heart-o"></i> Like</span></a></li> <!-- 옆에 추천수도 입력 -->
                            <li><a onclick="return false" href="<s:property value="card_id" />" class="Shares">Shares</a></li>
                            <li><a onclick="return false" href="<s:property value="card_id" />" class="Delete">Delete</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            </div>
            </s:iterator>

            <div class="col-sm-6 col-md-3 js-shuffle-sizer"></div>
        </div> <!-- 카드 끝 : 전혜선 -->
        
		<section id="alertSection" class="widget" style="background-color:transparent;">
			<div class="widget-body" id="alertArea">
			</div>
		</section>
        
    </main>
</div>
	<div id="overlay_t"></div>
	<div id="popup_layer">
		<section class="widget widget-login animated fadeInUp test">
			<header>
				<h3>My Friends List</h3>
			</header>
			<div class="widget-body">
				<div class="list-group chat-sidebar-user-group" style="margin-left:0px; padding:0px;">
					<s:iterator value="flist">
						<div class="list-group-item list-group-item-custom" style="border-radius:1em">
							<!-- <a href="#"><i id="eee"	class="glyphicon glyphicon-envelope pull-right"></i></a> --> 
							
							<!-- <a href="#"><i class="glyphicon glyphicon-info-sign pull-right"></i></a> -->
							<!-- <i class="fa fa-circle text-success pull-right"></i> -->
							<!-- <i class="fa fa-circle text-success pull-right"></i> -->
							<!-- <div class="thumb-sm pull-left mr"  style="padding: 0 0 5px 0;"> 
							
							</div> -->
							<h5 class="message-sender" style="color: black; margin-left:0px; padding:0px">
								<input type="checkbox" name="friend_check" class="friend_check pull-right" style="margin-top:5px; padding-top:5px" value="<s:property value='cust_id' />">
								<img id="friendimg" class="img-circle" src="<s:property value='cust_image' />"alt="..."> <!-- 사진 -->
								&nbsp;&nbsp;&nbsp;<s:property value="name" />
							</h5>
							<!-- 이름 -->
							<!--  <p class="message-preview">Hey! What's up? So many times since we</p>  -->
							<!--  프리뷰 -->
						</div>
					</s:iterator>
					<br />
				</div>
				<input type="button" class="btn btn-primary width-100 mb-xs" value="Send Card" id="sendCard" style="float: left; margin-right: 4px"/>
				<input type="button" class="btn btn-warning width-100 mb-xs" value="KAKAO" id="sendKakao" style="float: left; margin-right: 4px"/>
				<input type="button" class="btn btn-primary width-100 mb-xs" value="Facebook" id="sendFacebook" style="float: left; margin-right: 4px"/>
				
			</div>
		</section>
	</div>
	
	
	<!-- loginform end jhs -->
	
	
	<%-- <!-- 김승훈 아이템 리스트 받아오기 카카오톡 공유에서 사용  -->
	<s:iterator value="itemlist" status="cust_stat"> <!-- 만약 item_id가 1이면 replylist1을 뿌리고.. 이렇게..? -->	        
	        <input type="hidden" class="item_s" value='<s:property value="itemlist[#cust_stat.index].item_x"/>'/> 
	        <input type="hidden" class="item_j" value='<s:property value="itemlist[#cust_stat.index].item_y"/>'/>
	</s:iterator>
	<!-- end --> --%>

	<!-- The Loader. Is shown when pjax happens -->
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