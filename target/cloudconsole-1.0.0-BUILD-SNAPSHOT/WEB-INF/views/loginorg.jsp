<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.cloudfoundry.client.lib.CloudFoundryClient"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudOrganization" %>
<%@page import="org.cloudfoundry.client.lib.domain.CloudSpace" %>
<%@page import="java.util.List" %>
<%
	CloudFoundryClient client = (CloudFoundryClient) session.getAttribute("client");
%>
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
<style type="text/css">
html {
	background: url('<c:url value="/img/login_bg.jpg"/>') no-repeat center center fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}

body {
	background: none;
}

.login, .register {
	margin-top: 70px;
	background: rgba(251, 251, 251, 0.5);
	border: 1px solid #ccc;
}
</style>
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

	<section class="section login">
		<div class="container">
			<div class="signin-form row-fluid">
				<!--Sign In-->
				<div class="span3"></div>
				<div class="span5">
					<div class="box corner-all">
						<div class="box-header grd-teal color-white corner-top">
							<span>选择云端组织空间</span>
						</div>
						<div class="box-body bg-white">
						<ul>
							<li class="btn-group">
							<a href="#" class="btn btn-small btn-link dropdown-toggle" data-toggle="dropdown"> 
								<i class="icofont-tasks"></i> <strong>请选择云端组织空间</strong>
								<i class="icofont-caret-down"></i>
							</a>
							<ul class="dropdown-menu">
									<%
                                   		List<CloudOrganization> organizations = client.getOrganizations();
                            			for (CloudOrganization organization : organizations) {
                                    %>
                                        <li class="nav-header"><%=organization.getName() %>
                                        	<ul class="dropdown-submenu">
                                        	<%
                                        		List<CloudSpace> spaces = client.getSpaces();
                                        		for (CloudSpace space : spaces) {
                                        			List<CloudSpace> orgspaces = client.getSpaceFromOrgName(organization.getName());
                                        			for (CloudSpace orgspace : orgspaces){
                                        				if (orgspace.getMeta().getGuid().toString().equals(space.getMeta().getGuid().toString())) {
                                        	%>
                                        		<li><a href="loginSwitchSpace?orgName=<%=organization.getName()%>&spaceName=<%=space.getName() %>" ><%=space.getName() %></a></li>
                                        	<%                                       				
                                        				}
                                        			}
                                        		}
                                        	%>
                                        	</ul>
                                        </li>
                                    <%
                            			}
                                    %>
							</ul>
							</li>
						</ul>
						</div>
					</div>
				</div>
				<!--/Sign In-->
			</div>
		</div>
	</section>
<script type="text/javascript"
		src='<c:url value="/js/widgets.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/jquery.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/jquery-ui.min.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/bootstrap.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/uniform/jquery.uniform.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/peity/jquery.peity.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/select2/select2.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/knob/jquery.knob.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/flot/jquery.flot.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/flot/jquery.flot.resize.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/flot/jquery.flot.categories.js"></c:url>'></script>
	<!-- this plugin required jquery ui-->

	<!-- required stilearn template js, for full feature-->
	<script type="text/javascript"
		src='<c:url value="/js/holder.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/stilearn-base.js"></c:url>'></script>
		
		<script type="text/javascript">
		$(document)
				.ready(
						function() {
							// try your js

							// normalize event tab-stat, we hack something here couse the flot re-draw event is any some bugs for this case
							$('#tab-stat > a[data-toggle="tab"]').on('shown',
									function() {
										if (sessionStorage.mode == 4) { // this hack only for mode side-only
											$('body,html').animate({
												scrollTop : 0
											}, 'slow');
										}
									});
						});
	</script>
</body>
</html>