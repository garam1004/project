<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.invalidate();
%>

<script>
	alert("로그아웃이 완료되었습니다.");
	location.href="../index.jsp"
</script>
	<style type="text/css">
	#nav > ul > li.active > a{
		opacity: 0.8;
	}
	
	#nav > ul > li.active8 > a{
		color: #fff;
	}
    </style>