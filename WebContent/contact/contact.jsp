<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>

<html>
	<head>
		<title>Contact</title>
		<script type="text/javascript">
		function chk() {
			var check = document.getElementById("agree").checked;
			var num = 0;
			if (check == true) {
				num = 1;
			} else {
				num = 0;
			}

			if (num == 1) {
				document.contact - form.submit();
			} else {
				alert("개인정보 약관에 동의하셔야 합니다.");
			}
		}
		</script>
		
		<style type="text/css">
		.row{
			padding: 8px 0 0 40px;
			margin: -63px 0px -1px -76px;
		}
		.btn-send{
			color: white;
			background-color: #019FE1;
		    padding: 10px 20px;
		    font-size: 12px;
		    cursor: pointer;
		    border : 2px solid;
			border-radius: 5px;
			font-weight: bold;
			position: absolute;
			right: 30px;
			top: 350px;
		}
		
		
		.btn-send:HOVER{
			background: white;
		    color: #019FE1;
		    border: none;
		}
		#nav > ul > li.active > a{
			opacity: 0.8;
		}
	
		#nav > ul > li.active5 > a{
			color: #fff;
		}
		</style>
		
		<meta charset="utf-8" />
		<link href="../assets/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.8.1/baguetteBox.min.css">
		<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
				rel="stylesheet">
		<link rel="stylesheet" href="css/fluid-gallery.css">
		
		<link href="../assets/css/index_css.css" rel="stylesheet">


<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="../assets/css/main.css" />
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
	</head>
	<body>
		<jsp:include page="../inc/top.jsp"/>
	
	<div id="b">
	<div id="contact" style="height: 1000%">
		<div id="contact-us" class="parallax">
			<div class="container">
				<div class="row">
					<div
						class="heading text-center col-sm-8 col-sm-offset-2 wow fadeInUp"
						data-wow-duration="1000ms" data-wow-delay="300ms">

						<h2 align="center" style="FONT-SIZE: 20pt; margin-top: 1em; color: #019FE1;">Contact Us</h2>
						<br>
						<p>문의사항이나 건의사항을 말씀해주세요:)</p>
						<br><br><br><br>
					</div>
				</div>
				<div class="contact-form wow fadeIn" data-wow-duration="1000ms"
					data-wow-delay="600ms">
					<div class="row">
						<form id="main-contact-form" name="contact-form" method="post"
							action="mailSend.jsp" style="padding: 8px 0 0 40px; margin: -63px 0px 50px -76px;">
							<div class="col-sm-6">
								<div class="row  wow fadeInUp" data-wow-duration="1000ms"
									data-wow-delay="300ms">
									<div class="col-sm-2">
										<div class="form-group">
											<label>*이름 </label>
										</div>
									</div>
									<div class="col-sm-10">
										<div class="form-group">
											<input type="text" name="name" class="form-control"
												placeholder="Name" required="required">
										</div>
									</div>


									<div class="col-sm-2">
										<div class="form-group">
											<label>*E-mail </label>
										</div>
									</div>
									<div class="col-sm-10">
										<div class="form-group">
											<input type="email" name="email" class="form-control"
												placeholder="Email Address" required="required">
										</div>
									</div>
											<input type="hidden" name="receiver" class="form-control"
												value="dedentalal@gmail.com" required="required">
									<div class="col-sm-2">
										<div class="form-group">
											<label>*연락처 </label>
										</div>
									</div>
									<div class="col-sm-10">
										<div class="form-group">
											<input type="text" name="phone" class="form-control"
												placeholder="Phone Number" required="required">
										</div>
									</div>

								</div>

								<div class="form-group">
									<input type="text" name="subject" class="form-control"
										placeholder="Subject" required="required">
								</div>
								<div class="form-group">
									<textarea name="content" id="content" class="form-control"
										rows="10" placeholder="Enter your message" required="required"></textarea>
								</div>

							</div>
							<div class="col-sm-6">
								<div class="contact-info wow fadeInUp"
									data-wow-duration="1000ms" data-wow-delay="300ms">
									<div class="col-sm-12">
										<label
											style="font-size: 12px; text-align: center; margin-top: 50px;">
											개인정보 수집 및 이용에 관한 동의 </label>
									</div>
									<div class="col-sm-12">
										<p
											style="background-color: white; padding: 5px; border-radius: 5px; border: 1px solid #4d407d;
											font-size: 13px; ">
											개인의 정보 수집 및 이용 등 처리에 있어 아래의 사항을 관계법령에 따라 고지 및 안내 드립니다.</br> 1.
											수집하는 개인정보의 항목 : 성명, 이메일 주소, 휴대전화번호</br> 2. 수집 개인정보의 이용 목적 : 상담 및
											문의내용 답변</br> 3. 동의하지 않았을 경우 불이익</br> 귀하가 개인정보 수집 및 이용에 동의하지 않을 경우 귀하의
											개인정보를 수집하지 않으며, 이 경우 문의주신 내용에 대한 답변이 불가할 수 있습니다.</br> 4. 수집 개인정보의
											보유 기간 : 동의시점부터 6개월이내. 단, 정보제공자 요청 시 즉시 삭제</br>
										</p>
										<input type="checkbox" name="agree" id="agree"
											style="margin-left: 5px;"> 동의합니다.
									</div>
									<div class="form-group">
										<button onclick="chk(); return false;" class="btn-send">Send
											Now</button><br><br>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
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