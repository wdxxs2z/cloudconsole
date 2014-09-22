<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Logn In - CloudFoundry Console</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description" content="" />
<meta name="author" content="stilearning" />

<!-- google font -->
<link href="<c:url value="/css/google-css.css"/>" rel="stylesheet"
	type="text/css" />

<!-- styles -->
<link rel="stylesheet" href="<c:url value="/css/bootstrap.css"/>" />
<link rel="stylesheet"
	href="<c:url value="/css/bootstrap-responsive.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/stilearn.css"/>" />
<link rel="stylesheet"
	href="<c:url value="/css/stilearn-responsive.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/stilearn-helper.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/stilearn-icon.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/font-awesome.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/animate.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/uniform.default.css"/>" />

<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
</head>

<body>
	<header class="header" data-spy="affix" data-offset-top="0">
		<div class="navbar-helper">
			<div class="row-fluid">
				<!--panel site-name-->
				<div class="span2">
					<div class="panel-sitename">
						<h2>
							<span class="color-teal">CloudFoundry</span>Console
						</h2>
					</div>
				</div>
			</div>
		</div>
	</header>

	<section class="section">
		<div class="container">
			<div class="signin-form row-fluid">
				<!--Sign In-->
				<div class="span5">
					<div class="box corner-all">
						<div class="box-header grd-teal color-white corner-top">
							<span>登陆CloudFoundry Console</span>
						</div>
						<div class="box-body bg-white">
							<form id="sign-in" action="./authenticator" method="post" >
								<div class="control-group">
									<label class="control-label">用户名</label>
									<div class="controls">
										<input type="text" class="input-block-level"
											data-validate="{required: true, messages:{required:'Please enter field username'}}"
											name="login_username" id="login_username" autocomplete="off" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">用户密码</label>
									<div class="controls">
										<input type="password" class="input-block-level"
											data-validate="{required: true, messages:{required:'Please enter field password'}}"
											name="login_password" id="login_password" autocomplete="off" />
									</div>
								</div>
								<div class="control-group">
									<label class="checkbox"> <input type="checkbox"
										data-form="uniform" name="remember_me" id="remember_me_yes"
										value="yes" /> Remember me
									</label>
								</div>
								<div class="form-actions">
									<input type="submit"
										class="btn btn-block btn-large btn-primary"
										value="使劲戳我登陆" />
									<p class="recover-account">
										Recover your <a href="#modal-recover" class="link"
											data-toggle="modal">username or password</a>
									</p>
								</div>
							</form>
						</div>
					</div>
				</div>
				<!--/Sign In-->
			</div>
		</div>
	</section>
</body>
</html>