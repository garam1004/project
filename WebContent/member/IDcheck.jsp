<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../asstes/css/member.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">

<title>ID Check</title>

	<script type="text/javascript">
	
	function result(){
		opener.document.fr.idDuplication.value = "idcheck";
		opener.document.fr.id.value = document.nfr.chkid.value;
		window.close();
	}
	</script>

<style>

body{
	font-family: 'Nanum Gothic', sans-serif;

}
.idchk_btn{
	margin : 0;
	text-align : center;
	color: white;
	background-color: #019FE1;
	border : 2px solid #019FE1;
	font-size : 15px;
	border-radius: 3px;
	padding: 5px;
	font-family: 'Nanum Gothic', sans-serif;
}

.idchk_btn:HOVER {
	color: #019FE1;
	background-color: white;
	font-weight: bold;
	cursor: pointer;
	font-family: 'Nanum Gothic', sans-serif;
}
#chkid{
	padding : 5px;
	border: 1px solid #019FE1;
	border-radius: 3px;
	font-family: 'Nanum Gothic', sans-serif;
}


</style>

</head>
<body>
<br><br>
<%
	String id = request.getParameter("chkid");

	MemberDAO mdao = new MemberDAO();
	
	int check = mdao.idCheck(id);
	
	if(check==1){
		out.println("이미 사용중인 ID입니다.");
	}else{
		out.println("사용가능한 ID입니다.");
%>
-
	 	<input type="button" value="사용하기" class="idchk_btn" onclick="result();">
	 	
<%	
	}

%>

	<br><br>
	<form action="IDcheck.jsp" method="post" name="nfr">
		아이디 : <input type="text" name="chkid" id="chkid" value="<%=id%>">
		<input type="submit" value="중복확인" class="idchk_btn">
	</form>


</body>
</html>