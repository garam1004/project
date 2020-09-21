<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1" />

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="../assets/css/bootstrap.min.css" rel="stylesheet">
<link href="../assets/css/member.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"> </script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>

<title>Edit</title>
	<style type="text/css">
	#nav > ul > li.active > a{
		opacity: 0.8;
	}
	
	#nav > ul > li.active9 > a{
		color: #fff;
	}
    </style>
</head>

<%
	String id = (String)session.getAttribute("id");

	if(id==null){
%>
	<script type="text/javascript">
		alert("로그인이 필요한 서비스입니다.");
		location.href="login.jsp";
	</script>

<%
	}

	MemberDAO mdao = new MemberDAO();
	
	MemberBean mb = mdao.getMember(id);
%>

<script type="text/javascript">
$(document).ready(function() {
	
	var getName= RegExp(/^[A-Za-z가-힣]{2}/);
	var re = RegExp(/[a-zA-Z0-9]{4,12}$/);
	var getPass = RegExp(/[a-zA-Z]{1}[0-9]{1}/);
	var re2 = RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i);
	var getPhone = RegExp(/^(010|011)[-\s]?\d{3,4}[-\s]?\d{4}$/);
	var getEmail = RegExp(/^[\w\.-]{1,64}@[\w\.-]{1,252}\.\w{2,4}$/);	
	var getBirth = RegExp(/^[0-9]{2}[0,1]{1}[0-9]{1}[0-3]{1}[0-9]{1}$/);
	
	
	$("#pass_sp1").hide()
	$("#pass_sp2").hide()
	$("#pass_sp3").hide()
	$("#name_sp").hide()
	$("#ph_sp").hide()
	$("#email_sp").hide()
	$("#birth_sp").hide()

	
	$("#pass").blur(function() {
		 if(!re.test($("#pass").val())){
			 $("#pass_sp1").show('fast');
			 $("#pass").val("");
		 }else{$("#pass_sp1").hide('fast');}
	 
		 if(!getPass.test($("#pass").val())){
			 $("#pass_sp2").show('fast');
			 $("#pass").val("");
		 }else{$("#pass_sp2").hide('fast');}
	
	});//pass
	
	$("#pass-repeat").blur(function() {
		var pass1 = $("#pass").val();
		var pass2 = $("#pass-repeat").val();
		 if(pass1!=pass2){
			 $("#pass_sp3").show('fast');
			 $("#pass-repeat").val("");
		 }else{$("#pass_sp3").hide('fast');}
	
	});//pass

	
	$("#name").blur(function() {		
		 if(!getName.test($("#name").val())){
			 $("#name_sp").show('fast');
			 $("#name").val("");
		 }else{$("#name_sp").hide('fast');} 
	});//name

	$("#phone").blur(function() {	
		 if(!getPhone.test($("#phone").val())){
			 $("#ph_sp").show('fast');
			 $("#phone").val("");
		 }else{$("#ph_sp").hide('fast');} 	 
	});//phone
	
	$("#email").blur(function() {	
		 if(!getEmail.test($("#email").val())){
			 $("#email_sp").show('fast');
			 $("#email").val("");
		 }else{$("#email_sp").hide('fast');} 	 
	});//email
	
	$("#birth").blur(function() {	
		 if(!getBirth.test($("#birth").val())){
			 $("#birth_sp").show('fast');
			 $("#birth").val("");
		 }else{$("#birth_sp").hide('fast');} 	 
	});//birth
	
});


function sample6_execDaumPostcode() {
    new daum.Postcode({

        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = ''; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                fullAddr = data.roadAddress;

            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                fullAddr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
            if(data.userSelectedType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('sample6_address').value = fullAddr;

            // 커서를 상세주소 필드로 이동한다.
            document.getElementById('sample6_address2').focus();
        }
    }).open();
}


function checkVlaue() {
	
	if(!fo.pass.value){
		alert("비밀번호를 입력해주세요");
		return false;
	}
	
	if(!fo.name.value){
		alert("이름을 입력해주세요");
		return false;
	}
	
	if(!fo.phone.value){
		alert("전화번호를 입력해주세요");
		return false;
	}
	
	if(!fo.email.value){
		alert("이메일을 입력해주세요");
		return false;
	}
	
	else{
		document.fo.submit();
	}
}



