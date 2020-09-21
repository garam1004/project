<%@page import="member.MemberDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="mb" class="member.MemberBean"/>
<jsp:setProperty property="*" name="mb"/>
<%
mb.setReg_date(new Timestamp(System.currentTimeMillis()));

MemberDAO memberdao=new MemberDAO();
memberdao.insertMember(mb);
response.sendRedirect("login.jsp");

%>
