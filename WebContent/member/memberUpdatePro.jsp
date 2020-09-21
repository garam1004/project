<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit</title>
</head>
<body>
<%
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");

%>
	
	<jsp:useBean id="mb" class="member.MemberBean"/>
	<jsp:setProperty property="*" name="mb"/>

	

	<%
		//DB작업할 BoardDAO객체 생성
		MemberDAO mdao = new MemberDAO();
		
	int check = mdao.updateMember(mb);
	
	if(check ==1){
%>	

	<script>
		alert("회원수정이 완료되었습니다!");
		location.href="../index.jsp";
	</script>
<%}else {

%>
	<script>
		alert("회원수정에 실패하였습니다.");
		location.href = history.back();
	</script>
<%
}
%>
	
</body>
</html>