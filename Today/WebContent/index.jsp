
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>오늘 뭐하지?</title>
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
    
	<!-- TMap API 스크립트 추가 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> 
	<script src="https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=a35c8baf-b97e-3edc-8b03-5092e9e38b3f"></script>
	
	
	
	
	<!-- YB 브랜치 테스트 입니다.  
		YB 브랜치 테스트 두번째
	-->
	
	
	
	<!-- ksh edit -->
	<script type="text/javascript">
	$(document).ready(function () {
		
	initTmap();
		
	//초기화 함수
	function initTmap(lat, lng){
	    
		if(lat!=null&&lng!=null){
			
			/* alert(lat);
			alert(lng); */
			
			//pr_3857 인스탄스 생성.
			var pr_4326 = new Tmap.Projection("EPSG:4326");
			
			//pr_3857 인스탄스 생성.
			var pr_3857 = new Tmap.Projection("EPSG:3857");
			
			var x = get3857LonLat(lng, lat);
			
			//WGS84GEO -> EPSG:3857 좌표형식 변환
			function get3857LonLat(coordX, coordY){
			    return new Tmap.LonLat(coordX, coordY).transform(pr_4326, pr_3857);
			}
			
			//맵 중심좌표 세팅
			map.setCenter(x, 14);
			
			//줌 레벨 선택
			map.zoomTo(20);
		
		//검색 지역이 없을 때 기본 값 설정
		} else { 
			centerLL = new Tmap.LonLat(14145677.4, 4511257.6);
			
		    map = new Tmap.Map({div:'gmap',
		                        width:'100%', 
		                        height:'100%',
		                        transitionEffect:"resize",
		                        animation:true
		                    });
		    
		    
		    //searchRoute();
		    
		}
	};
	
	
	
	var ybArray2 = [];
	/* 장민식 *//* 아이템 검색 데이터 호출*/
	$('#searchRoad').click(function() {
		
		$(".itemField").each(function(idx){
	        var item = $(".itemField:eq(" + idx + ")").val() ;
	        
			ybArray2.push(item);
	        
	        $.ajax({
	        	method: "post"
	        	, url: "map/sendItem"
	        	, dataType: "json"
	        	, data: {"itemList":item}
	        });//ajax
	        
	      });//each
	      yb_test(ybArray2);//사용자가 입력한 키워드들이 담김
	});//검색버튼 클릭
	
	//유병훈
	var ybArray = [];
	function yb_test(ybArray2){

		$.each(ybArray2, function(index, val){

			var local = $("#searchLocal").val();
			var url = "https://apis.daum.net/local/v1/search/keyword.json?";
			url += "&apikey=8b061e21394885aaa3c204bedd0f494e";
			url += "&query=" + local + " " + ybArray2[index];
			url += "&sort=1";
			url += "&count=1";
			
/* 			var script = document.createElement('script');
			script.src = url;
			document.head.appendChild(script); */
			
			/* item은 키워드 검색 한 String 값을 가져오고,
				밑에 ajax는 daum 검색 api의 url을 이용해서 결과값을 가져옴.
				거기서 받은 결과(data)의 좌표값을 searchRoute로 한꺼번에 보내야 하는데..
				*/ 
			$.ajax(url, {
				dataType: 'jsonp',
				success: function(data){
					var test = data.channel.item;
					
					$.each(test, function(index, val){
						//pr_3857 인스탄스 생성.
						var pr_4326 = new Tmap.Projection("EPSG:4326");
						
						//pr_3857 인스탄스 생성.
						var pr_3857 = new Tmap.Projection("EPSG:3857");
						
						var x = get3857LonLat(test[index].longitude, test[index].latitude);
						ybArray.push(x);
						
						//WGS84GEO -> EPSG:3857 좌표형식 변환
						function get3857LonLat(coordX, coordY){
						    return new Tmap.LonLat(coordX, coordY).transform(pr_4326, pr_3857);
						}//get3857LonLat
					});//each
				}//success
			});//ajax 
		});//each
		
		searchRoute();
	}//yb_test
	
	//유병훈
		
	//경로 정보 로드
	function searchRoute(){
		alert('searchRoute 불림');
	     var routeFormat = new Tmap.Format.KML({extractStyles:true, extractAttributes:true});
	     var startX = ybArray[0].lon;
	     var startY = ybArray[0].lat;
	     var endX = ybArray[1].lon;
	     var endY = ybArray[1].lat;
	     var pass1X;
	     var pass1Y;
	     var pass2X;
	     var pass2Y;
	     var pass3X;
	     var pass3Y;

	     var startName = "홍대입구";
	     var endName = "명동";
	     var urlStr = "https://apis.skplanetx.com/tmap/routes/pedestrian?version=1&format=xml";
	         urlStr += "&startX="+startX;
	         urlStr += "&startY="+startY;
	         urlStr += "&endX="+endX;
	         urlStr += "&endY="+endY;
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
	     //경로 레이어 추가
	     setLayers();
    
	     var startX = ybArray[0].lon;
	     var startY = ybArray[0].lat;
	     var endX = ybArray[1].lon;
	     var endY = ybArray[1].lat;
         var startName = "홍대입구";
         var endName = "명동";
         var urlStr = "https://apis.skplanetx.com/tmap/routes/pedestrian?version=1&format=json";
             urlStr += "&startX="+startX;
             urlStr += "&startY="+startY;
             urlStr += "&endX="+endX;
             urlStr += "&endY="+endY;
             //urlStr += "&passList="+"14135893.887852, 4518348.1852606_14135881.887852, 4519591.4745242_14134881.887852, 4517572.4745242";
             urlStr += "&startName="+encodeURIComponent(startName);
             urlStr += "&endName="+encodeURIComponent(endName);
             urlStr += "&appKey=a35c8baf-b97e-3edc-8b03-5092e9e38b3f";
		    
		    
	    $.getJSON(urlStr, function(data){
		   	$.each(data, function(key, value){
		   		
		   			if(key==="features"){
		   				$('#totalTime').val(Math.round(value[0].properties.totalTime/60) + "분");
		   				$('#totalDistance').val(value[0].properties.totalDistance + "M");
		   			}
		   	});//each end
	    });//getJSON end  
		}//searchRoute end
		
		//경로 그리기 후 해당영역으로 줌
		function onDrawnFeatures(e){
		    map.zoomToExtent(this.getDataExtent());
		}
			
			
		/* 장민식 *//* Locale(지역)검색 function */
		$("#searchLocal").on("keypress", function() {
			if ( event.which == 13 ) {
				var local = $("#searchLocal").val();
				$.ajax({
					method: "post"
					, url: "map/sendLocal.action"
					, dataType: "json"
					, data: {"local":local}
					, success: successFunc
				});
			  }
		});
		
		//검색 지명 중심 좌표로 이동
		function successFunc(response){
			
		    urlStr = "https://maps.googleapis.com/maps/api/geocode/json?&key=AIzaSyCBo-zr3K1N7rrX2Qh9C3ITBHoh1Dcfswk";
		    urlStr += "&address="+response.local;
		    
		    $.getJSON(urlStr, function(data){
		    	
			   	$.each(data, function(key, value){
			   		
			   			if(key==="results"){
			   				var lat = value[0].geometry.location.lat;
			   				var lng = value[0].geometry.location.lng;
			   				initTmap(lat,lng);
			   			}
			   	});
			  }); 
		    
		}
		
		//경유지 레이어 추가
		function setLayers(){
		
			//marker A 표시
			var markerLayer = new Tmap.Layer.Markers();
			map.addLayer(markerLayer);
			 
			var lonlatA = new Tmap.LonLat(14135893.887852, 4518348.1852606);
			 
			var size = new Tmap.Size(38,48);
			var offset = new Tmap.Pixel(-(size.w/2), -(size.h/2));
			var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_a.png', size, offset); 
			     
			var marker = new Tmap.Marker(lonlatA, icon);
			
			markerLayer.addMarker(marker);
			
			//popup 생성 A Maker Click시 이벤트 발생시에 보이기 안보이기 반복 		
			var clickCheckA = 1;//Click 반복시 이벤트 분기를 위한 변수
			var popupA;
			marker.events.register("click", marker, onOverMarkerA);
			
			function onOverMarkerA(evt){
				
				if(clickCheckA===1){
				popupA = new Tmap.Popup("p1",
										lonlatA,
				                        new Tmap.Size(270, 270),
				                        "<div><a href='http://www.naver.com'><img src='image/food1.ico'/></a></div>"
				                        ); 
				map.addPopup(popupA);
				popupA.show();
				} else {
					popupA.hide();
				}
				
				clickCheckA = clickCheckA * (-1);
			}
			
			//marker B 표시	
			var markerLayer = new Tmap.Layer.Markers();
			map.addLayer(markerLayer);
			 
			var lonlatB = new Tmap.LonLat(14135881.887852, 4519591.4745242);
			 
			var size = new Tmap.Size(38,48);
			var offset = new Tmap.Pixel(-(size.w/2), -(size.h/2));
			var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_b.png', size, offset); 
			     
			var marker = new Tmap.Marker(lonlatB, icon);
			markerLayer.addMarker(marker);
			
			//popup 생성 B Maker Click시 이벤트 발생시에 보이기 안보이기 반복 		
			var clickCheckB = 1;//Click 반복시 이벤트 분기를 위한 변수
			var popupB;
			marker.events.register("click", marker, onOverMarkerB);
			
			function onOverMarkerB(evt){
				
				if(clickCheckB===1){
				popupB = new Tmap.Popup("p1",
										lonlatB,
				                        new Tmap.Size(270, 270),
				                        "<div><a href='http://www.naver.com'><img src='image/food2.ico'/></a></div>"
				                        ); 
				map.addPopup(popupB);
				popupB.show();
				} else {
					popupB.hide();
				}
				
				clickCheckB = clickCheckB * (-1);
			}
			
			//marker C 표시	
			var markerLayer = new Tmap.Layer.Markers();
			map.addLayer(markerLayer);
			 
			var lonlatC = new Tmap.LonLat(14134881.887852, 4517572.4745242);
			 
			var size = new Tmap.Size(38,48);
			var offset = new Tmap.Pixel(-(size.w/2), -(size.h/2));
			var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_c.png', size, offset); 
			     
			var marker = new Tmap.Marker(lonlatC, icon);
			markerLayer.addMarker(marker);
			 
			//popup 생성 C Maker Click시 이벤트 발생시에 보이기 안보이기 반복 		
			var clickCheckC = 1;//Click 반복시 이벤트 분기를 위한 변수
			var popupC;
			marker.events.register("click", marker, onOverMarkerC);
			
			function onOverMarkerC(evt){
				
				if(clickCheckC===1){
				popupC = new Tmap.Popup("p1",
										lonlatC,
				                        new Tmap.Size(270, 270),
				                        "<div><a href='http://www.naver.com'><img src='image/food3.ico'/></a></div>"
				                        ); 
				map.addPopup(popupC);
				popupC.show();
				} else {
					popupC.hide();
				}
				
				clickCheckC = clickCheckC * (-1);
			}
		}
		
		/* 장민식 *//* 아이템 검색 필드 (추가) */
		var count = 0; /* 아이템 필드 최대 5개 추가를 위한 count 변수 */
		$('#addItemField').click(function() {
			if (count < 3) {
				$('.sidebar-labels>.endItemField').before(
					"<li id='addedItemField'>"
					+ "<a>"
					+ "<i class='fa fa-circle text-gray mr-xs' ></i>&nbsp;"
	            	+ "<span class='label-name'><input type='text' class='itemField'></span>"
	            	+ "</a>"
	            	+ "</li>"
				);
				count++;
			} else if(count == 3) {
				var htm = "<div class='alert alert-danger alert-sm fade in'>"
				+ "<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&nbsp;×&nbsp;</button>"
				+ "<span class='fw-semi-bold'>Warning : 경로는 최소 2곳 최대 5곳만 지정할 수 있습니다.&nbsp;</span>";
          		+ "</div>"
          		
				$('#alertArea').html(htm);
			}
		});
		
		/* 장민식 *//* 아이템 검색 필드 (삭제) */
		$('#removeItemField').click(function() {
			$('#addedItemField:first').remove();
			if (count > 0) {
				count--;
			}
		});
		
	
		
	
	
	//login
	
    $('.trigger').click(function(){ 
        $('#popup_layer, #overlay_t').show(); 
        //$('#popup_layer').css("top", Math.max(0, $(window).scrollTop() + 100) + "px"); 
        // $('#popup_layer').css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px"); 
    }); 
    $('#overlay_t, .close').click(function(e){ 
        e.preventDefault(); 
        $('#popup_layer, #overlay_t').hide(); 
    });


	});/* document.ready function end */
	
	
    /* login - jhs  */
    function formSubmit() {
     	 
     		var form = document.getElementById('loginform');
     		var email = document.getElementById('email');
     		var password = document.getElementById('password');
     		
     		if (email.value == '') {
     			alert('ID를 입력하세요.');
     			return;
     		}
     		if (password.value == '') {
     			alert('비밀번호를 입력하세요.');
     			return;
     		}
     		
     		form.submit();
     	}/* login end - jhs  */
     	
    	
	</script>
	<!-- ksh edit end -->
	
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
            <a href="index.jsp">singg</a>
        </header>
        <!-- seems like lots of recent admin template have this feature of user info in the sidebar.
             looks good, so adding it and enhancing with notifications -->
        <div class="sidebar-status visible-xs">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <span class="thumb-sm avatar pull-right">
                	<!-- 상단 오른쪽 -->
                </span>
                <!-- .circle is a pretty cool way to add a bit of beauty to raw data.
                     should be used with bg-* and text-* classes for colors -->
                <span class="circle bg-warning fw-bold text-gray-dark">
                    13
                </span>
                &nbsp;Philip <strong>Smith</strong>
                <b class="caret"></b>
            </a>
            <!-- #notifications-dropdown-menu goes here when screen collapsed to xs or sm -->
        </div>
        <!-- main notification links are placed inside of .sidebar-nav -->
        <ul class="sidebar-nav">



        </ul>
        <!-- every .sidebar-nav may have a title -->
        <h5 class="sidebar-nav-title">Hello <strong>gogoThing99</strong> <a class="action-link" href="#"><i class="fa fa-map-marker"></i></a></h5>
        <ul class="sidebar-nav">
        
                        <li class="active">
                <a href="#sidebar-maps" data-toggle="collapse" data-parent="#sidebar">
                    <span class="icon">
                        <i class="glyphicon glyphicon-map-marker"></i>
                    </span>
                    Maps
                    <i class="toggle fa fa-angle-down"></i>
                </a>
                <ul id="sidebar-maps" class="collapse in">
                    <li class="active"><a href="index.jsp" data-no-pjax>Search Maps</a></li>
                </ul>
            </li>
            
            
            <li>
                <a class="collapsed" href="#sidebar-levels" data-toggle="collapse" data-parent="#sidebar">
                    <span class="icon">
                        <i class="fa fa-folder-open"></i>
                    </span>
                    Menu Levels
                    <i class="toggle fa fa-angle-down"></i>
                </a>
                <ul id="sidebar-levels" class="collapse">
                    <li><a href="#">Level 1</a></li>
                    <li>
                        <a class="collapsed" href="#sidebar-sub-levels" data-toggle="collapse" data-parent="#sidebar-levels">
                            Level 2
                            <i class="toggle fa fa-angle-down"></i>
                        </a>
                        <ul id="sidebar-sub-levels" class="collapse">
                            <li><a href="#">Level 3</a></li>
                            <li><a href="#">Level 3</a></li>
                        </ul>
                    </li>
                </ul>
            </li>
        </ul>
        <!-- 장민식 --><!-- 아이템 추가 버튼 필드 -->
        <h5 class="sidebar-nav-title"><br>
	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        <button class="btn btn-inverse btn-xs mb-xs" id="addItemField" role="button">
				&nbsp;&nbsp;<i class="fa fa-plus"></i>&nbsp;&nbsp;
			</button>&nbsp;&nbsp;
	        <button class="btn btn-inverse btn-xs mb-xs" id="removeItemField" role="button">
				&nbsp;&nbsp;<i class="fa fa-minus"></i>&nbsp;&nbsp;
			</button>&nbsp;&nbsp;&nbsp;
        </h5>
        <!-- some styled links in sidebar. ready to use as links to email folders, projects, groups, etc -->
        <ul class="sidebar-labels">
            <li class="firstItemField">
				<a>
				<i class="fa fa-circle text-warning mr-xs"></i>
				<span class="label-name"><input type="text" class="itemField"></span>
				</a>
            </li>
            <li class="endItemField">
                <a>
                    <i class="fa fa-circle text-danger mr-xs"></i>
                    <span class="label-name"><input type="text" class="itemField"></span>
                </a>
            </li>
        </ul>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <button class="btn btn-warning btn-xs mb-xs" id="searchRoad" role="button">
				&nbsp;&nbsp;<i class="fa fa-search">&nbsp;SEARCH</i>&nbsp;&nbsp;
		</button>
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
                <li class="ml-sm mr-n-xs hidden-xs"><a href="index.jsp"><i class="fa fa-refresh fa-lg"></i></a></li>
                <li class="ml-n-xs hidden-xs"><a href="#"><i class="fa fa-times fa-lg"></i></a></li>
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
            <a class="navbar-brand visible-xs" href="index.html">
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
                        <input class="form-control" type="text" id="searchLocal" name="searchLocal" placeholder="지역을 검색해주세요">
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
						<strong><s:property value="#session.loginId" /></strong>&nbsp;
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
                <li>
                    <a href="#" data-toggle="chat-sidebar">
                        <i class="fa fa-globe fa-lg"></i>
                    </a>
                    <div id="chat-notification" class="chat-notification hide">
                        <div class="chat-notification-inner">
                            <h6 class="title">
                                <span class="thumb-xs">
                                    <img src="demo/img/people/a6.jpg" class="img-circle mr-xs pull-left">
                                </span>
                                Jess Smith
                            </h6>
                            <p class="text">Hey! What's up?</p>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="chat-sidebar" id="chat">
    <div class="chat-sidebar-content">
        <header class="chat-sidebar-header">
            <h4 class="chat-sidebar-title">Contacts</h4>
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
            <h5 class="sidebar-nav-title">Today</h5>
            <div class="list-group chat-sidebar-user-group">
                <a class="list-group-item" href="#chat-sidebar-user-1">
                    <i class="fa fa-circle text-success pull-right"></i>
                    <span class="thumb-sm pull-left mr">
                        <img class="img-circle" src="demo/img/people/a2.jpg" alt="...">
                    </span>
                    <h5 class="message-sender">Chris Gray</h5>
                    <p class="message-preview">Hey! What's up? So many times since we</p>
                </a>
                <a class="list-group-item" href="#chat-sidebar-user-2">
                    <i class="fa fa-circle text-gray-light pull-right"></i>
                <span class="thumb-sm pull-left mr">
                    <img class="img-circle" src="img/avatar.png" alt="...">
                </span>
                    <h5 class="message-sender">Jamey Brownlow</h5>
                    <p class="message-preview">Good news coming tonight. Seems they agreed to proceed</p>
                </a>
                <a class="list-group-item" href="#chat-sidebar-user-3">
                    <i class="fa fa-circle text-danger pull-right"></i>
                <span class="thumb-sm pull-left mr">
                    <img class="img-circle" src="demo/img/people/a1.jpg" alt="...">
                </span>
                    <h5 class="message-sender">Livia Walsh</h5>
                    <p class="message-preview">Check out my latest email plz!</p>
                </a>
                <a class="list-group-item" href="#chat-sidebar-user-4">
                    <i class="fa fa-circle text-gray-light pull-right"></i>
                <span class="thumb-sm pull-left mr">
                    <img class="img-circle" src="img/avatar.png" alt="...">
                </span>
                    <h5 class="message-sender">Jaron Fitzroy</h5>
                    <p class="message-preview">What about summer break?</p>
                </a>
                <a class="list-group-item" href="#chat-sidebar-user-5">
                    <i class="fa fa-circle text-success pull-right"></i>
                <span class="thumb-sm pull-left mr">
                    <img class="img-circle" src="demo/img/people/a4.jpg" alt="...">
                </span>
                    <h5 class="message-sender">Mike Lewis</h5>
                    <p class="message-preview">Just ain't sure about the weekend now. 90% I'll make it.</p>
                </a>
            </div>
            <h5 class="sidebar-nav-title">Last Week</h5>
            <div class="list-group chat-sidebar-user-group">
                <a class="list-group-item" href="#chat-sidebar-user-6">
                    <i class="fa fa-circle text-gray-light pull-right"></i>
                <span class="thumb-sm pull-left mr">
                    <img class="img-circle" src="demo/img/people/a6.jpg" alt="...">
                </span>
                    <h5 class="message-sender">Freda Edison</h5>
                    <p class="message-preview">Hey what's up? Me and Monica going for a lunch somewhere. Wanna join?</p>
                </a>
                <a class="list-group-item" href="#chat-sidebar-user-7">
                    <i class="fa fa-circle text-success pull-right"></i>
                <span class="thumb-sm pull-left mr">
                    <img class="img-circle" src="demo/img/people/a5.jpg" alt="...">
                </span>
                    <h5 class="message-sender">Livia Walsh</h5>
                    <p class="message-preview">Check out my latest email plz!</p>
                </a>
                <a class="list-group-item" href="#chat-sidebar-user-8">
                    <i class="fa fa-circle text-warning pull-right"></i>
                <span class="thumb-sm pull-left mr">
                    <img class="img-circle" src="demo/img/people/a3.jpg" alt="...">
                </span>
                    <h5 class="message-sender">Jaron Fitzroy</h5>
                    <p class="message-preview">What about summer break?</p>
                </a>
                <a class="list-group-item" href="#chat-sidebar-user-9">
                    <i class="fa fa-circle text-gray-light pull-right"></i>
                <span class="thumb-sm pull-left mr">
                    <img class="img-circle" src="img/avatar.png" alt="...">
                </span>
                    <h5 class="message-sender">Mike Lewis</h5>
                    <p class="message-preview">Just ain't sure about the weekend now. 90% I'll make it.</p>
                </a>
            </div>
        </div>
        <div class="chat-sidebar-chat chat-sidebar-panel" id="chat-sidebar-user-1">
            <h5 class="title">
                <a class="js-back" href="#">
                    <i class="fa fa-angle-left mr-xs"></i>
                    Chris Gray
                </a>
            </h5>
            <ul class="message-list">
                <li class="message">
                    <span class="thumb-sm">
                        <img class="img-circle" src="demo/img/people/a2.jpg" alt="...">
                    </span>
                    <div class="message-body">
                        Hey! What's up?
                    </div>
                </li>
                <li class="message">
                    <span class="thumb-sm">
                        <img class="img-circle" src="demo/img/people/a2.jpg" alt="...">
                    </span>
                    <div class="message-body">
                        Are you there?
                    </div>
                </li>
                <li class="message">
                    <span class="thumb-sm">
                        <img class="img-circle" src="demo/img/people/a2.jpg" alt="...">
                    </span>
                    <div class="message-body">
                        Let me know when you come back.
                    </div>
                </li>
                <li class="message from-me">
                    <span class="thumb-sm">
                        <img class="img-circle" src="img/avatar.png" alt="...">
                    </span>
                    <div class="message-body">
                        I am here!
                    </div>
                </li>
            </ul>
        </div>
        <div class="chat-sidebar-chat chat-sidebar-panel" id="chat-sidebar-user-2">
            <h5 class="title">
                <a class="js-back" href="#">
                    <i class="fa fa-angle-left mr-xs"></i>
                    Jamey Brownlow
                </a>
            </h5>
            <ul class="message-list">
            </ul>
        </div>
        <div class="chat-sidebar-chat chat-sidebar-panel" id="chat-sidebar-user-3">
            <h5 class="title">
                <a class="js-back" href="#">
                    <i class="fa fa-angle-left mr-xs"></i>
                    Livia Walsh
                </a>
            </h5>
            <ul class="message-list">
            </ul>
        </div>
        <div class="chat-sidebar-chat chat-sidebar-panel" id="chat-sidebar-user-4">
            <h5 class="title">
                <a class="js-back" href="#">
                    <i class="fa fa-angle-left mr-xs"></i>
                    Jaron Fitzroy
                </a>
            </h5>
            <ul class="message-list">
            </ul>
        </div>
        <div class="chat-sidebar-chat chat-sidebar-panel" id="chat-sidebar-user-5">
            <h5 class="title">
                <a class="js-back" href="#">
                    <i class="fa fa-angle-left mr-xs"></i>
                    Mike Lewis
                </a>
            </h5>
            <ul class="message-list">
            </ul>
        </div>
        <div class="chat-sidebar-chat chat-sidebar-panel" id="chat-sidebar-user-6">
            <h5 class="title">
                <a class="js-back" href="#">
                    <i class="fa fa-angle-left mr-xs"></i>
                    Freda Edison
                </a>
            </h5>
            <ul class="message-list">
            </ul>
        </div>
        <div class="chat-sidebar-chat chat-sidebar-panel" id="chat-sidebar-user-7">
            <h5 class="title">
                <a class="js-back" href="#">
                    <i class="fa fa-angle-left mr-xs"></i>
                    Livia Walsh
                </a>
            </h5>
            <ul class="message-list">
            </ul>
        </div>
        <div class="chat-sidebar-chat chat-sidebar-panel" id="chat-sidebar-user-8">
            <h5 class="title">
                <a class="js-back" href="#">
                    <i class="fa fa-angle-left mr-xs"></i>
                    Jaron Fitzroy
                </a>
            </h5>
            <ul class="message-list">
            </ul>
        </div>
        <div class="chat-sidebar-chat chat-sidebar-panel" id="chat-sidebar-user-9">
            <h5 class="title">
                <a class="js-back" href="#">
                    <i class="fa fa-angle-left mr-xs"></i>
                    Mike Lewis
                </a>
            </h5>
            <ul class="message-list">
            </ul>
        </div>
        <footer class="chat-sidebar-footer form-group">
            <input class="form-control input-dark fs-mini" id="chat-sidebar-input" type="text"  placeholder="Type your message">
        </footer>
    </div>
