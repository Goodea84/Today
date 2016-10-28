
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
    
	<!-- 다음 로드뷰 API 추가 -->
    <script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=d0224817161ef3c311a65c73ea03f837"></script>
    
	<!-- TMap API 스크립트 추가 -->
	<script src="https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=a35c8baf-b97e-3edc-8b03-5092e9e38b3f"></script>
	
	
	
	<!-- 김승훈 edit -->
	<script type="text/javascript">
	$(document).ready(function () {
		
	$.ajaxSettings.traditional = true;	
	initTmap();
	$('#foot').css('display', 'none');//최초에 하단 바 안보이도록(유병훈)
	$('#above_foot').css('display', 'none');
		
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
	};//initMap
	
	var ybArray2 = [];//민식이 형이 input text로 받은 아이템들 담는 배열
	var ybArray3 = [];//블로그 정보를 보내기 위한 변수
	var itemCount = 0;
	var itemRecommendCount = 0;
	
	/* 장민식 *//* 아이템 검색 데이터 호출*/
	$('#searchRoad').click(function() {
	ybArray.length = 0;
    ybArray2.length = 0;
	ybArray3.length = 0;
	itemRecommendCount = 0;
	spotNum = 0;
	$('#above_foot').css('display', 'none');
	
	var item = [];
		$(".itemField").each(function(idx){
	        var item0 = $(".itemField:eq(" + idx + ")").val();
			item.push(encodeURI(item0));
			
	     });//each
	      
        $.ajax({
        	method: "post"
        	, url: "map/sendItem"
        	, dataType: "json"
        	, data: {"itemList":item}
        	, success: function(response) {
				var recommendedItem = response.recommendedItem;
				$(recommendedItem).each(function(index, value) {
					var jsonValue = JSON.parse(value);
					//alert(JSON.stringify(jsonValue));
					//alert(jsonValue.item[index].title);
					ybArray2.push(jsonValue);//사용자가 입력한 키워드들이 담김
					ybArray3.push(jsonValue);
				});
				itemCount = ybArray3.length;
			    yb_test(ybArray2);//크롤링 해서 추천하는 장소 위도, 경도 담는 function으로 이동
			}
        });//ajax
	});//검색버튼 클릭
	
	//유병훈
	var ybArray = [];//각 아이템당 추천장소 받아와 위도, 경도 담는 배열
	var url01;
	var url02;
	var local;
	
	function yb_test(ybArray2, a, b, c, d, e){
		
		var max = ybArray2.length;
		var i = 0;
		$.each(ybArray2, function(index, value){
			
			//alert(test[index].title);
			//pr_3857 인스탄스c 생성.
			var pr_4326 = new Tmap.Projection("EPSG:4326");
			//pr_3857 인스탄스 생성.
			var pr_3857 = new Tmap.Projection("EPSG:3857");
			if(i===0&&a!=null){
				var x = get3857LonLat(value.item[a].longitude, value.item[a].latitude);
			}else if(i===1&&b!=null){
				var x = get3857LonLat(value.item[b].longitude, value.item[b].latitude);
			}else if(i===2&&c!=null){
				var x = get3857LonLat(value.item[c].longitude, value.item[c].latitude);
			}else if(i===3&&d!=null){
				var x = get3857LonLat(value.item[d].longitude, value.item[d].latitude);
			}else if(i===4&&e!=null){
				var x = get3857LonLat(value.item[e].longitude, value.item[e].latitude);
			}else{
				var x = get3857LonLat(value.item[0].longitude, value.item[0].latitude);
			}
			ybArray.push(x);
			i++;
			//WGS84GEO -> EPSG:3857 좌표형식 변환
			function get3857LonLat(coordX, coordY){
			    return new Tmap.LonLat(coordX, coordY).transform(pr_4326, pr_3857);
			}//get3857LonLat
			if(i>=max){
				searchRoute(ybArray);
			}//if
				
		});//each
	}//yb_test
	//유병훈
	
	//경로 정보 로드
	function searchRoute(ybArray){
		map.destroy();
		initTmap();
		/* 맵 새로고침 */
		
		$('#pass_1').css('display', 'none');
		$('#pass_2').css('display', 'none');
		$('#pass_3').css('display', 'none');
		$('#pass_4').css('display', 'none');
		$('#pass_5').css('display', 'none');
		/* 최초 경로 버튼 감추기 */

		var length = ybArray.length;
		var startX = ybArray[0].lon;//출발지
		var startY = ybArray[0].lat;
		var endX = ybArray[length-1].lon;//도착지
		var endY = ybArray[length-1].lat;
		
		$('#foot').css('display', '');//유병훈 하단 BAR 보이게
		
		//장민식 하단 아이템 노드를 순서대로/갯수에 따른 포지션/갯수에 따른 색상 css 변경
		$.each(ybArray, function(index, val){
		/* 경로 버튼 해당 하는 만큼 보이기 */
			$('#pass_'+(index+1)).css('display', '');
			if (index == 0) {
				$('#pass_1').addClass('pass_1');
			} else {
				$('#pass_' +(index+1)).addClass('pass_'+(index+1));
				$('#pass_' +(index+1)).css('background-color', '#919191');
				$('#pass_' +(index+1)).css('border-color', '#b5b5b5');
			} 
		});//each
		$('#pass_' + ybArray.length).css('background-color', '#dd5826');
		$('#pass_' + ybArray.length).css('border-color', '#e27045');
		  
		 var routeFormat = new Tmap.Format.KML({extractStyles:true, extractAttributes:true});

	     var startName = "홍대입구";
	     var endName = "명동";
	     var urlStr = "https://apis.skplanetx.com/tmap/routes/pedestrian?version=1&format=xml";
	         urlStr += "&startX="+startX;
	         urlStr += "&startY="+startY;
	         urlStr += "&endX="+endX;
	         urlStr += "&endY="+endY;
	     //경유지 추가 분기 처리
         if(length===3){
			 urlStr += "&passList="+ybArray[1].lon+","+ybArray[1].lat;
		 }else if(length===4){
			 urlStr += "&passList="+ybArray[1].lon+","+ybArray[1].lat+"_"+ybArray[2].lon+","+ybArray[2].lat;
		 }else if(length===5){
			 urlStr += "&passList="+ybArray[1].lon+","+ybArray[1].lat+"_"+ybArray[2].lon+","+ybArray[2].lat+"_"+ybArray[3].lon+","+ybArray[3].lat;
			 
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
	     //경로 레이어 추가
	     setLayers(length, ybArray);
     
         var startName = "홍대입구";
         var endName = "명동";
	     var urlStr = "https://apis.skplanetx.com/tmap/routes/pedestrian?version=1&format=json";
         urlStr += "&startX="+startX;
         urlStr += "&startY="+startY;
         urlStr += "&endX="+endX;
         urlStr += "&endY="+endY;
	     if(length===3){
			urlStr += "&passList="+ybArray[1].lon+","+ybArray[1].lat;
		 }else if(length===4){
			 urlStr += "&passList="+ybArray[1].lon+","+ybArray[1].lat+"_"+ybArray[2].lon+","+ybArray[2].lat;
		 }else if(length===5){
			 urlStr += "&passList="+ybArray[1].lon+","+ybArray[1].lat+"_"+ybArray[2].lon+","+ybArray[2].lat+"_"+ybArray[3].lon+","+ybArray[3].lat;
		 }
            //urlStr += "&passList="+"14135893.887852, 4518348.1852606_14135881.887852, 4519591.4745242_14134881.887852, 4517572.4745242";
            urlStr += "&startName="+encodeURIComponent(startName);
            urlStr += "&endName="+encodeURIComponent(endName);
            urlStr += "&appKey=a35c8baf-b97e-3edc-8b03-5092e9e38b3f";
		    
		  
		    $.getJSON(urlStr, function(data){
			   	$.each(data, function(key, value){
		   			if(key==="features"){
		   				$('#totalTime').text(Math.round(value[0].properties.totalTime/60) + " minute");
		   				$('#totalDistance').text(value[0].properties.totalDistance + " meter");

		   				/* //경로 디테일 안내 정보
		   				alert(value.length);
		   				for(var i=0; i<value.length; i++){
		   					var str;

		   					 if(!value[i].properties.description.includes(","))
		   						
		   						str =  str + value[i].properties.description + "\n";
		   				}
		   				alert(str); */
		   			}
		   	});//each end
	    });//getJSON end
	    
	    //경로 상세 정보 추출
	    routeDetail(ybArray, length);
	    
		

		}//searchRoute end
		
		
		//경로 그리기 후 해당영역으로 줌
		function onDrawnFeatures(e){
		    map.zoomToExtent(this.getDataExtent());
		}
			
			
		/* 장민식 *//* Locale(지역)검색 function */
		$("#searchLocal").on("keypress", function() {
			$('#above_foot').css('display', 'none');
			if ( event.which == 13 ) {
				var local0 = $("#searchLocal").val();
				var local = encodeURI(local0);
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
		
		//장민식 블로그 정보를 얻어오기 위한 펑션
		function blogInfoStart(item) {
			var blogItemIngo = encodeURI(item);
			var blogInfo2;
			$.ajax({
				method: "post"
				,url: "map/blogInfo"
				,dataType: "json"
				,data:{"blogItem":blogItemIngo}
				,success: function(response) {
					
					blogInfo2 = JSON.stringify(response.blogInfoReturn2);
					$("#overayDivStart").append(blogInfo2.substring(1, blogInfo2.length-1));
				}
			});
		}
		function blogInfoEnd(item) {
			var blogItemIngo = encodeURI(item);
			var blogInfo2;
			$.ajax({
				method: "post"
				,url: "map/blogInfo"
				,dataType: "json"
				,data:{"blogItem":blogItemIngo}
				,success: function(response) {
					
					blogInfo2 = JSON.stringify(response.blogInfoReturn2);
					$("#overayDivEnd").append(blogInfo2.substring(1, blogInfo2.length-1));
				}
			});
		}
		
		function blogInfoA(item) {
			var blogItemIngo = encodeURI(item);
			var blogInfo2;
			$.ajax({
				method: "post"
				,url: "map/blogInfo"
				,dataType: "json"
				,data:{"blogItem":blogItemIngo}
				,success: function(response) {
					
					blogInfo2 = JSON.stringify(response.blogInfoReturn2);
					$("#overayDivA").append(blogInfo2.substring(1, blogInfo2.length-1));
				}
			});
		}
		
		function blogInfoB(item) {
			var blogItemIngo = encodeURI(item);
			var blogInfo2;
			$.ajax({
				method: "post"
				,url: "map/blogInfo"
				,dataType: "json"
				,data:{"blogItem":blogItemIngo}
				,success: function(response) {
					
					blogInfo2 = JSON.stringify(response.blogInfoReturn2);
					$("#overayDivB").append(blogInfo2.substring(1, blogInfo2.length-1));
				}
			});
		}
		
		function blogInfoC(item) {
			var blogItemIngo = encodeURI(item);
			var blogInfo2;
			$.ajax({
				method: "post"
				,url: "map/blogInfo"
				,dataType: "json"
				,data:{"blogItem":blogItemIngo}
				,success: function(response) {
					
					blogInfo2 = JSON.stringify(response.blogInfoReturn2);
					$("#overayDivC").append(blogInfo2.substring(1, blogInfo2.length-1));
				}
			});
		}
		
		//경유지 레이어 추가 - 김승훈
		function setLayers(length, ybArray){
			
			//출발지 마크 생성 및 팝업 생성
			var markerLayer = new Tmap.Layer.Markers();
			map.addLayer(markerLayer);
			 
			var lonlatS = new Tmap.LonLat(ybArray[0].lon, ybArray[0].lat);
			 
			var size = new Tmap.Size(24,38);
			var offset = new Tmap.Pixel((-size.w/2),(-size.h/2));
			var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_s.png', size, offset); 
			     
			var marker = new Tmap.Marker(lonlatS, icon);
			
			markerLayer.addMarker(marker);
			
			//popup 생성 S(출발점) Maker Click시 이벤트 발생시에 보이기 안보이기 반복 		
			var clickCheckS = 0;//Click 반복시 이벤트 분기를 위한 변수
			var popupS;
			marker.events.register("click", marker, onOverMarkerS);
			var item;
			function onOverMarkerS(evt){
				if(clickCheckS===0){
				item = ybArray3[0].item[0].title;
				blogInfoStart(item);						//블로그 정보를 가져오기 위한 키워드와 인덱스 호출
				popupS = new Tmap.Popup("p1",
										lonlatS,
				                        new Tmap.Size(690, 362),
				                        '<div class="col-xl-9 col-xl-pull-3" id="overayDivStart"></div>',
				                        true
										); 
				map.addPopup(popupS);
				popupS.show();
				clickCheckS=1;
				}else{
					popupS.show();
				}
				
			}//end function
			
			
			//
			//도착지 마크 생성 및 팝업 생성
			var markerLayer = new Tmap.Layer.Markers();
			map.addLayer(markerLayer);
			 
			var lonlatE = new Tmap.LonLat(ybArray[length-1].lon, ybArray[length-1].lat);
			 
			var size = new Tmap.Size(24,38);
			var offset = new Tmap.Pixel((-size.w/2), (-size.h/2));
			var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_f.png', size, offset); 
			     
			var marker = new Tmap.Marker(lonlatE, icon);
			
			markerLayer.addMarker(marker);
			
			//popup 생성 E(도착점) Maker Click시 이벤트 발생시에 보이기 안보이기 반복 		
			var clickCheckE = 0;//Click 반복시 이벤트 분기를 위한 변수
			var popupE;
			marker.events.register("click", marker, onOverMarkerE);
			function onOverMarkerE(evt){
				
				if(clickCheckE===0){
				item = ybArray3[itemCount-1].item[0].title;
				blogInfoEnd(item);
				popupE = new Tmap.Popup("p1",
										lonlatE,
				                        new Tmap.Size(720, 362),
				                        '<div class="col-xl-9 col-xl-pull-3" id="overayDivEnd"></div>',
				                        true
				                        ); 
				map.addPopup(popupE);
				popupE.show();
				clickCheckE=1;
				}else{
					popupE.show();
				}
				
			}//end function
			
			
			//alert(length);
			//경로지가 1, 2, 3개일 때
			if(length===3||length===4||length===5){
				//marker A 표시
				
				var markerLayer = new Tmap.Layer.Markers();
				map.addLayer(markerLayer);
				 
				var lonlatA = new Tmap.LonLat(ybArray[1].lon, ybArray[1].lat);
				 
				var size = new Tmap.Size(24,38);
				var offset = new Tmap.Pixel((-size.w/2), (-size.h/2));
				var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_2.png', size, offset); 
				     
				var marker = new Tmap.Marker(lonlatA, icon);
				
				markerLayer.addMarker(marker);
				
				//popup 생성 A Maker Click시 이벤트 발생시에 보이기 안보이기 반복 		
				var clickCheckA = 0;//Click 반복시 이벤트 분기를 위한 변수
				var popupA;
				marker.events.register("click", marker, onOverMarkerA);
				
				function onOverMarkerA(evt){
					
					if(clickCheckA===0){
					item = ybArray3[1].item[0].title;
					blogInfoA(item);					//블로그 정보를 가져오기 위한 키워드와 인덱스 호출
					popupA = new Tmap.Popup("p1",
											lonlatA,
					                        new Tmap.Size(720, 362),
					                        '<div class="col-xl-9 col-xl-pull-3" id="overayDivA"></div>',
					                        true
											); 
					map.addPopup(popupA);
					popupA.show();
					clickCheckA=1;
					}else{
						popupA.show();
					}
				}//end function
			}//end if
			//경로지가 2, 3개일 때
			if(length===4||length===5){
				//marker B 표시	
				var markerLayer = new Tmap.Layer.Markers();
				map.addLayer(markerLayer);
				 
				var lonlatB = new Tmap.LonLat(ybArray[2].lon, ybArray[2].lat);
				 
				var size = new Tmap.Size(24,38);
				var offset = new Tmap.Pixel((-size.w/2), (-size.h/2));
				var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_3.png', size, offset); 
				     
				var marker = new Tmap.Marker(lonlatB, icon);
				markerLayer.addMarker(marker);
				
				//popup 생성 B Maker Click시 이벤트 발생시에 보이기 안보이기 반복 		
				var clickCheckB = 0;//Click 반복시 이벤트 분기를 위한 변수
				var popupB;
				marker.events.register("click", marker, onOverMarkerB);
				
				function onOverMarkerB(evt){
					
					if(clickCheckB===0){
					item = ybArray3[2].item[0].title;
					blogInfoB(item);					//블로그 정보를 가져오기 위한 키워드와 인덱스 호출
					popupB = new Tmap.Popup("p1",
											lonlatB,
					                        new Tmap.Size(720, 362),
					                        '<div class="col-xl-9 col-xl-pull-3" id="overayDivB"></div>',
					                        true
					                        ); 
					map.addPopup(popupB);
					popupB.show();
					clickCheckB=1;
					}else{
						popupB.show();
					}
				}//end function
			}//end if
			
			//경로지가  3개일 때
			if(length===5){
				//marker C 표시	
				var markerLayer = new Tmap.Layer.Markers();
				map.addLayer(markerLayer);
				 
				var lonlatC = new Tmap.LonLat(ybArray[3].lon, ybArray[3].lat);
				 
				var size = new Tmap.Size(24,38);
				var offset = new Tmap.Pixel(-(size.w/2), -(size.h/2));
				var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_4.png', size, offset); 
				     
				var marker = new Tmap.Marker(lonlatC, icon);
				markerLayer.addMarker(marker);
				 
				//popup 생성 C Maker Click시 이벤트 발생시에 보이기 안보이기 반복 		
				var clickCheckC = 0;//Click 반복시 이벤트 분기를 위한 변수
				var popupC;
				marker.events.register("click", marker, onOverMarkerC);
				
				function onOverMarkerC(evt){
					
					if(clickCheckC===0){
					item = ybArray3[3].item[0].title;
					blogInfoC(item);					//블로그 정보를 가져오기 위한 키워드와 인덱스 호출
					popupC = new Tmap.Popup("p1",
											lonlatC,
					                        new Tmap.Size(720, 362),
					                        '<div class="col-xl-9 col-xl-pull-3" id="overayDivC"></div>',
					                        true
					                        ); 
					map.addPopup(popupC);
					popupC.show();
					clickCheckC=1;
					}else{
						popupC.show();
					}
				}//end function
			}//end if
		}
		
		//경로지 디테일 안내 메시지 저장 변수 - 김승훈
		var route_A;
		var route_B;
		var route_C;
		var route_D;
		
		//경로 안내 멘트 제이슨 값 받아서 변수에 저장 - 김승훈
		function routeDetail(ybArray, length){
			
			for(var i=1; i<length; i++){
			
			 var startX = ybArray[i-1].lon;
	         var startY = ybArray[i-1].lat;	
	         var endX = ybArray[i].lon;
	         var endY = ybArray[i].lat;
	        
	         var startName = "A";
	         var endName = "B";
	         var urlStr = "https://apis.skplanetx.com/tmap/routes/pedestrian?version=1&format=json";
	             urlStr += "&startX="+startX;
	             urlStr += "&startY="+startY;
	             urlStr += "&endX="+endX;
	             urlStr += "&endY="+endY;
	             urlStr += "&startName="+encodeURIComponent(startName);
	             urlStr += "&endName="+encodeURIComponent(endName);
	             urlStr += "&appKey=a35c8baf-b97e-3edc-8b03-5092e9e38b3f";
	             
	             routeDetailAjax(i, urlStr);
				
			}//end for	
		}//end function
		
		function routeDetailAjax(i, urlStr){
			
			//urlStr 출력 테스트
			//alert(urlStr);
			
			$.ajax({
				method: "post"
				, url: "map/pass_A"
				, dataType: "json"
				, data: {"urlStr":urlStr}
				, success: function(resp){
					//로드 디테일 출력 테스트
					//alert(resp.roadDetail);
					if(i===1){
						route_A = resp.roadDetail;
					} else if(i===2){
						route_B = resp.roadDetail;
					} else if(i===3){
						route_C = resp.roadDetail;
					} else if(i===4){
						route_D = resp.roadDetail;
					}//else if
				}//success
			});//end ajax
			
		}//end function
		
		
		/* 김승훈 경로 디테일 안내 정보 추출 */
		var showOrHide = true;
		//유병훈; 경로 버튼 누를 시, 각 경로 당 정보 띄우기
		//예; 경로1에서 경로2를 바로 클릭할 경우, div가 내려가버림.
		//		그래서 경로 버튼에서 서로를 클릭할 때는 div안에 내용만 바뀌게 함.
		//		완전히 끄려면 오른쪽 하단의 이미지를 클릭하여야 함.
		
		$('#foot').on('click', '#pass_'+1, function(){
			$('#above_foot').toggle(showOrHide);
			if(showOrHide==true){
				$('#above_foot').show();
				//alert(JSON.stringify(ybArray2[0].item[0].longitude)  + "     " +  JSON.stringify(ybArray2[0].item[0].latitude));
				spotNum = 0;
				loadRoadView(ybArray2[0].item[0].id, ybArray2[0].item[0].latitude, ybArray2[0].item[0].longitude);
				loadRoadDetail(0);
			} else {$('#above_foot').hide();}
		});
		$('#foot').on('click', '#pass_2', function(){
			$('#above_foot').toggle(showOrHide);
			if(showOrHide==true){
				$('#above_foot').show();
				spotNum = 1;
				loadRoadView(ybArray2[1].item[0].id, ybArray2[1].item[0].latitude, ybArray2[1].item[0].longitude);
				loadRoadDetail(1);
				} else {$('#above_foot').hide();}
		});
		$('#foot').on('click', '#pass_3', function(){
			$('#above_foot').toggle(showOrHide);
			if(showOrHide==true){
				$('#above_foot').show();
				spotNum = 2;
				loadRoadView(ybArray2[2].item[0].id, ybArray2[2].item[0].latitude, ybArray2[2].item[0].longitude);
				loadRoadDetail(2);
			} else {$('#above_foot').hide();}
		});
		$('#foot').on('click', '#pass_4', function(){
			$('#above_foot').toggle(showOrHide);
			if(showOrHide==true){
				$('#above_foot').show();
				spotNum = 3;
				loadRoadView(ybArray2[3].item[0].id, ybArray2[3].item[0].latitude, ybArray2[3].item[0].longitude);
				loadRoadDetail(3);
			} else {$('#above_foot').hide();}
		});
		$('#foot').on('click', '#pass_5', function(){
			$('#above_foot').toggle(showOrHide);
			if(showOrHide==true){
				$('#above_foot').show();
				spotNum = 4;
				loadRoadView(ybArray2[4].item[0].id, ybArray2[4].item[0].latitude, ybArray2[4].item[0].longitude);
				loadRoadDetail(4);
			} else {$('#above_foot').hide();}
		});
		
		//20161024 김승훈
		$('testRight').on('click', function(){
			
			map.destroy();
			initTmap();
			
			
		});
		
		$('testLeft').on('click', function(){
			
			map.destroy();
			initTmap();
			
		});
		
	  	/* //유병훈 above_foot div태그 열었다 닫았다 하는 부분 & 클릭 부분 이미지 & 이미지 변경 처리
		var za = 1;
		$('#slide_extend').on('click', function(){
			if(za===1){
				$('#slide_extend').removeClass('glyphicon glyphicon-resize-full');
				$('#slide_extend').addClass('glyphicon glyphicon-resize-small');
				za = 2;
			}else if(za===2){
				$('#slide_extend').removeClass('glyphicon glyphicon-resize-small');
				$('#slide_extend').addClass('glyphicon glyphicon-resize-full');
				za = 1;
			}
			$('#above_foot').toggle();
		});//slide */
		
		
		/* 장민식 *//* 아이템 검색 필드 (추가) */
		var count = 0; /* 아이템 필드 최대 5개 추가를 위한 count 변수 */
		$('#addItemField').click(function() {
			if (count < 3) {
				
				$('.sidebar-labels>.endItemField').before(
					"<li id='addedItemField'>"
					+ "<a>"
					+ "<i class='fa fa-circle text-gray mr-xs' ></i>&nbsp;"
	            	+ "<span class='label-name'><input type='text' class='itemField fade in'></span>"
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
    
    //맵 초기화 테스트 BOMB button - 김승훈
    $('#testbutton').on('click', function(){	
 		map.destroy();
 		initTmap();
 	});
    
  //1024추가 김승훈
 	//선택된 마커
 	var markerSelectA = true;
 	var markerSelectB = false;
 	var markerSelectC = false;
 	var markerSelectD = false;
 	var markerSelectE = false;
 	
 	var a=0;
 	var b=0;
 	var c=0;
 	var d=0;
 	var e=0;
 	//a,b,c,d,e는 아이템 인덱스를 나타내는 변수이다.
 	//a,b,c,d,e는 전역변수로 선언되어야하며 search버튼 누를시에는 0으로 초기화 해야 한다. 
 	//왼쪽을 눌렀을때의 이벤트 함수
 	$('#left').on('click', function(){
 		
 		alert('left');
 		
 		if(markerSelectA == true){
 			if(a==0){
 				a=2;
 			}else if(a==1){
 				a=0;
 			}else if(a==2){
 				a=1;
 			}
 		}else if(markerSelectB == true){
 			if(b==0){
 				b=2;
 			}else if(b==1){
 				b=0;
 			}else if(b==2){
 				b=1;
 			}
 		}else if(markerSelectC == true){
 			if(c==0){
 				c=2;
 			}else if(c==1){
 				c=0;
 			}else if(c==2){
 				c=1;
 			}
 		}else if(markerSelectD == true){
 			if(d==0){
 				d=2;
 			}else if(d==1){
 				d=0;
 			}else if(d==2){
 				d=1;
 			}
 		}else if(markerSelectE == true){
 			if(e==0){
 				e=2;
 			}else if(e==1){
 				e=0;
 			}else if(e==2){
 				e=1;
 			}
 		}
 		
 		
 		var item = [];
		$(".itemField").each(function(idx){
	        var item0 = $(".itemField:eq(" + idx + ")").val();
			item.push(encodeURI(item0));
			
	     });//each
	     
	     alert(a);
	     alert(b);
	      
        $.ajax({
        	method: "post"
        	, url: "map/sendItem"
        	, dataType: "json"
        	, data: {"itemList":item}
        	, success: function(response) {
				var recommendedItem = response.recommendedItem;
				$(recommendedItem).each(function(index, value) {
					var jsonValue = JSON.parse(value);
					//alert(JSON.stringify(jsonValue));
					//alert(jsonValue.item[index].title);
					ybArray2.push(jsonValue);//사용자가 입력한 키워드들이 담김
				});
			    yb_test(ybArray2, a, b, c, d, e);//크롤링 해서 추천하는 장소 위도, 경도 담는 function으로 이동
			}
        });//ajax
 	});
 	//오른쪽을 눌렀을때의 이벤트 함수
	$('#right').on('click', function(){
		
		alert('right');
		
		if(markerSelectA == true){
 			if(a==0){
 				a=1;
 			}else if(a==1){
 				a=2;
 			}else if(a==2){
 				a=0;
 			}
 		}else if(markerSelectB == true){
 			if(b==0){
 				b=1;
 			}else if(b==1){
 				b=2;
 			}else if(b==2){
 				b=0;
 			}
 		}else if(markerSelectC == true){
 			if(c==0){
 				c=1;
 			}else if(c==1){
 				c=2;
 			}else if(c==2){
 				c=0;
 			}
 		}else if(markerSelectD == true){
 			if(d==0){
 				d=1;
 			}else if(d==1){
 				d=2;
 			}else if(d==2){
 				d=0;
 			}
 		}else if(markerSelectE == true){
 			if(e==0){
 				e=1;
 			}else if(e==1){
 				e=2;
 			}else if(e==2){
 				e=0;
 			}
 		}
		
		var item = [];
		$(".itemField").each(function(idx){
	        var item0 = $(".itemField:eq(" + idx + ")").val();
			item.push(encodeURI(item0));
			
	     });//each
	     
	     alert(a);
	     alert(b);
	      
        $.ajax({
        	method: "post"
        	, url: "map/sendItem"
        	, dataType: "json"
        	, data: {"itemList":item}
        	, success: function(response) {
				var recommendedItem = response.recommendedItem;
				$(recommendedItem).each(function(index, value) {
					var jsonValue = JSON.parse(value);
					//alert(JSON.stringify(jsonValue));
					//alert(jsonValue.item[index].title);
					ybArray2.push(jsonValue);//사용자가 입력한 키워드들이 담김
				});
			    yb_test(ybArray2, a, b, c, d, e);//크롤링 해서 추천하는 장소 위도, 경도 담는 function으로 이동
			}
        });//ajax
 	});
	//1024추가 김승훈 end
	
	/* 장민식 */ /* 로드뷰 추가 펑션 */
	function loadRoadView(id, x, y) {
		var roadviewContainer = document.getElementById('SpotInfo01'); //로드뷰를 표시할 div
		var roadview = new daum.maps.Roadview(roadviewContainer); //로드뷰 객체
		var roadviewClient = new daum.maps.RoadviewClient(); //좌표로부터 로드뷰 파노ID를 가져올 로드뷰 helper객체

		var position = new daum.maps.LatLng(x, y);
		var panoId = id;

		// 특정 위치의 좌표와 가까운 로드뷰의 panoId를 추출하여 로드뷰를 띄운다.
		roadviewClient.getNearestPanoId(position, 50, function(panoId) {
		    roadview.setPanoId(panoId, position); //panoId와 중심좌표를 통해 로드뷰 실행
		});
	}
	
	/* 장민식 */ /* 점포 정보 호출 펑션 */
	function loadRoadDetail(num) {
		$('#detailFieldTitle').text(ybArray2[num].item[itemRecommendCount].title);
		$('#detailFieldCategory').text(ybArray2[num].item[itemRecommendCount].category);
		$('#detailFieldAddress').text(ybArray2[num].item[itemRecommendCount].address);
		var imageUrl = ybArray2[num].item[itemRecommendCount].imageUrl;
		if (imageUrl !== "") {
			$('#detailFieldImage').attr('src', ybArray2[num].item[itemRecommendCount].imageUrl);
		} else {
			$('#detailFieldImage').attr('src', 'image/noImageLg.jpg');
		}
		$('#detailFieldPhone').text(ybArray2[num].item[itemRecommendCount].phone);
		$('#detailFieldMoreInfo').attr('href', ybArray2[num].item[itemRecommendCount].placeUrl);
	}
	
	//다른 추천 버튼
	$('#recommendBtnLeft').click(function() {
		if (itemRecommendCount === 0) {
			itemRecommendCount = 3;
		}
		--itemRecommendCount;	//카운트 차감
		//점포 세부정보 다시 호출
		loadRoadDetail(spotNum);
		//로드뷰 정보 다시호출
		loadRoadView(ybArray2[spotNum].item[itemRecommendCount].id
				, ybArray2[spotNum].item[itemRecommendCount].latitude
				, ybArray2[spotNum].item[itemRecommendCount].longitude);
	});
	
	$('#recommendBtnRight').click(function() {
		if (itemRecommendCount === 2) {
			itemRecommendCount = -1;
		}
		++itemRecommendCount;	//카운트 증감
		//점포 세부정보 다시 호출
		loadRoadDetail(spotNum);
		//로드뷰 정보 다시호출
		loadRoadView(ybArray2[spotNum].item[itemRecommendCount].id
				, ybArray2[spotNum].item[itemRecommendCount].latitude
				, ybArray2[spotNum].item[itemRecommendCount].longitude);
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
            <a href="page_make_gallery">sing</a>
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
        <h5 class="sidebar-nav-title">Hello <strong><s:property value="#session.loginName" /></strong> <a class="action-link" href="#"><i class="fa fa-map-marker"></i></a></h5>
        <ul class="sidebar-nav">
        
             <li class="active">
				<a href="index" data-no-pjax>
                    <span class="icon"><i class="glyphicon glyphicon-map-marker"></i></span>
                    Maps
                </a>
             </li>
             <li>
                <a href="page_moveTo_gallery" data-no-pjax>
                    <span class="icon"><i class="glyphicon glyphicon-inbox"></i></span>
                    My Card
                </a>
            </li>
            
            
<%--             <li>
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
            </li> --%>
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
                <li class="ml-sm mr-n-xs hidden-xs"><a href="index"><i class="fa fa-refresh fa-lg"></i></a></li>
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
                        
                        	<!--  김승훈테스트버튼 
                        	<input type="button" id="left" value="left" >
                        	<input type="button" id="right" value="right"> -->
                        
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
                    
                    <ul class="dropdown-menu" >
 						
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
    <main id="contents" class="contents" role="main">
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
    
<!--     <div id="foot">
    	<input type="button" value="화살표" id="slide"/>
    </div> -->
     <!-- 김승훈_edit -->
	<div id="foot" style="display: none">
		<!-- 장민식 --><!-- 경로 아이콘 --> 
		<span id="pass_1" style="display: none">
			<i class="glyphicon glyphicon-map-marker"></i>
		</span>
		<span id="pass_2" style="display: none">
			<i class="glyphicon glyphicon-map-marker"></i>
		</span>
		<span id="pass_3" style="display: none">
			<i class="glyphicon glyphicon-map-marker"></i>
		</span>
		<span id="pass_4" style="display: none">
			<i class="glyphicon glyphicon-map-marker"></i>
		</span>
		<span id="pass_5" style="display: none">
			<i class="glyphicon glyphicon-map-marker"></i>
		</span>
		
		<%-- <span id="footExpend">
			<i class="fa fa-reorder fa-lg"></i>
		</span> --%>
		
		<!-- 토탈 시간, 토탈거리 -->
		<p class='no-margin' id="totalTimeField">
			<small><span class='fw-semi-bold'>Total Time : </span>
			<span class='text-semi-muted' id="totalTime"></span></small>
		</p>
		<p class='no-margin'>
			<small><span class='fw-semi-bold'>Total Distance : </span>
			<span class='text-semi-muted' id="totalDistance"></span></small>
		</p>
    </div>
    <!-- 김승훈 edit end -->
    
    <!-- 유병훈  세부경로가 입력되는 div태그	-->
    <div id="above_foot" style="display: none">
    	<!-- 장민식 --> <!-- 로드뷰와 점포 정보를 나타내는 구역 -->
		<section class="widget" id="default-widget">
			<header>
			    <span class="fw-semi-bold" id="blogSearchTitle"> &nbsp;&nbsp;Check Your RoadView</span>
			    <div class="widget-controls">
			        <a data-widgster="remove" title="remove" onclick="closeAboveFoot();"><i class="glyphicon glyphicon-remove"></i></a>
			    </div>
			</header>
					<div class="widget-body" id="contentsField">
						<span id="SpotInfo01"></span>	<!-- 로드뷰 span -->
						<span id="SpotInfo02">			<!-- 점포 정보 span -->
						    <section class="search-result-item">
			                    <a class="image-link" href="#">
			                        <img class="image" id="detailFieldImage" src="image/noImageLg.jpg" height="150px" width="200px">
			                    </a>
			                    <div class="search-result-item-body">
			                        <div class="row">
			                            <div class="col-sm-9">
			                                <h4 class="search-result-item-heading" id="detailFieldTitle"></h4>
			                                <small><p class="fw-semi-bold" id="detailFieldCategory"></p></small>
			                                <br>
			                                <small><span class='fw-semi-bold' style="color:#e27045;">Address &nbsp;</span>
			                                <span class='fw-semi-bold' id="detailFieldAddress"></span></small><br>
			                                <small><span class='fw-semi-bold' style="color:#e27045;">Tel &nbsp;</span>
			                                <span class='fw-semi-bold' id="detailFieldPhone"></span></small>
			                                
			                            </div>
			                            <div class="col-lg-4"  id="detailFieldBtnSet">
			                                <p class="value3 mt-sm"> </p><p class="value3 mt-sm"> </p>
				                            <button class="btn btn-inverse width-50 btn-sm" role="button" id="recommendBtnLeft">
				                            <i class="fa fa-arrow-left text-warning"></i></button>
				                            
				                            <button class="btn btn-inverse width-50 btn-sm" role="button" id="recommendBtnRight">
				                            <i class="fa fa-arrow-right text-warning"></i></button>
				                            
			                                <p class="value3 mt-sm"> </p>
			                                <a class="btn btn-primary btn-info btn-sm" id="detailFieldMoreInfo" href="" target='_blank' >&nbsp; Get More Info&nbsp;</a>
			                            </div>
			                        </div>
			                    </div>
								<p>
									<button type="button" id="makeCardBtn" class="btn btn-warning btn-block">Make Your Cards &nbsp;&nbsp;&nbsp;<i class="glyphicon glyphicon-inbox"></i></button>
								</p>
			                </section>
						</span>
					</div>
		</section>
    </div>
    <!-- 유병훈 end -->
    
	<!-- 장민식  above_foot open_close -->
    <script type="text/javascript">
		function closeAboveFoot() {
			$("#above_foot").css('display', 'none');
		}
    </script>
    
    
</div>

<!-- loginform jhs -->
<div id="overlay_t"></div> 
	<div id="popup_layer">
                <section class="widget widget-login animated fadeInUp test">
                    <header>
                        <h3>Login to your Sing App</h3>
                    </header>
                    <div class="widget-body">
                        <form class="login-form mt-lg" id="loginform" action="login" method="post">
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

<!-- 유병훈, 인터셉터 했을 때 StackValue에 int(key값) 넣어서 걸렸을 때 로그인창 출력  -->
<s:if test="loginFail==1">
	<script>
		$('#popup_layer, #overlay_t').show(); 
	</script>
	
</s:if>

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