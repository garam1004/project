<%@page import="board.rBoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="rbBean" class="board.rBoardBean"/>
<jsp:setProperty property="*" name="rbBean"/>
<%
//setDate() setIp()
rbBean.setDate(new Timestamp(System.currentTimeMillis()));
rbBean.setIp(request.getRemoteAddr());
//디비작업 파일 만들기 패키지 board 파일이름 BoardDAO
//객체 생성 BoardDAO bdao
rBoardDAO rbdao = new rBoardDAO();
//(자식글 답변내용 + 부모글의 그룹번호, 들여쓰기 번호, 위치번호)를 지니고 있는 bBean객체 넘기기
rbdao.reInsertBoard(rbBean);
//이동 list.jsp
response.sendRedirect("reservation.jsp");
%>


</body>
</html>