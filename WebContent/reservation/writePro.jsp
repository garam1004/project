
<%@page import="board.rBoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>write_pro.jsp</title>
</head>
<body>
<%
	String id=(String)session.getAttribute("id");
	if(id==null){
		response.sendRedirect("../member/login.jsp");
	}
	
	request.setCharacterEncoding("UTF-8");
%>
	<jsp:useBean id="rbBean" class="board.rBoardBean"/>
	<jsp:setProperty property="*" name="rbBean"/>
<%
	rbBean.setDate(new Timestamp(System.currentTimeMillis()));
	rbBean.setIp(request.getRemoteAddr());
	
	rBoardDAO rbdao = new rBoardDAO();
	rbdao.insertBoard(rbBean); 

 	response.sendRedirect("reservation.jsp"); 
%>


</body>
</html>
