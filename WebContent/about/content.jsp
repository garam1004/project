<%@page import="board.ImgBoardBean"%>
<%@page import="board.ImgBoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../assets/css/bootstrap.min.css" rel="stylesheet">
<link href="../assets/css/imgboard.css" rel="stylesheet">
</head>

<%
	//글상세보기 페이지
		//notice.jsp페이지에서 글제목을 클릭 했을떄.. 전달하여 넘어온 num, pageNum 한글처리
		request.setCharacterEncoding("UTF-8");

		int num = Integer.parseInt(request.getParameter("num"));
		
		ImgBoardDAO imgdao = new ImgBoardDAO();
		
		
		//하나의 글에 대한 정보를 SELECT하여 BoardBean객체 리턴 받기 
		ImgBoardBean iBean = imgdao.getBoard(num);
		
		int DBnum = iBean.getNum(); 
		int DBReadcount = iBean.getCount(); 
		String DBName = iBean.getName();// 검색한 정보중.. 글작성자 이름
		Timestamp DBDate = iBean.getDate(); //검색한 정보중..  작성일
		String DBSubject = iBean.getSubject(); //검색한 정보중.. 글제목 
		String DBContent = ""; //글내용
		
		//글내용이 존재 한다면 // 내용 엔터처리 해서 얻기
		if(iBean.getContent() != null){
			DBContent = iBean.getContent().replace("\r\n", "<br/>");
		}

		
%>

<body>
<div class="main">
<h2><%=DBSubject %></h2>
</div>

<br><br><br>
<div class="container">
          <div class="row">
          <div class="col-md-4"></div>
          <div class="col-md-8" id="imgbdrd">
<img id="myImg" src="<%=request.getContextPath() %>/upload/<%=iBean.getFile()%>" alt="<%=DBContent %>">
</div>
</div>
</div>
 <!-- The Modal -->
<div id="myModal" class="modal">
 <span class="button" data-dismiss="modal" aria-label="Close">cancel</span>
  <img class="modal-content" id="img01">
  <div id="caption"></div>
</div>

<script>
// Get the modal
var modal = document.getElementById('myModal');

// Get the image and insert it inside the modal - use its "alt" text as a caption
var img = document.getElementById('myImg');
var modalImg = document.getElementById("img01");
var captionText = document.getElementById("caption");
img.onclick = function(){
    modal.style.display = "block";
    modalImg.src = this.src;
    captionText.innerHTML = this.alt;
}

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks on <span> (x), close the modal
span.onclick = function() { 
    modal.style.display = "none";
}
</script>

</body>
</html>