<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
 <meta name="viewport" content="width=device-width, initial-scale=1">
 
  <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
<link href="../assets/css/imgboard.css" rel="stylesheet" type="text/css">
 
<title>Delete</title>
    <style type="text/css">
	#nav > ul > li.active > a{
		opacity: 0.8;
	}
	
	#nav > ul > li.active2 > a{
		color: #fff;
	}
    </style>
</head>
<body>
<% 
	String id = (String) session.getAttribute("id");
	if(id==null){
		response.sendRedirect("../member/login.jsp");
	}
	// content.jsp(글 상세보기)에서 삭제할 글 번호, 페이지 넘버 가져오기
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");

%>

 <jsp:include page="../inc/top.jsp" />
 <article id="bo1">
 <center>
 <h2 style="text-align: center; margin-top: 100px; FONT-SIZE: 15pt; margin-top: 5em; color: #019FE1;">
		비밀번호를 입력해주세요.</h2><br>
<div class="container" style="text-align:center;">
	<form action="deletePro.jsp?pageNum=<%=pageNum %>" method="post">
			<input type="hidden" name="num" value="<%=num%>">
			<table id="notice" align="center">
				<tr>
					<td><input type="password" name="passwd" style="width:50%;"></td>
				</tr>
			</table><br><br>
			<div id="table_search" style="float: none">
				<input type="submit" value="삭제" class="btn">
				<input type="button" value="글목록" class="btn"
						onclick="location.href='about.jsp?pageNum=<%=pageNum%>'">		
			</div>
		</form>
		<div class="clear"></div>
		<div id="page_control"></div>
</div>
</center>
</article>
		<jsp:include page="../inc/bottom.jsp"/>
		
		<!-- Scripts -->
			<script src="../assets/js/jquery.min.js"></script>
			<script src="../assets/js/jquery.dropotron.min.js"></script>
			<script src="../assets/js/skel.min.js"></script>
			<script src="../assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="../assets/js/main.js"></script>




</body>
</html>