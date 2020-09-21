<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
 <meta charset="utf-8">
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
 <meta name="viewport" content="width=device-width, initial-scale=1">

 <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
<link href="../assets/css/imgboard.css" rel="stylesheet" type="text/css">

<script type="text/javascript">

	function checkVlaue() {
		
		if(!fr.passwd.value){
			alert("비밀번호를 입력해주세요");
			return false;
		}
		
		if(!fr.subject.value){
			alert("제목을 입력해주세요");
			return false;
		}
		
		if(!fr.content.value){
			alert("내용을 입력해주세요");
			return false;
		}
		
		if(!fr.filename.value){
			alert("파일을 등록해주세요");
			return false;
		}
		
		else{
			document.fr.submit();
		}
	}


</script>
	<style type="text/css">
	#nav > ul > li.active > a{
		opacity: 0.8;
	}
	
	#nav > ul > li.active3 > a{
		color: #fff;
	}
    </style>

<title>Write</title>
</head>
<body>
 <jsp:include page="../inc/top.jsp" />

 <%
		String id = (String)session.getAttribute("id");

	if(id!=null){

%>
 <article id="bo">
 <center>
  <h2 style="text-align: center; margin-top: 100px; FONT-SIZE: 20pt; margin-top: 2em; color: #019FE1;">Write</h2>
   <br><br>

 <div class="container-fluid">
 	<div class="row">
 		<div class="col-sm-8 col-md-offset-2" id="img_div">
		<form action="writePro.jsp" method="post" name="fr" enctype="multipart/form-data">
			<table id="notice" style="width: 100%" align="center">
			<tr>
				<th class="col-20">Name</th>
				<td><input type="text" name="name" readonly="readonly" value="<%=id%>"></td>
			</tr>	
			<tr>
				<th class="col-20">Password</th>
				<td><input type="password" name="passwd" placeholder="비밀번호를 입력하세요"></td>
			</tr>
			<tr>
				<th class="col-20">Subject</th>
				<td><input type="text" name="subject" placeholder="제목을 입력하세요"></td>
			</tr>
			<tr>
				<th class="col-20">Content</th>
				<td><textarea name="content" rows="13" cols="45" placeholder="글 내용을 입력하세요"></textarea></td>
			</tr>	
			<tr>
			<th class="col-20">File</th>
			<td><input type="file" name="filename"></td>
			</tr>
		</table>
		<div id="table_search">
		<input type="button" class="btn" onclick="checkVlaue(); return false;" value="등록">
		<input type="reset" value="다시쓰기" class="btn">
		<input type="button" value="글목록" class="btn" onclick="location.href='notice.jsp'">	
		</div>
</form>
</center>
</article>
<%
}else{
%>	
	<script type="text/javascript">
		alert("회원만 사용할 수 있는 서비스입니다.");
		location.href="../member/login.jsp";
	</script>	
	
<%	
}

%>

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