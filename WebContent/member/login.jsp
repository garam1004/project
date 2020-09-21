<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Add icon library -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="../assets/css/login.css" rel="stylesheet" type="text/css">
<link href="../assets/css/bootstrap.css" rel="stylesheet" type="text/css">
<title>Login</title>

</head>
<header>
<jsp:include page="../inc/top.jsp"/>
	<style type="text/css">
	#nav > ul > li.active > a{
		opacity: 0.8;
	}
	
	#nav > ul > li.active6 > a{
		color: #fff;
	}
    </style>
</header>
<body>
<div id="b">
<form action="loginPro.jsp" style="max-width:400px; margin:135px auto;">
  <h2 style="text-align: center;"><b class="mm">Login</b></h2>
  <br>
  
  <div class="input-container">
    <i class="fa fa-user icon"></i>
    <input class="input-field" type="text" placeholder="Username" name="id" style="color: #5D5D5D;">
  </div>
  
  <div class="input-container">
    <i class="fa fa-key icon"></i>
    <input class="input-field" type="password" placeholder="Password" name="passwd" style="color: #5D5D5D;">
  </div>
  <button type="submit" class="btn-log">login</button>
 
 <br><br>
 
  <div class="m2"> 아직 회원이 아니신가요? <a href="join.jsp" class="m">회원가입 하러가기</a></div>
  
  
</form>
</div>
			<script src="../assets/js/jquery.min.js"></script>
			<script src="../assets/js/jquery.dropotron.min.js"></script>
			<script src="../assets/js/skel.min.js"></script>
			<script src="../assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="../assets/js/main.js"></script>
		<jsp:include page="../inc/bottom.jsp"/>
		
</body>
</html>