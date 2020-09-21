<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit</title>
</head>
<%
	String id = (String)session.getAttribute("id");
	String passwd = request.getParameter("passwd");

	MemberDAO mdao = new MemberDAO();

	int check = mdao.getPass(id, passwd);
	
	if(check ==1){
		response.sendRedirect("memberUpdate.jsp");
	}else{
%>	
		<script type="text/javascript">
			alert("비밀번호를 틀렸습니다.");
			history.back();
		</script>
<%		
	}
%>

<body>

</body>
</html>