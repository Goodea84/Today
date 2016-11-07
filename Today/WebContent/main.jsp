<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<link rel="shortcut icon" href="img/favi.ico">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
		<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
		<title>MINNANO MARKERS</title>
		<style>
		body,h1,h2,h3,h4,h5,h6 {font-family: "Lato", sans-serif;}
		body, html {
		    height: 100%;
		    color: #777;
		    line-height: 1.8;
		}
		
		/* Create a Parallax Effect */
		.bgimg-1, .bgimg-2, .bgimg-3, .bgimg-4{
		    opacity: 0.7;
		    background-attachment: fixed;
		    background-position: center;
		    background-repeat: no-repeat;
		    background-size: cover;
		}
		
		/* First image (Logo. Full height) */
		.bgimg-1 {
		    background-image: url("http://hdwallpaperbackgrounds.net/wp-content/uploads/2015/08/Rain-Drops-on-Glass-Wallpapers.jpg");
		    min-height: 100%;
		}
		
		/* Second image (how to use) */
		.bgimg-2 {
		    background-image: url("img/bg/index_BG_02.jpg");
		    min-height: 400px;
		}
		
		/* Third image (Developers) */
		.bgimg-3 {
		    background-image: url("img/bg/index_BG_03.jpg");
		    min-height: 400px;
		}
		
		/* fourth image (Contact) */
		.bgimg-4 {
		    background-image: url("http://cdn.pcwallart.com/images/universe-stars-hd-wallpaper-1.jpg");
		    min-height: 400px;
		}
		
		.w3-wide {letter-spacing: 10px;}
		.w3-hover-opacity {cursor: pointer;}
		
		#googleMap {
		    width: 100%;
		    height: 400px;
		    -webkit-filter: grayscale(90%);
		    filter: grayscale(90%);
		}
		
		/* Turn off parallax scrolling for tablets and mobiles */
		@media only screen and (max-width: 1024px) {
		    .bgimg-1, .bgimg-2, .bgimg-3, .bgimg-4 {
		        background-attachment: scroll;
		    }
		}
		</style>
	</head>
		<body>
		
		<!-- Navbar (sit on top) -->
		<div class="w3-top">
		  <ul class="w3-navbar" id="myNavbar">
		    <li><a href="#" class="w3-padding-large">HOME</a></li>
		    <li class="w3-hide-small w3-right">
		      <a href="index" class="w3-padding-large w3-hover-orange">ENTER ON A MINNANO MARKERS &nbsp;<i class="fa fa-map-marker"></i></a>
		    </li>
		  </ul>
		</div>
		
		<!-- First Parallax Image with Logo Text -->
		<div class="bgimg-1 w3-opacity w3-display-container">
		  <div class="w3-display-middle" style="white-space:nowrap;">
		    <!-- <span class="w3-center w3-padding-xlarge w3-black w3-xlarge w3-wide w3-animate-opacity">Hello 
		    <span class="w3-hide-small">Everyone</span> It's MINNANO MAKERS</span> -->
		    <a href="index" class="w3-padding-large"><img src="img/main_logo.png" class="w3-hover-opacity"></a>
		  </div>
		</div>
		
		<!-- Container (About Section) -->
		<div class="w3-content w3-container w3-padding-64" id="about">
		  <h3 class="w3-center">ABOUT MINNANO MARKERS</h3>
		  <p class="w3-center"><em>MINNANO MARKERS is spreading all over the world.</em></p>
		  <div class="w3-row">
		    <div class="w3-col m6 w3-center w3-section">
		      <img src="img/pr_logo01.jpg" alt="MINNANO MARKERS">
		    </div>
		
		    <!-- Hide this text on small devices -->
		    <div class="w3-col m6 w3-hide-small w3-section">
		      <p><b>MINNANO MARKERS : Stimulating your sensibility</b><br>
		      ‘What are we going to do today? What about tomorrow?’<br>
		       MINNANO MARKERS answers those questions with sensibility.<br/>
		       We wouldn't use the word, sensibility, if MINNANO MARKERS simply <br/>
		       provides optimal route information. Not only do we give the answer <br/>
		       to the question like ‘What are we going to do today?’, <br/>
		       but also we provide you with the memory and sensibility like <br/>
		       ‘Remember what we have done on that day?’ This is how we show <br/>
		       the sensibility that we could have from anywhere anytime.<br/>
		       Well then, let’s give it a try and make a memory <br/>
		       with MINNANO MARKERS, shall we?
		
		    </div>
		  </div>
		</div>
		
		
		
		
		
		<!-- HOW TO USE -->
		<div class="bgimg-2 w3-display-container">
		  <div class="w3-display-middle">
		    <span class="w3-center w3-padding-xlarge w3-black w3-xlarge w3-wide w3-animate-opacity">HOW TO USE</span>
		  </div>
		</div>
		
		<div class="w3-content w3-container w3-padding-64">
		  <h3 class="w3-center">HOW TO USE</h3>
		  <p class="w3-center"><em>By using MINNANO MARKERS, you can simply get the information you are looking for!</em></p><br>
		
			<div class="w3-row-padding w3-center">
				<div class="w3-col m3">
					<img src="img/howToUse/how_img01.jpg" style="width:100%" class="w3-margin w3-circle">
				</div>
				
				<div class="w3-col m3">
					<img src="img/howToUse/how_img02.jpg" style="width:100%" class="w3-margin w3-circle">
				</div>
				
				<div class="w3-col m3">
					<img src="img/howToUse/how_img03.jpg" style="width:100%" class="w3-margin w3-circle">
				</div>
				
				<div class="w3-col m3">
					<img src="img/howToUse/how_img04.jpg" style="width:100%" class="w3-margin w3-circle">
				</div>
			</div>
			<div class="w3-row-padding w3-center">
			    <div class="w3-col m3">
					<b>STEP01</b><small><br>Enter the specific name of local area.<br></small>
			    </div>
			
			    <div class="w3-col m3">
					<b>STEP02</b><small><br>Input keywords you would like to try.<br>You can select from 2 to 5 options. <br></small>
			    </div>
			
			    <div class="w3-col m3">
					<b>STEP03</b><small><br>Check the routes appearing on the map.<br></small>
			    </div>
			
			    <div class="w3-col m3">
					<b>STEP04</b><small><br>Click the marker on the map <br>and you can check and read the reviews from blogs of the destinations.</small>
			    </div>
		    </div>
		    <div class="w3-row-padding w3-center">
				<div class="w3-col m3">
					<img src="img/howToUse/how_img05.jpg" style="width:100%" class="w3-margin w3-circle">
				</div>
				
				<div class="w3-col m3">
					<img src="img/howToUse/how_img06.jpg" style="width:100%" class="w3-margin w3-circle">
				</div>
				
				<div class="w3-col m3">
					<img src="img/howToUse/how_img03.jpg" style="width:100%" class="w3-margin w3-circle">
				</div>
				
				<div class="w3-col m3">
					<img src="img/howToUse/how_img04.jpg" style="width:100%" class="w3-margin w3-circle">
				</div>
			</div>
			<div class="w3-row-padding w3-center">
			    <div class="w3-col m3">
					<b>STEP05</b><small><br>Click markers at the bottom of the map <br>and you can check the details and roadview of the destinations.</small><br> <br>
			    </div>
			
			    <div class="w3-col m3">
					<b>STEP06</b><small><br>Do not like the place we recommended? <br>Well, sorry about that :( <br>why don’t you give us another chance? <br>Click the left/right button at the bottom. <br>We also provide you with other famous places at each marker!</small><br> <br>
			    </div>
			
			    <div class="w3-col m3">
					<b>STEP07</b><small><br>Like the routes? Cool! <br> Then, let’s make a card and share with your friends. <br>Apart from our webpage, it’s possible to share via KakaoTalk and Facebook!</small><br> <br>
			    </div>
			
			    <div class="w3-col m3">
					<b>STEP08</b><small><br>How was that you tried? <br>Did it live up to your expectations?<br>Let’s share some pictures and comments using the card you have created.<br>It becomes the part of precious memories with people you were with!</small><br> <br>
			    </div>
		    </div>
			<div class="w3-row-padding w3-center">
				<a href="index" class="w3-padding-large">
					<button class="w3-btn w3-orange w3-padding-xlarge" style="margin-top:64px">ENTER ON A MINNANO MARKERS</button>
				</a>
			</div>
		</div>
		
		<div class="bgimg-3 w3-display-container">
		  <div class="w3-display-middle">
		    <span class="w3-center w3-padding-xlarge w3-black w3-xlarge w3-wide w3-animate-opacity">DEVELOPERS</span>
		  </div>
		</div>
		
		
		<!-- Container (Portfolio Section) -->
		<div class="w3-content w3-container w3-padding-64">
		  <h3 class="w3-center">DEVELOPERS</h3>
		  <p class="w3-center"><em>We are making innovation<br> Click the images to make them bigger</em></p><br>
		
		  <!-- Responsive Grid. Four columns on tablets, laptops and desktops. Will stack on mobile devices/small screens (100% width) -->
		  <div class="w3-row-padding w3-center">
		    <div class="w3-col m3">
		      <img src="img/team_01.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity">
		    </div>
		
		    <div class="w3-col m3">
		      <img src="img/team_02.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity">
		    </div>
		
		    <div class="w3-col m3">
		      <img src="img/team_03.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity">
		    </div>
		
		    <div class="w3-col m3">
		      <img src="img/team_04.png" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity">
		    </div>
		  </div>
			<div class="w3-row-padding w3-center">
			    <div class="w3-col m3">
					<b>CEO</b><br>Jang Jackman
			    </div>
			
			    <div class="w3-col m3">
					<b>CTO at Beomgye Lab</b><br>Kim Takuya
			    </div>
			
			    <div class="w3-col m3">
					<b>Branch Manager at Silicon Valley</b><br>Yu Pitt
			    </div>
			
			    <div class="w3-col m3">
					<b>Chief Researcher</b><br>Jeon Suji
			    </div>
			    <a href="index" class="w3-padding-large">
					<button class="w3-btn w3-orange w3-padding-xlarge" style="margin-top:64px">ENTER ON A MINNANO MARKERS</button>
				</a>
		    </div>
		</div>

		
		<!-- Modal for full size images on click-->
		<div id="modal01" class="w3-modal w3-black" onclick="this.style.display='none'">
		  <span class="w3-closebtn w3-hover-red w3-text-white w3-xxxlarge w3-container w3-display-topright">×</span>
		  <div class="w3-modal-content w3-animate-zoom w3-center w3-transparent w3-padding-64">
		    <img id="img01" style="max-width:100%">
		  </div>
		</div>
		
		<!-- Third Parallax Image with Portfolio Text -->
		<div class="bgimg-4 w3-display-container">
		  <div class="w3-display-middle">
		     <span class="w3-center w3-padding-xlarge w3-black w3-xlarge w3-wide w3-animate-opacity">CONTACT US</span>
		  </div>
		</div>
		
		<!-- Container (Contact Section) -->
		<div class="w3-content w3-container w3-padding-64">
		  <h3 class="w3-center">WHERE WE WORK</h3>
		  <p class="w3-center"><em>We'd love to hear your feedback!</em></p>
		
		  <div class="w3-row w3-padding-32 w3-section">
		    <div class="w3-col m4 w3-container">
		      <!-- Add Google Maps -->
		      <div id="googleMap" class="w3-round-large"></div>
		    </div>
		    <div class="w3-col m8 w3-container w3-section">
		      <div class="w3-large w3-margin-bottom">
		        <i class="fa fa-map-marker w3-hover-text-black" style="width:30px"></i>SC IT Master in Coex, Republic of Korea<br>
		        <i class="fa fa-phone w3-hover-text-black" style="width:30px"></i> Phone: +82 10 43998611 <br>
		        <i class="fa fa-envelope w3-hover-text-black" style="width:30px"> </i> Email: msik0604@gmail.com<br>
		      </div>
		      <p>Swing by for a cup of coffee, or leave me a note:</p>
		      <div class="w3-row-padding" style="margin:0 -16px 8px -16px">
		        <div class="w3-half">
		          <input class="w3-input w3-border w3-hover-light-grey" type="text" placeholder="Name">
		        </div>
		        <div class="w3-half">
		          <input class="w3-input w3-border w3-hover-light-grey" type="text" placeholder="Email">
		        </div>
		      </div>
		      <input class="w3-input w3-border w3-hover-light-grey" type="text" placeholder="Comment">
		      <button class="w3-btn w3-section w3-right">SEND</button>
		    </div>
		  </div>
		</div>
		
		<!-- Footer -->
		<footer class="w3-center w3-dark-grey w3-padding-48 w3-hover-orange">
		  <p>Copyright <a href="#" target="_blank" class="w3-hover-opacity">@MINNANO MAKERS</a> &nbsp;&nbsp;All Rights Reserved.</p>
		</footer>
		 
		<!-- Add Google Maps -->
		<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBY8MyzhHqvlB-d6jcaFS6bqn0NzSKK74g"></script>
		<script>
		var myCenter = new google.maps.LatLng(37.512269, 127.059898);
		
		function initialize() {
		var mapProp = {
		  center:myCenter,
		  zoom:15,
		  scrollwheel:true,
		  draggable:true,
		  mapTypeId:google.maps.MapTypeId.ROADMAP
		  };
		
		var map = new google.maps.Map(document.getElementById("googleMap"),mapProp);
		
		var marker = new google.maps.Marker({
		  position:myCenter,
		  });
		
		marker.setMap(map);
		}
		
		google.maps.event.addDomListener(window, 'load', initialize);
		
		
		// Modal Image Gallery
		function onClick(element) {
		  document.getElementById("img01").src = element.src;
		  document.getElementById("modal01").style.display = "block";
		}
		
		// Change style of navbar on scroll
		window.onscroll = function() {myFunction()};
		function myFunction() {
		    var navbar = document.getElementById("myNavbar");
		    if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
		        navbar.className = "w3-navbar" + " w3-card-2" + " w3-animate-top" + " w3-white";
		    } else {
		        navbar.className = navbar.className.replace(" w3-card-2 w3-animate-top w3-white", "");
		    }
		}
		</script>
	
	</body>
</html>