</script>
<jsp:include page="../inc/top.jsp"/>
<style type="text/css">
	#mem_up_con form span{
		color: #FF0000;
		font-size: 15px;
	}
	
	</style>


<body>

<div id="b2">
<h2 style="text-align: center; margin-top: 70px; font-size: 23px; 
	font-family: 'Nanum Gothic', sans-serif; color: #019FE1; margin-top: 50px;">회원정보 수정</h2>

<br><br>

<div class="container-fluid">
<div class="row" id="mem_up_row">
<div class="col-md-8 col-md-offset-2">
<center>
    <div id="mem_up_con">
      <form action="memberUpdatePro.jsp" name="fo">
      
        <div class="row">
 
         <!--    <h3>Billing Address</h3> -->
            <label for="fname"><i class="fa fa-user"></i> <b style="color: #FFF;">ID</b></label>
            <input type="text" id="id" name="id" value="<%=mb.getId()%>" readonly="readonly" class="c">
            <label for="pass"><i class="fa fa-lock"></i> <b style="color: #FFF;">Password</b>
            <span id="pass_sp1"> *비밀번호는 4~12자의 영문 대소문자와 숫자만 가능합니다 <br/></span>
    		<span id="pass_sp2"> *비밀번호에는 하나이상의 문자와 숫자가 포함되어야 합니다.</span> </label>
            <input type="password" id="pass" name="passwd" value="<%=mb.getPasswd()%>" class="c">
            <label for="password"><i class="fa fa-lock"></i> <b style="color: #FFF;">Password 확인</b>
            <span id="pass_sp3"> *비밀번호가 다릅니다.</span> </label>
            <input type="password" id="pass-repeat" name="passwd2" class="c">
            <label for="name"><i class="fa fa-smile-o"></i> <b style="color: #FFF;">Name</b>
            <span id="name_sp"> *이름은 2자 이상의 문자만 입력할 수 있습니다.</span></label>
            <input type="text" id="name" name="name" value="<%=mb.getName()%>" class="c">
            <label for="phone"><i class="glyphicon glyphicon-phone"></i> <b style="color: #FFF;">Phone</b>
            <span id="ph_sp"> *전화번호 형식이 잘못되었습니다.</span></label>
            <input type="text" id="phone" name="mtel" value="<%=mb.getMtel()%>" class="c">
            <label for="email"><i class="fa fa-envelope"></i> <b style="color: #FFF;">Email</b>
            <span id="email_sp"> *이메일 형식이 잘못되었습니다.</span></label>
            <input type="text" id="email" name="email" value="<%=mb.getEmail()%>" class="c">
    		<label for="birth"><i class="fa fa-birthday-cake"></i> <b style="color: #FFF;">Birth</b>
    		<span id="birth_sp"> *생일은 형식이 올바르지 않습니다.(6자리 숫자만 가능)</span></label>
   			<input type="text" name="birth" id="birth" value="<%=mb.getBirth()%>" class="c">     
   			<label>    
   			<label for="address"><i class='fas fa-house-user'></i> <b style="color: #FFF;">Address</b></label><br>
            <input type="text" id="sample6_postcode" placeholder="우편번호" readonly="readonly" value="<%=mb.getPostcode() %>" name="postcode" class="c"
                style="width: auto; margin-left: 17px;">
			<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" id="postcode_btn" ></label> 
			<input type="text" id="sample6_address" placeholder="주소" readonly="readonly" value="<%=mb.getAddr1()%>" name="addr1" class="c">
			<input type="text" id="sample6_address2" placeholder="상세주소" value="<%=mb.getAddr2()%>" name="addr2" class="c">

         </div>

        <input type="button" value="수정하기" class="btn" id="btn" onclick="checkVlaue(); return false;" style="margin-left: 4%;"> 

      </form>
    </div>
</center>
</div>
</div>
</div>
</div>
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