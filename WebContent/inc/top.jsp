<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>	
    <head>
		<title>CSS3 Basket | CSS3 Templates</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="../assets/css/main.css" />
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
	</head>
	<header class="homepage">
		<div id="page-wrapper">

			<!-- Header -->
			
				<div id="header">
					<div class="container">

						<!-- Logo -->
							<div id="logo">
								<img onclick="location.href='../index.jsp'"
											 src="../assets/css/images/teeth.png" width="70px" height="75px">
								<h1><a href="../index.jsp">Dental Clinic</a></h1>
							</div>

						<!-- Nav -->
							<nav id="nav">
								<ul>
									<li class="active"><a href="../index.jsp">Home</a></li>
									<li class="active2"><a href="../about/about.jsp">About</a></li>
									<li class="active3"><a href="../center/notice.jsp">Notice</a></li>
									<li class="active4"><a href="../reservation/reservation.jsp">Reservation</a></li>
									<li class="active5"><a href="../contact/contact.jsp">Contact</a></li>
<%
	String id = (String)session.getAttribute("id");
	if(id==null){
%>
	<li class="active6"><a href="../member/login.jsp">Login</a></li>
	<li class="active7"><a href="../member/join.jsp">Join</a></li>
<%
	}else{
%>
	<li class="active8">
		<a href="../member/logout.jsp">Logout</a>
	</li>
	<li class="active9">
		<a href="../member/mUpdate.jsp">정보수정</a> 
	</li>
	
<%
	}
%>



								</ul>
							</nav>

					</div>
				</div>

	</header>