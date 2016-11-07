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
	
	<script src="https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=a35c8baf-b97e-3edc-8b03-5092e9e38b3f"></script>

	
	<!-- 유병훈 페이지 열릴 때마다 사진 가져오는 script -->
	<script>
		$(function(){
			var name = '<%= session.getAttribute("loginId") %>';

			var arr_item_id = new Array();
			$.each($('.testYB'), function(index, val){
				arr_item_id.push(val.value);
			}); 
			
			jQuery.ajaxSettings.traditional = true; //배열 보낼 때 필수..
			$.ajax({
				url: 'printImage',
				method: 'post',
				data: {"list_itemid":arr_item_id},
				dataType: 'json',
				success: function(resp){
					var list = resp.list_image;
					$.each(list, function(index, val){
						$('#'+list[index].item_id).append(
							"<a class='allImage img_"+list[index].item_id+"' href='#'><img class='demo_image' src='image/"+list[index].item_id+"/"+list[index].photo+"' alt='...'/></a>"
						);//append
					});//for-each
				}//success
			});//ajax
			

			
			
/* 전혜선 리플달기 */
			$(".replyBtn").on('click',function(){
				var appid;
				var recontent;
				var item_id;
				
				  if (this.id == "wreply1") {
					  appid = $('#div1');
					  recontent = $(this).parent().children('#recontent1').val();
				  }
				  if (this.id == "wreply2") {
					  appid = $('#div2');
					  recontent = $(this).parent().children('#recontent2').val();
				  }
				  if (this.id == "wreply3") {
					  appid = $('#div3');
					  recontent = $(this).parent().children('#recontent3').val();
				  }
				  if (this.id == "wreply4") {
					  appid = $('#div4');
					  recontent = $(this).parent().children('#recontent4').val();
				  }
				  if (this.id == "wreply5") {
					  appid = $('#div5');
					  recontent = $(this).parent().children('#recontent5').val();
				  }

				
				item_id = $(this).parent().children('input[type="hidden"]').val();


				
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
			$("input[name=recontent]").val('');
		 		
		 		return false;
				
			});
			
			/* enter눌리면 트리거로 버튼 클릭 불러준다. xxxxx  다시해줘야해 ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ*/
			
			  
 			$("input[name=recontent]").keydown(function (key) {
 
        		if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
        			/* $('.replyBtn').trigger("click"); */
        		
        			var appid;
				
				  if (this.id == "recontent1") {
					  alert('1');
					  appid = $('#div1');
				  }
				  if (this.id == "recontent2") {
					  alert('2');
					  appid = $('#div2');
				  }
				  if (this.id == "recontent3") {
					  alert('3');
					  appid = $('#div3');
				  }
				  if (this.id == "recontent4") {
					  alert('4');
					  appid = $('#div4');
				  }
				  if (this.id == "recontent5") {
					  alert('5');
					  appid = $('#div5');
				  }

				var recontent = $(this).val();
				alert(recontent);
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
		 		
		 		
		 		$("input[name=recontent]").val('');
        			return false;
        		}
 
  			  });
			
			//위도 경도 추출후 배열로 입력
			var xArray = [5];
			var yArray = [5];
			
			//pr_3857 인스탄스 생성.
			var pr_4326 = new Tmap.Projection("EPSG:4326");
			
			//pr_3857 인스탄스 생성.
			var pr_3857 = new Tmap.Projection("EPSG:3857");
			
			//WGS84GEO -> EPSG:3857 좌표형식 변환
			function get3857LonLat(coordX, coordY){
			    return new Tmap.LonLat(coordX, coordY).transform(pr_4326, pr_3857);
			}
			
			$(".item_s").each(function(index, item){
	      		xArray[index] = parseFloat(item.value);
	      	});
			
			$(".item_j").each(function(index, item){
	      		yArray[index] = parseFloat(item.value);
	      	});
			
			//위도 경도 입력 배열 선언
			var xyArray = [];
			
			xyArray.push(get3857LonLat(yArray[0], xArray[0]));
			xyArray.push(get3857LonLat(yArray[1], xArray[1]));
			
			if(xArray.length==3||xArray.length==4||xArray.length==5){
			xyArray.push(get3857LonLat(yArray[2], xArray[2]));
			}
			if(xArray.length==4||xArray.length==5){
			xyArray.push(get3857LonLat(yArray[3], xArray[3]));
			}
			if(xArray.length==4||xArray.length==5){
			xyArray.push(get3857LonLat(yArray[4], xArray[4]));
			}
			
			var length = xyArray.length;
			//맵 그리기 
			
			initialize();
			
			var map;
			
			function initialize() {
			    map = new Tmap.Map({div:"g_map", width:'100%', height:'330px'});
			}
			//중심좌표 설정
			map.setCenter(new Tmap.LonLat(14135893.887852,4518348.1852606), 14);
			
			searchRoute();
			//경로 길 그리기
			function searchRoute(){
				/* 맵 새로고침 */
				/* map.destroy();
				initTmap(); */
				
				var startX = xyArray[0].lon;//출발지
				var startY = xyArray[0].lat;
				var endX = xyArray[length-1].lon;//도착지
				var endY = xyArray[length-1].lat;
				
				 var routeFormat = new Tmap.Format.KML({extractStyles:true, extractAttributes:true});

			     var startName = "출발";
			     var endName = "도착";
			     var urlStr = "https://apis.skplanetx.com/tmap/routes/pedestrian?version=1&format=xml";
			         urlStr += "&startX="+startX;
			         urlStr += "&startY="+startY;
			         urlStr += "&endX="+endX;
			         urlStr += "&endY="+endY;
			     //경유지 추가 분기 처리
		         if(length===3){
					 urlStr += "&passList="+xyArray[1].lon+","+xyArray[1].lat;
				 }else if(length===4){
					 urlStr += "&passList="+xyArray[1].lon+","+xyArray[1].lat+"_"+xyArray[2].lon+","+xyArray[2].lat;
				 }else if(length===5){
					 urlStr += "&passList="+xyArray[1].lon+","+xyArray[1].lat+"_"+xyArray[2].lon+","+xyArray[2].lat+"_"+xyArray[3].lon+","+xyArray[3].lat;
					 
				 }
			         //urlStr += "&passList="+"14135893.887852, 4518348.1852606_14135881.887852, 4519591.4745242_14134881.887852, 4517572.4745242";
			         urlStr += "&startName="+encodeURIComponent(startName);
			         urlStr += "&endName="+encodeURIComponent(endName);
			         urlStr += "&appKey=a35c8baf-b97e-3edc-8b03-5092e9e38b3f";
			         
			   
			         
			     var prtcl = new Tmap.Protocol.HTTP({
			                                         url: urlStr,
			                                         format:routeFormat
			                                         });
			     var routeLayer = new Tmap.Layer.Vector("route", {protocol:prtcl, strategies:[new Tmap.Strategy.Fixed()]});
			     routeLayer.events.register("featuresadded", routeLayer, onDrawnFeatures);
			     map.addLayer(routeLayer);
			     
			     //컨트롤러 추가(키보드, 마우스 포인터 위경도)
			     map.addControls([
			                      new Tmap.Control.KeyboardDefaults(),
			                      new Tmap.Control.MousePosition(),
			                  ]);
			}//searchRoute fucntion end
			
			//경로 그리기 후 해당영역으로 줌
			function onDrawnFeatures(e){
			    map.zoomToExtent(this.getDataExtent());
			}
			
			//출발지 마크 생성
			var markerLayer = new Tmap.Layer.Markers();
			map.addLayer(markerLayer);
			 
			var lonlatS = new Tmap.LonLat(xyArray[0].lon, xyArray[0].lat);
			 
			var size = new Tmap.Size(24,38);
			var offset = new Tmap.Pixel((-size.w/2),(-size.h/2));
			var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_s.png', size, offset); 
			     
			var marker = new Tmap.Marker(lonlatS, icon);
			
			markerLayer.addMarker(marker);
			
			
			//도착지 마크 생성
			var lonlatE = new Tmap.LonLat(xyArray[length-1].lon, xyArray[length-1].lat);
			 
			var size = new Tmap.Size(24,38);
			var offset = new Tmap.Pixel((-size.w/2), (-size.h/2));
			var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_f.png', size, offset); 
			     
			var marker = new Tmap.Marker(lonlatE, icon);
			
			markerLayer.addMarker(marker);
			
			if(length===3||length===4||length===5){
				//marker A 표시
				var lonlatA = new Tmap.LonLat(xyArray[1].lon, xyArray[1].lat);
				 
				var size = new Tmap.Size(24,38);
				var offset = new Tmap.Pixel((-size.w/2), (-size.h/2));
				var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_2.png', size, offset); 
				     
				var marker = new Tmap.Marker(lonlatA, icon);
				
				markerLayer.addMarker(marker);
				
				
			}//end if
			
			//경로지가 2, 3개일 때
			if(length===4||length===5){
				//marker B 표시	
				var lonlatB = new Tmap.LonLat(xyArray[2].lon, xyArray[2].lat);
				 
				var size = new Tmap.Size(24,38);
				var offset = new Tmap.Pixel((-size.w/2), (-size.h/2));
				var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_3.png', size, offset); 
				     
				var marker = new Tmap.Marker(lonlatB, icon);
				markerLayer.addMarker(marker);
				
			}//end if
			
			//경로지가  3개일 때
			if(length===5){
				//marker C 표시	
				var lonlatC = new Tmap.LonLat(xyArray[3].lon, xyArray[3].lat);
				 
				var size = new Tmap.Size(24,38);
				var offset = new Tmap.Pixel(-(size.w/2), -(size.h/2));
				var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_4.png', size, offset); 
				     
				var marker = new Tmap.Marker(lonlatC, icon);
				markerLayer.addMarker(marker);
				
			}//end if 
			
			/*
			배열 초기화
			xArray.length = [5];
			yArray.length = [5];
			xyArray.length=0; */
			
			
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
        
     <!-- 외부 접속시에 친구리스트 불러오지 않는다. -->
     <s:if test="<s:property value='checkCard' />!=true">
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
	</s:if>
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
            <li class="active">My Card</li><li class="active">Time Line</li>
        </ol>
        <h1 class="page-title">Events - <span class="fw-semi-bold">Feed</span></h1>
        
        <div id="g_map">
        </div>
        <br />
        
        <ul class="timeline">
        
	        <s:iterator value="itemlist" status="cust_stat"> <!-- 만약 item_id가 1이면 replylist1을 뿌리고.. 이렇게..? -->
	        
	        <!--  -->
	        <input type="hidden" class="item_s" value='<s:property value="itemlist[#cust_stat.index].item_x"/>'/> 
	        <input type="hidden" class="item_j" value='<s:property value="itemlist[#cust_stat.index].item_y"/>'/>
	        
	        	<!-- 홀수면 if문 분기처리 -->
		        <s:if test="# cust_stat.odd == true">
		            <li class="on-left"><!-- 아이템노드+사진+댓글 --> <!-- 여기서 왼쪽 오른쪽...... -->
	            		<!-- 중간 마커 표시 -->
		                <s:if test="#cust_stat.first == true">
			                <time class="event-time" datetime="2014-05-19 03:04"><!-- 노드부분 -->
			                    <span class="badge bg-warning"><s:property value="title"/></span><!-- 일겹살 뜨는 부분 -->
			                </time>
			            	<span class="event-icon event-icon-warning"><!-- 아이콘 (아이템) -->
			                    <i class="glyphicon glyphicon-map-marker"></i>
			                </span>
		                </s:if>
		                <s:if test="#cust_stat.last == true">
			                <time class="event-time" datetime="2014-05-19 03:04"><!-- 노드부분 -->
			                    <span class="badge bg-danger"><s:property value="title"/></span><!-- 일겹살 뜨는 부분 -->
			                </time>
		                	<span class="event-icon event-icon-danger"><!-- 아이콘 (아이템) -->
			                    <i class="glyphicon glyphicon-map-marker"></i>
			                    <input type="hidden" class="itme_x" value="item_x">
			                    <input type="hidden" class="itme_y" value="item_y">
			                </span>
		                </s:if>
		                <s:if test="#cust_stat.first == false && #cust_stat.last == false">
		                <time class="event-time" datetime="2014-05-19 03:04"><!-- 노드부분 -->
		                    <span class="badge bg-info"><s:property value="title"/></span><!-- 일겹살 뜨는 부분 -->
		                </time>
		                	<span class="event-icon event-icon-info"><!-- 아이콘 (아이템) -->
			                    <i class="glyphicon glyphicon-map-marker"></i>
			                    <input type="hidden" class="itme_x" value="item_x">
			                    <input type="hidden" class="itme_y" value="item_y">
			                </span>
		                </s:if>
		                
		                <section class="event"><!-- 사진 담길 곳....... -->
		                    <span class="thumb-sm avatar pull-left mr-sm">
		                        <img class="img-circle" src="demo/img/people/a2.jpg" alt="...">
		                    </span>
		                    <h4 class="event-heading"><a href="#">Jessica Nilson</a> <small>@jess</small></h4>
		                    <p class="fs-sm text-muted">10:12 am - Publicly near Minsk</p>
		                    <div class="event-image" id='<s:property value="itemlist[#cust_stat.index].item_id"/>'>	
		                    	<a href="#">
		                        	<img class="demo_image" src=""/>
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
		                            			<input type="hidden" class="item_no testYB" value='<s:property value="itemlist[#cust_stat.index].item_id"/>'/>
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
											<input class="form-control input-sm recontent" type="text" id="recontent1" name="recontent" />
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
											<input class="form-control input-sm recontent" type="text" id="recontent3" name="recontent" />
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
											<input class="form-control input-sm recontent" type="text" id="recontent5" name="recontent" />
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
	            		<!-- 중간 마커 표시 -->
		            	<s:if test="#cust_stat.last == true">
							<time class="event-time" datetime="2014-05-19 03:04"><!-- 노드부분 -->
			                    <span class="badge bg-danger"><s:property value="title"/></span><!-- 일겹살 뜨는 부분 -->
			                </time>
			            	<span class="event-icon event-icon-danger"><!-- 아이콘 (아이템) -->
			            		<!-- 중간 마커 표시 -->
			                    <i class="glyphicon glyphicon-map-marker"></i>
			                </span>
		                </s:if>
		                <s:if test="#cust_stat.first == false && #cust_stat.last == false">
							<time class="event-time" datetime="2014-05-19 03:04"><!-- 노드부분 -->
			                    <span class="badge bg-info"><s:property value="title"/></span><!-- 일겹살 뜨는 부분 -->
			                </time>
		                	<span class="event-icon event-icon-info"><!-- 아이콘 (아이템) -->
			                    <i class="glyphicon glyphicon-map-marker"></i>
			                </span>
		                </s:if>
		                
		                <section class="event"><!-- 사진 담길 곳....... -->
		                    <span class="thumb-sm avatar pull-left mr-sm">
		                        <img class="img-circle" src="demo/img/people/a2.jpg" alt="...">
		                    </span>
		                    <h4 class="event-heading"><a href="#">Jessica Nilson</a> <small>@jess</small></h4>
		                    <p class="fs-sm text-muted">10:12 am - Publicly near Minsk</p>
		                    
		                   	<!--  사진 업로드 하면 바로 담기는 div 태그, 이걸 밑에 div로 옮겨야 할 듯. -->
		                    <div class="event-image" id='<s:property value="itemlist[#cust_stat.index].item_id"/>'>	
		                   		<a href="#">
		                        	<img class="demo_image" src=""/>
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
	                            			<input type="hidden" class="item_no testYB" value='<s:property value="itemlist[#cust_stat.index].item_id"/>'/>
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
											<input class="form-control input-sm recontent" type="text" id="recontent2" name="recontent" />
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
											<input class="form-control input-sm recontent" type="text" id="recontent4" name="recontent" />
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
						
						<div class="widget-body pic_upload_btn">
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
    		 	
    		 	$('.event-image').on('click', function(){
    		 		temp = "";
    		 		i = 0;
    		 		$('.view_photo').append("<a id='chevron-left-btn' href='#'><img src='img/photoBtn_left.jpg' id='chevron-left'/></a>");
    		 		$('.view_photo').append("<a id='chevron-right-btn' href='#'><img src='img/photoBtn_right.jpg' id='chevron-right'/></a>");
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
    				//return false; 하면 따라가진 않는데 팝업 창이 맨 위에 생성됨.
    			});//사진 올리기 아이콘 클릭 시, 팝업 효과
    		
    		    $('#overlay_photo, .close').click(function(e){ 
    		        e.preventDefault(); 
    		        if($('.MultiFile-remove').length){
	    		        $('.MultiFile-remove')[0].click();
    		        }
    		        $('#popup_layer_photo, #overlay_photo').hide(); 
    		    });//팝업 효과 나타났을 때, 다른 부분 클릭하면 사라지는 효과
    		    
    		    
    		 	$('.photo_upload').on('click', function(){
    		 		var temp = $(this).parent().children('.item_no').val();
    		 		$('#item_number').val(temp);
        		 	var temp2 = $('#item_number').val();
    		 	});//사진 등록할 때, 해당 item_no를 FORM안에 hidden값으로 넣고 가져감.
    		 
    			$('#upload_pic_btn').on('click', function(){
  					$('input[type=file]:first').trigger('click');
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
									"<a class='allImage img_"+map_itemNo[index]+"' href='#'><img class='demo_image' src='image/"+map_itemNo[index]+"/"+map_savedFile[index]+"' alt='...'/></a>"
								);//append
							});//each
						$('.MultiFile-remove')[0].click();
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