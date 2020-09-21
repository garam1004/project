<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>

<html>
	<head>
		<title>Dental Clinic</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="assets/css/main.css" />
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
		<script src='https://kit.fontawesome.com/a076d05399.js'></script>
		
	</head>
	<header class="homepage">
		<div id="page-wrapper">

			<!-- Header -->
			
				<div id="header">
					<div class="container">

						<!-- Logo -->
							<div id="logo">
								<img onclick="location.href='index.jsp'"
											 src="assets/css/images/teeth.png" width="70px" height="75px">
								<h1><a href="index.jsp">Dental Clinic</a></h1>
							</div>

						<!-- Nav -->
							<nav id="nav">
								<ul>
									<li class="active"><a href="index.jsp">Home</a></li>
									<li><a href="about/about.jsp">About</a></li>
									<li><a href="center/notice.jsp">Notice</a></li>
									<li><a href="reservation/reservation.jsp">Reservation</a></li>
									<li><a href="contact/contact.jsp">Contact</a></li>
									
<%
	String id = (String)session.getAttribute("id");
	if(id==null){
%>
	<li><a href="member/login.jsp">Login</a></li>
	<li><a href="member/join.jsp">Join</a></li>
<%
	}else{
%>

	<li>
		<a href="member/logout.jsp">Logout</a>
	</li>
	<li>
		<a href="member/mUpdate.jsp">정보수정</a> 
	</li>
	
<%
	}
%>

								</ul>
							</nav>

					</div>
				</div>

	</header>
	<body>
			<!-- Banner -->
				<div id="banner">
					<div class="container">						
						<div class="row">
							<div class="9u 12u(mobile)">
								<section>
									<a class="image full"><img src="images/main.png" alt="" /></a>
								</section>
							</div>
							<div class="3u 12u(mobile)">
								<section>
									<div class="bannerbox">
										<h2>Dental Clinic</h2>
										<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur sit amet egestas eros. Sed venenatis est nunc, id convallis tellus venenatis non. Proin id nisi euismod, molestie nisl vel, accumsan sem. Integer felis sem.</p>
									</div>
								</section>
							</div>							
						</div>
					</div>
				</div>

			<!-- Featured -->
				<div id="featured">
					<section class="container">
						<header>
							<h2>Dental Clinic</h2>
							<span class="byline">Your Business strapline goes here</span>
						</header>
					</section>
				</div>
				
			<!-- Main -->
				<div id="main">
					<section class="container">
						<div class="row">
							<section class="3u 12u(mobile)">
								<div class="box">
									<h3><a href="about/about.jsp"><i class='fas fa-clinic-medical' style='font-size:36px; color: white;'></i><br>About</a></h3>
								</div>
							</section>
							<section class="3u 12u(mobile)">
								<div class="box"><a href="center/notice.jsp">
									<h3><i class='fas fa-bullhorn' style='font-size:36px; color: white;'></i><br>Notice</a></h3>
								</div>
							</section>
							<section class="3u 12u(mobile)">
								<div class="box">
									<h3><a href="reservation/reservation.jsp"><i class='far fa-calendar-alt' style='font-size:36px; color: white;'></i><br>Reservation</a></h3>
								</div>
							</section>
							<section class="3u 12u(mobile)">
								<div class="box">
									<h3><a href="contact/contact.jsp"><i class='far fa-envelope' style='font-size:36px; color: white;'></i><br>Contact</a></h3>
								</div>
							</section>							
						</div>					
						<h2>Welcome To Our New Website</h2>
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur sit amet egestas eros. Sed venenatis est nunc, id convallis tellus venenatis non. Proin id nisi euismod, molestie nisl vel, accumsan sem. Integer felis sem, lacinia eu auctor eget, dapibus feugiat elit. Duis lectus justo, ultrices ac placerat non, sollicitudin at massa. Integer pulvinar ipsum a posuere consectetur. Aenean placerat, quam sed varius congue, felis lectus ullamcorper massa, nec posuere ante massa finibus tortor. Nulla facilisi. Maecenas porttitor felis et tempor vulputate. Fusce ligula ante, venenatis hendrerit semper at, posuere vel velit. Pellentesque commodo nulla vel nisi fringilla, id malesuada sapien dictum. Morbi eget lobortis nulla. Suspendisse id aliquet felis.</p>
					</section>
				</div>

			<!-- Footer -->
				<div id="footer">
					<div class="container">

						<!-- Social -->
							<section>
								<ul class="icons">
									<li><a href="#" class="icon fa-twitter"><span>Twitter</span></a></li>
									<li><a href="#" class="icon fa-facebook"><span>Facebook</span></a></li>
									<li><a href="#" class="icon fa-google-plus"><span>Google+</span></a></li>
									<li><a href="#" class="icon fa-linkedin"><span>Linkedin</span></a></li>
									<li><a href="#" class="icon fa-pinterest"><span>Pinterest</span></a></li>
								</ul>
							</section>

						<!-- Copyright -->
							<div class="copyright">
								&copy; dental clinic | <a href=index.jsp>Home</a>								
							</div>
				</div>
		</div>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.dropotron.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="assets/js/main.js"></script>

	</body>
</html>