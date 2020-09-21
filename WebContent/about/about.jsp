<%@page import="board.ImgBoardBean"%>
<%@page import="board.ImgBoardDAO"%>
<%@page import="javax.swing.text.rtf.RTFEditorKit"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>About</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css?family=Droid+Sans:400,700" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.8.1/baguetteBox.min.css">
    <link rel="stylesheet" href="../assets/css/thumbnail-gallery.css">
	<link href="../assets/css/img/imgboard.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <script type="text/javascript">
    	function del(num) {
    		 if(confirm("정말 삭제하시겠습니까?")==true){
    			 location.href="delete.jsp?num="+num;
    		 }else{
    			 return;
    		 }
 		
    	}

    </script>	
    
    <style type="text/css">
    #main_img {
		width:65%; 
		height: 230px; 
		background-image: url("../images/bg.png");
		background-size: cover;
		vertical-align: middle;
		margin: 0;
		padding: 0;
		position: relative;
	}

	#main_img .content {
		font-family: Arial, Helvetica, sans-serif;
		text-align : center;
	 	 position: absolute;
	 	 bottom: 0px;
	 	 background: rgb(0, 0, 0); /* Fallback color */
	 	 background: rgba(0, 0, 0, 0.5); /* Black background with 0.5 opacity */
	 	 color: #f0f2f9;
	 	 width: 100%;
	     padding: 20px;
	}
	
	#bo {
		background-color: #fff;
	    margin-top: 1.5em;
	}
	
	.button{
		background-color: #019FE1;
		color: #fff;
	
	}
	#nav > ul > li.active > a{
		opacity: 0.8;
	}
	
	#nav > ul > li.active2 > a{
		color: #fff;
	}
    </style>
</head>

<% 
	request.setCharacterEncoding("UTF-8");

	//전체 글개수 검색을 위해 BoardDAO객체 생성
	ImgBoardDAO imgdao = new ImgBoardDAO();

	//전체 글 개수 검색해서 얻기
	int count = imgdao.getBoardCount();
	int totalRecord = 0;
	
	ArrayList list = null;
	
	if(count>0){
		list  = imgdao.getBoardList();
		totalRecord = list.size();
	}
	String id = (String)session.getAttribute("id");
	
	
	int numPerPage = 3;
	int pagePerBlock = 3; 

	int totalPage = 0; 
	int totalBlock = 0;
	int nowPage = 0;
	int nowBlock = 0; 
	int beginPerPage = 0; 
	
	
	
	totalPage =  (int)Math.ceil((double)totalRecord / numPerPage); 

	totalBlock =  (int)Math.ceil((double)totalPage / pagePerBlock); 
	
	if(request.getParameter("nowPage") != null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));

	}

	if(request.getParameter("nowBlock") != null){

		nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
	}

	beginPerPage = nowPage * numPerPage;
%>

<body>

<jsp:include page="../inc/top.jsp"/>

<article id=bo>     
<div class="container-fluid">
    <div class="row" style="height: 60px;">&nbsp;</div>
    <div class="row" id="main_img" style="margin-top: 5px; margin: 0 auto;">
		  <div class="content">
		   <h1>About</h1>
		    <p class="page-description text-center"></p>
		  </div>
   		 </div>
</div>    


 <div class="container gallery-container">   

    <div class="tz-gallery">

        <div class="row">
        
<%
	//만약에 게시판의 글이 있다면 
	if(count > 0){
		for(int cnt=beginPerPage; cnt<(beginPerPage + numPerPage); cnt++){
			if(cnt == totalRecord){
				break;
			}	
			ImgBoardBean iBean = (ImgBoardBean)list.get(cnt);
			String filename=iBean.getFile();
%>  
			

            <div class="col-sm-6 col-md-4">
                <div class="card">
                        <a class="lightbox" href="../upload/<%=iBean.getFile()%>">
                        <img src="<%=request.getContextPath() %>/upload/<%=iBean.getFile()%>">
                    </a>
                    <div class="caption">
                        <h3><%=iBean.getSubject() %></h3>
                        <p><%=iBean.getContent().replace("\n","<br/>") %></p>
                    </div>
                <div>
                <% 
                	if(id==null){
                %>
               &nbsp;
                	
                <%		
                	}
	        	else if(id.equals(iBean.getName())){
	        		
                %>	
                	<a href="update.jsp?num=<%=iBean.getNum()%>">수정</a>
                	<a href="#" onclick="del(<%=iBean.getNum()%>); return false;">삭제</a> 

                <%
                	}else{
                %>		
   					<i class="fa fa-heart" style="font-size:15px;color:#ff6060"></i></a> 
    			
    			<%		
                	}
                %>	
                	
                	  
                	  
                	  
                	  
                	  </div>    
                </div>
            </div>
            
<%
		}			
		
	}else{//게시판에 글이 없다면
%>

	<div class="col-md-4">
              <h1>게시글 없음</h1>
            </div>

<%		
	}

%>


        </div>

    <%
    if(id != null){
    %>
    <br><br>
  <button class="button" onclick="location.href='write.jsp'" style="background-color: #019FE1;
		color: #fff; float: right;"><span>글쓰기 </span></button>  
  <%
    }else{ }
  %>
<div class="pagination">
			
			<%	
				if(totalBlock > 0){
					
					if(nowBlock > 0){
			%>			
				<a href="about.jsp?nowBlock=<%=nowBlock-1%>&nowPage=<%=(nowBlock-1)*pagePerBlock%>">
					&laquo;
					</a>
			<%			
					}
			}
			%>

			<%
			  
			  for(int cnt=0; cnt<pagePerBlock; cnt++){
					
					if((nowBlock*pagePerBlock) + cnt == totalPage){
						break;
					}		
			  
			  		
			%>		
					<%--페이지 번호 링크  --%>
					<a href="about.jsp?nowBlock=<%=nowBlock%>&nowPage=<%=(nowBlock*pagePerBlock)+cnt%>">			
						<%=(nowBlock * pagePerBlock) + 1 + cnt %>	
					</a>					
			<%
					if( ((nowBlock*pagePerBlock) + 1 + cnt) == totalRecord ){
						break;
					}			
				}
			  %>
				
 				<%
				
				if(totalBlock > nowBlock + 1){
			%>	
				 <a href="about.jsp?nowBlock=<%=nowBlock+1%>&nowPage=<%=(nowBlock+1)*pagePerBlock%>">
				  &raquo;
				 </a>
			<%
				}
				%>
							
		</div>

    </div>
    

    

</div>
</article>



		<jsp:include page="../inc/bottom.jsp"/>
		
		<!-- Scripts -->
			<script src="../assets/js/jquery.min.js"></script>
			<script src="../assets/js/jquery.dropotron.min.js"></script>
			<script src="../assets/js/skel.min.js"></script>
			<script src="../assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="../assets/js/main.js"></script>


<script src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.8.1/baguetteBox.min.js"></script>
<script>
    baguetteBox.run('.tz-gallery');
</script>
	</body>
</body>
</html>