</div>

<div class="content-wrap">
    <!-- main page content. the place to put widgets in. usually consists of .row > .col-md-* > .widget.  -->
    <main id="content" class="content" role="main">
        <div id="gmap" class="content-map">
        </div>
        <h1 class="page-title">私の <span class="fw-semi-bold">夢</span></h1>
        <div class="content-map-controls">
            <div class="btn-group btn-group-sm">
                <!-- <button class="btn btn-inverse" id="gmap-zoom-in"><i class="fa fa-plus"></i></button>
                <button class="btn btn-inverse" id="gmap-zoom-out"><i class="fa fa-minus"></i></button> -->
            </div>
        </div>
        
		<!-- 장민식 --><!-- alert 경고창 위치 -->
		<section id="alertSection" class="widget" style="background-color:transparent;">
			<div class="widget-body" id="alertArea">
			</div>
		</section>
    </main>
    
    <!-- ksh_edit -->
	<div id="foot">
      	<span>이동 시간</span><input type="text" id="totalTime">&nbsp;&nbsp;<span>이동 거리</span><input type="text" id="totalDistance">
    </div>
    <!-- ksh edit end -->
    
</div>

<!-- loginform jhs -->
<div id="overlay_t"></div> 
<div id="popup_layer">
                <section class="widget widget-login animated fadeInUp">
                    <header>
                        <h3>Login to your Sing App</h3>
                    </header>
                    <div class="widget-body">
                        <form class="login-form mt-lg" id="loginform" action="customer/login.action" method="post">
                            <div class="form-group">
                                <input type="text" class="form-control" id="email" name="email" placeholder="Username">
                            </div>
                            <div class="form-group">
                                <input class="form-control" id="password" name="password" type="text" placeholder="Password">
                            </div>
                            <div class="clearfix">
                                <div class="btn-toolbar pull-xs-right">
                                    <button type="button" class="btn btn-secondary btn-sm">Create an Account</button>
                                    <a class="btn btn-inverse btn-sm" href="javascript:formSubmit()">Login</a>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 col-md-push-6">
                                    <div class="clearfix">
                                        <div class="abc-checkbox widget-login-info pull-xs-right ml-n-lg">
                                            <input type="checkbox" id="checkbox1" value="1">
                                            <label for="checkbox1">Keep me signed in </label>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </form>
                    </div>
                </section>
</div><!-- loginform end jhs -->


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

	
    
</body>
</html>