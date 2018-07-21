<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<jsp:include page="header.jsp" flush="true" />


<title>감리 이력관리</title>

<style>
#footer {
   position:fixed;
   left:0px;
   bottom:0px;
   height:40px;
   width:100%;
   background:#F2F2F2;
   color: #2E2E2E;
   padding: 10px ;
}
#footer p {
   text-align: center;
   font-size: 12px;
}
.jumbotron {
    background-image: url('img/jumbotronBackground.jpg');
    background-size: cover;
    text-shadow: black 0.2em 0.2em 0.2em;
    color: white;
    height: 400px;
}

 </style>
</head>
<body>

	<div class="container-fluid">
		<div class="jumbotron">
			<div class="container">
			<h1> 감리인 이력  </h1>
			<p> 제안서 작성 지원을 목적으로 시범 제작하고 있습니다.</p>
			<!-- <p> <a class="btn btn-primary btn-pull" href="#" role="button"> 감리인 이력</a> </p> -->
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-12">
				<h4> 수행감리 리포트  </h4>
				<p> 제안서 작성시 이력사항을 찾아볼수 있도록 구성중입니다. 시범사이트 이므로 정식오픈시 공지드리도록 하겠습니다.</p>
				<p> <a class="btn btn-danger" data-target="#modal" data-toggle="modal">오늘의 운세</a> </p>
			</div>
			<!-- <div class="col-md-4">
				<h4> 테스트  </h4>
				<p> 제안서 작성시 이력사항을 찾아볼수 있도록 구성중입니다. 시범사이트 이므로 정식오픈시 공지드리도록 하겠습니다.</p>
				<p> <a class="btn btn-default" href="#">자세히 보기</a> </p>
			</div>
			<div class="col-md-4">
				<h4> 테스트  </h4>
				<p> 제안서 작성시 이력사항을 찾아볼수 있도록 구성중입니다. 시범사이트 이므로 정식오픈시 공지드리도록 하겠습니다.</p>
				<p> <a class="btn btn-default" href="#">자세히 보기</a> </p>
			</div> -->
		</div>
		<hr>
		
		
		<!-- <div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">
					<span class="glyphicon glyphicon-pencil"></span>
					&nbsp;&nbsp; 최근 수주 목록
				</h3>	
			</div>
			<div class="panel-body">
				<div class="media">
					<div class="media-left">
						<a href="#"><img class="media-object" src="images/icon.png" alt="최근 수주"></a>
					</div>
					<div class="media-body">
						<h4 class="media-heading">  <a href="#">수주목록</a>&nbsp;<span class="badge">New</span> </h4>
						최근 XXXX 사이트 감리를 수주하였습니다.
					</div>
				</div>
				<hr>
				<div class="media">
					<div class="media-left">
						<a href="#"><img class="media-object" src="images/icon.png" alt="최근 수주"></a>
					</div>
					<div class="media-body">
						<h4 class="media-heading">  <a href="#">수주목록</a>&nbsp;<span class="badge">New</span> </h4>
						최근 XXXX 사이트 감리를 수주하였습니다.
					</div>
				</div>
				<hr>
				<div class="media">
					<div class="media-left">
						<a href="#"><img class="media-object" src="images/icon.png" alt="최근 수주"></a>
					</div>
					<div class="media-body">
						<h4 class="media-heading">  <a href="#">수주목록</a>&nbsp;<span class="badge">New</span> </h4>
						최근 XXXX 사이트 감리를 수주하였습니다.
					</div>
				</div>
			</div>
		</div> -->
	
		

	<div class="row">
		<div class="modal" id="modal" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						제안서 받은날
						<button class="colse" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body" style="text-align: center;">
						<img src="img/aaa.jpg" id="imagepreview" style="width: 502px; height: 640px;">
					</div>
				</div>
			</div>
		</div>
	</div>
	
</div>

<div id="footer">
 <p>Copyright © KCA 2018   &nbsp;   </p>
</div> 
	
</body>

</html>