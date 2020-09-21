<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../assets/css/member.css" rel="stylesheet" type="text/css">
<link href="../assets/css/bootstrap.min.css" rel="stylesheet">
<link href="../assets/css/main.css" rel="stylesheet" type="text/css">
<title>Edit</title>
	<style type="text/css">
	#nav > ul > li.active > a{
		opacity: 0.8;
	}
	
	#nav > ul > li.active9 > a{
		color: #fff;
	}
    </style>
</head>
<body>
<jsp:include page="../inc/top.jsp"/>
<center>
<div id="b1">
<div class="container-fluid">
<div class="row" id="mUp_div">
<div class="col-md-8 col-md-offset-2" id="mUp_div2">
<h3 class="h3">회원정보 수정을 위해 비밀번호를 입력해주세요</h3>
<br>
<center>
<form action="mUpdatePro.jsp" id="mUp_form" style="display: inline; width: 50em;">
<input type="password" name="passwd" id="mUp_pass" style="color: #5D5D5D;"> <br>
<button type="submit" id="mUp_btn">확인</button>
</form>
</center>
</div>
</div>
</div>
</div>
</center>
		<jsp:include page="../inc/bottom.jsp"/>
			<script src="../assets/js/jquery.min.js"></script>
			<script src="../assets/js/jquery.dropotron.min.js"></script>
			<script src="../assets/js/skel.min.js"></script>
			<script src="../assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="../assets/js/main.js"></script>

</body>
</html>
