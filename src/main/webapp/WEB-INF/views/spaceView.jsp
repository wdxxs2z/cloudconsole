<%@page import="java.text.Format"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudInfo"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudApplication"%>
<%@page import="org.cloudfoundry.client.lib.CloudFoundryClient"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudOrganization"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudSpace"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudUser"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%
	CloudFoundryClient client = (CloudFoundryClient) session.getAttribute("client");
	CloudSpace space = (CloudSpace)session.getAttribute("space");
	Map<String,String> spaceUsers = (Map<String,String>)session.getAttribute("spaceUsers");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Dashboard - 云平台统一监控</title>
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
<link rel="stylesheet" href="<c:url value="/css/DT_bootstrap.css"/>" />

<link rel="stylesheet" href="<c:url value="/css/select2.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/fullcalendar.css"/>" />
<link rel="stylesheet"
	href="<c:url value="/css/bootstrap-wysihtml5.css"/>" />

<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>

<body>
	<!-- section header -->
	<header class="header">
		<!--nav bar helper-->
		<div class="navbar-helper">
			<div class="row-fluid">
				<!--panel site-name-->
				<div class="span2">
					<div class="panel-sitename">
						<h2>
							<a href="./home"><span class="color-teal">CloudFoundry</span>Console</a>
						</h2>
					</div>
				</div>
			</div>
		</div>
		<!--/nav bar helper-->
	</header>

	<!-- section content -->
	<section class="section">
		<div class="row-fluid">
			<!-- span side-left -->
			<div class="span1">
				<!--side bar-->
				<aside class="side-left">
					<ul class="sidebar">
						<li>
							<!--always define class .first for first-child of li element sidebar left-->
							<a href="./home" title="dashboard">
								<div class="helper-font-24">
									<i class="icofont-dashboard"></i>
								</div> <span class="sidebar-text">控制台</span>
						</a>
						</li>
						<li><a href="./organization" title="Organizations">
								<div class="helper-font-24">
									<i class="icofont-magnet"></i>
								</div> <span class="sidebar-text">租户管理</span>
						</a></li>
						<li class="active first"><a href="./spaceView" title="spaces">
								<div class="helper-font-24">
									<i class="icofont-edit"></i>
								</div> <span class="sidebar-text">租户空间</span>
						</a></li>
						<li>
                        	<a href="./securityView" title="Security">
                            <div class="helper-font-24">
                            	<i class="icofont-umbrella"></i>
                            </div>
                            <span class="sidebar-text">安全组</span>
                            </a>
                         </li>
						<li><a href="./appView" title="apps">
								<div class="helper-font-24">
									<i class="icofont-bar-chart"></i>
								</div> <span class="sidebar-text">应用管理</span>
						</a>
							<ul class="sub-sidebar corner-top shadow-silver-dark">
								<li><a href="./uploadApp" title="cluster monit">
										<div class="helper-font-24">
											<i class="icofont-warning-sign"></i>
										</div> <span class="sidebar-text">上传应用</span>
								</a></li>
							</ul></li>
						<li><a href="./domain" title="Routes">
								<div class="helper-font-24">
									<i class="icofont-table"></i>
								</div> <span class="sidebar-text">域名管理</span>
						</a></li>
						<li><a href="./services" title="ServiceMarket">
								<div class="helper-font-24">
									<i class="icofont-columns"></i>
								</div> <span class="sidebar-text">服务市场</span>
						</a></li>
						<li><a href="./serviceGateway" title="ServiceGateway">
								<div class="helper-font-24">
									<i class="icofont-reorder"></i>
								</div> <span class="sidebar-text">服务网关</span>
						</a></li>
						<li>
                        	<a href="./eventView" title="cloudEvent">
                            <div class="helper-font-24">
                            	<i class="icofont-envelope-alt"></i>
                            </div>
                            <span class="sidebar-text">平台事件</span>
                            </a>
                        </li>
						<li><a href="./dea" title="Dea">
								<div class="helper-font-24">
									<i class="icofont-cloud"></i>
								</div> <span class="sidebar-text">DEA监控</span>
						</a></li>						
						<li><a href="#" title="more">
								<div class="badge badge-important">5</div>
								<div class="helper-font-24">
									<i class="icofont-th-large"></i>
								</div> <span class="sidebar-text">组件监控</span>
						</a>
							<ul class="sub-sidebar corner-top shadow-silver-dark">
								<li><a href="./monit" title="not found">
										<div class="helper-font-24">
											<i class="icofont-warning-sign"></i>
										</div> <span class="sidebar-text">集群状态</span>
								</a></li>
								<li><a href="./loadBalance" title="login">
										<div class="helper-font-24">
											<i class="icofont-lock"></i>
										</div> <span class="sidebar-text">负载均衡</span>
								</a></li>
								<li><a href="./trafficView" title="invoice">
										<div class="helper-font-24">
											<i class="icofont-barcode"></i>
										</div> <span class="sidebar-text">流量控制</span>
								</a></li>
								<li><a href="./monitEvent" title="pricing table">
										<div class="helper-font-24">
											<i class="icofont-briefcase"></i>
										</div> <span class="sidebar-text">事件信息</span>
								</a></li>
								<li class="divider"></li>
								<li><a href="./bonus-page/resume/index.html" title="resume">
										<div class="helper-font-24">
											<i class="icofont-user"></i>
										</div> <span class="sidebar-text">Resume</span>
								</a></li>
							</ul></li>
					</ul>
				</aside>
				<!--/side bar -->
			</div>
			<!-- span side-left -->

			<div class="span11">
				<!-- content -->
				<div class="content">
					<div class="content-header">
						<h2>
							<i class="icofont-home"></i> Cloud Space <small>数据中心空间管理</small>
						</h2>
					</div>
					<!-- /content-header -->

					<!-- content-breadcrumb -->
					<div class="content-breadcrumb">
						<!--breadcrumb-nav-->
						<ul class="breadcrumb-nav pull-right">
							<li class="divider"></li>
							<li class="btn-group"><a href="#"
								class="btn btn-small btn-link dropdown-toggle"
								data-toggle="dropdown"> <i class="icofont-tasks"></i> Tasks
									<i class="icofont-caret-down"></i>
							</a>
								<ul class="dropdown-menu">
									<li><a href="#">Some Action</a></li>
									<li><a href="#">Other Action</a></li>
									<li class="divider"></li>
									<li><a href="#">Something Else</a></li>
								</ul></li>
							<li class="divider"></li>
							<li class="btn-group"><a href="#"
								class="btn btn-small btn-link"> <i class="icofont-money"></i>
									Orders <span class="color-red">(+12)</span>
							</a></li>
							<li class="divider"></li>
							<li class="btn-group"><a href="#"
								class="btn btn-small btn-link"> <i class="icofont-user"></i>
									Users <span class="color-red">(+34)</span>
							</a></li>
						</ul>
						<!--/breadcrumb-nav-->

						<!--breadcrumb-->
						<ul class="breadcrumb">
							<li><a href="./home"><i class="icofont-home"></i>
									Dashboard</a> <span class="divider">&rsaquo;</span></li>
							<li><a href="./organization">数据中心-<%=space.getOrganization().getName() %></a> <span class="divider">&rsaquo;</span></li>
							<li><a href="./orgManager?orgName=<%=space.getOrganization().getName() %>">Space-空间统一管理</a> <span class="divider">&rsaquo;</span></li>
							<li class="active"><%=space.getName() %></li>
						</ul>
						<!--/breadcrumb-->
					</div>
					<!-- /content-breadcrumb -->
					<div class="content-body">
						<ul class="a-btn-group">
							<li><a href="./spaceuser" class="b-btn grd-white"> <span
									class="b-btn-slide-text color-silver-dark"><%=spaceUsers.size() %>个用户</span> <i
									class="img icofont-bar-chart color-silver-dark helper-font-48"></i>
									<span class="b-btn-icon-right"> <span> <i
											class="icofont-arrow-down helper-font-24 color-silver-dark"></i>
									</span>
								</span>
							</a></li>
							<li><a href="./spaceServiceInstance" class="b-btn grd-white"> <span
									class="b-btn-slide-text color-silver-dark"><%=client.getServicesFromSpace(space.getMeta().getGuid().toString()).size() %>个服务实例</span> <i
									class="img icofont-plus-sign color-silver-dark helper-font-48"></i>
									<span class="b-btn-icon-right"> <span
										class="bg-silver-dark"> <i
											class="icofont-arrow-down helper-font-24 color-silver-dark"></i>
									</span>
								</span>
							</a></li>
							<li><a href="#" class="b-btn grd-white"> <span
									class="b-btn-slide-text color-silver-dark">1437 </span> <i
									class="img icofont-user-md color-silver-dark helper-font-48"></i>
									<span class="b-btn-icon-right"> <span> <i
											class="icofont-arrow-down helper-font-24 color-silver-dark"></i>
									</span>
								</span>
							</a></li>
						</ul>
						<div class="divider-content"><span></span></div>
						<div class="row-fluid">
							<div class="span12">
								<div class="box-tab corner-all">
									<div class="box-header corner-top">
										<ul class="nav nav-pills">
											<li class="active"><a href="#tabInfo"
												data-toggle="tab">空间信息概要</a></li>
											<li><a href="#tabTeamManager" data-toggle="tab">项目经理组</a></li>
											<li><a href="#tabTeamDeveloper" data-toggle="tab">项目开发组</a></li>
											<li><a href="#tabTeamTester" data-toggle="tab">项目测试组</a></li>
										</ul>
										<div class="box-body">
										<%
											DecimalFormat format = new DecimalFormat();
											format.setMaximumFractionDigits(1);
											format.setMinimumFractionDigits(0);
										%>
											<div class="tab-content">
												<div class="tab-pane active" id="tabInfo">
													<table class="table table-hover table-bordered">
														<tr>
															<td class="span2"><strong>空间名称</strong></td>
															<td><%=space.getName() %></td>
														</tr>
														<tr>
															<td class="span2"><strong>空间内存资源阀值</strong></td>
															<td><%=space.getOrganization().getQuota() == null ? 0 : format.format(space.getOrganization().getQuota().getMemoryLimit() / (1024 * 1024.0))  %></td>
														</tr>
														<tr>
															<td class="span2"><strong>空间绑定服务阀值</strong></td>
															<td><%=space.getOrganization().getQuota() == null ? 0 : space.getOrganization().getQuota().getTotalServices() %></td>
														</tr>
														<tr>
															<td class="span2"><strong>空间应用使用阀值</strong></td>
															<td><%=space.getOrganization().getQuota() == null ? 0 : space.getOrganization().getQuota().getTotalRoutes() %></td>
														</tr>
													</table>
												</div>
												<div class="tab-pane" id="tabTeamManager">
													<table class="table table-bordered table-striped autoTable">
														<thead>
															<tr>
																<th>项目经理小组用户名</th>
																<th>成员控制基础权限</th>
																<th>成员控制可读权限</th>
																<th>成员控制可写权限</th>
															</tr>
														</thead>
														<tbody>
														<%
															List<CloudUser> managers = client.getUsersBySpaceRole(space.getMeta().getGuid().toString(), "managers");
															Boolean memberlflag = false;
															Boolean writerflag = false;
															boolean readerflag = false;
															for (CloudUser manager : managers) {
																String managerId = manager.getMeta().getGuid().toString();
																memberlflag = client.isMemberByUserAndDisplayName(managerId, "cloud_controller.admin");
																readerflag = client.isReaderByUserAndDisplayName(managerId, "cloud_controller.admin");
																writerflag = client.isWriterByUserAndDisplayName(managerId, "cloud_controller.admin");
														%>
														<tr>
															<td><%=manager.getName() %></td>
															<td>
																<label class="checkbox">
                                                                    <input type="checkbox" data-form="uniform" name="inputCheckbox" id="inlineCheckbox1" 
                                                                    value="option1" <%=memberlflag ? "checked='checked'" : "" %> disabled="disabled"/>
                                                                </label>
                                                            </td>
															<td>
																<label class="checkbox">
                                                                    <input type="checkbox" data-form="uniform" name="inputCheckbox" id="inlineCheckbox1" 
                                                                    value="option1" <%=readerflag ? "checked='checked'" : "" %> disabled="disabled"/>
                                                                </label>
															</td>
															<td>
																<label class="checkbox">
                                                                    <input type="checkbox" data-form="uniform" name="inputCheckbox" id="inlineCheckbox1" 
                                                                    value="option1" <%=writerflag ? "checked='checked'" : "" %> disabled="disabled"/>
                                                                </label>
															</td>
														</tr>
														<%
															}
														%>
														</tbody>	
													</table>
												</div>
												<div class="tab-pane" id="tabTeamDeveloper">
													<table class="table table-bordered table-striped autoTable">
														<thead>
															<tr>
																<th>项目开发小组用户名</th>
																<th>成员控制基础权限</th>
																<th>成员控制可读权限</th>
																<th>成员控制可写权限</th>
															</tr>
														</thead>
														<tbody>
														<%
															List<CloudUser> developers = client.getUsersBySpaceRole(space.getMeta().getGuid().toString(), "developers");
															for (CloudUser developer : developers) {
																String developerId = developer.getMeta().getGuid().toString();
																memberlflag = client.isMemberByUserAndDisplayName(developerId, "cloud_controller.admin");
																readerflag = client.isReaderByUserAndDisplayName(developerId, "cloud_controller.admin");
																writerflag = client.isWriterByUserAndDisplayName(developerId, "cloud_controller.admin");
														%>
														<tr>
															<td><%=developer.getName() %></td>
															<td>
																<label class="checkbox">
                                                                    <input type="checkbox" data-form="uniform" name="inputCheckbox" id="inlineCheckbox1" 
                                                                    value="option1" <%=memberlflag ? "checked='checked'" : "" %> disabled="disabled"/>
                                                                </label>
                                                            </td>
															<td>
																<label class="checkbox">
                                                                    <input type="checkbox" data-form="uniform" name="inputCheckbox" id="inlineCheckbox1" 
                                                                    value="option1" <%=readerflag ? "checked='checked'" : "" %> disabled="disabled"/>
                                                                </label>
															</td>
															<td>
																<label class="checkbox">
                                                                    <input type="checkbox" data-form="uniform" name="inputCheckbox" id="inlineCheckbox1" 
                                                                    value="option1" <%=writerflag ? "checked='checked'" : "" %> disabled="disabled"/>
                                                                </label>
															</td>
														</tr>
														<%
															}
														%>
														</tbody>	
													</table>
												</div>
												<div class="tab-pane" id="tabTeamTester">
													<table class="table table-bordered table-striped autoTable">
														<thead>
															<tr>
																<th>项目测试小组用户名</th>
																<th>成员控制基础权限</th>
																<th>成员控制可读权限</th>
																<th>成员控制可写权限</th>
															</tr>
														</thead>
														<tbody>
														<%
															List<CloudUser> auditors = client.getUsersBySpaceRole(space.getMeta().getGuid().toString(), "auditors");
															for (CloudUser auditor : auditors) {
																String auditorId = auditor.getMeta().getGuid().toString();
																memberlflag = client.isMemberByUserAndDisplayName(auditorId, "cloud_controller.admin");
																readerflag = client.isReaderByUserAndDisplayName(auditorId, "cloud_controller.admin");
																writerflag = client.isWriterByUserAndDisplayName(auditorId, "cloud_controller.admin");
														%>
														<tr>
															<td><%=auditor.getName() %></td>
															<td>
																<label class="checkbox">
                                                                    <input type="checkbox" data-form="uniform" name="inputCheckbox" id="inlineCheckbox1" 
                                                                    value="option1" <%=memberlflag ? "checked='checked'" : "" %> disabled="disabled"/>
                                                                </label>
                                                            </td>
															<td>
																<label class="checkbox">
                                                                    <input type="checkbox" data-form="uniform" name="inputCheckbox" id="inlineCheckbox1" 
                                                                    value="option1" <%=readerflag ? "checked='checked'" : "" %> disabled="disabled"/>
                                                                </label>
															</td>
															<td>
																<label class="checkbox">
                                                                    <input type="checkbox" data-form="uniform" name="inputCheckbox" id="inlineCheckbox1" 
                                                                    value="option1" <%=writerflag ? "checked='checked'" : "" %> disabled="disabled"/>
                                                                </label>
															</td>
														</tr>
														<%
															}
														%>
														</tbody>	
													</table>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</section>

	<!-- javascript
        ================================================== -->
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
		src='<c:url value="/js/wysihtml5/wysihtml5-0.3.0.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/wysihtml5/bootstrap-wysihtml5.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/datatables/jquery.dataTables.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/datatables/DT_bootstrap.js"></c:url>'></script>
	<!-- this plugin required jquery ui-->

	<!-- required stilearn template js, for full feature-->
	<script type="text/javascript"
		src='<c:url value="/js/holder.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/stilearn-base.js"></c:url>'></script>

	<script type="text/javascript">
            $(document).ready(function() {
                // try your js
                
                // normalize event tab-stat, we hack something here couse the flot re-draw event is any some bugs for this case
                $('#tab-stat > a[data-toggle="tab"]').on('shown', function(){
                    if(sessionStorage.mode == 4){ // this hack only for mode side-only
                        $('body,html').animate({
                            scrollTop: 0
                        }, 'slow');
                    }
                });
                
                // peity chart
                $("span[data-chart=peity-bar]").peity("bar");
                
                // Input tags with select2
                $('input[name=reseiver]').select2({
                    tags:[]
                });
                
                // uniform
                $('[data-form=uniform]').uniform();
                
                // wysihtml5
                $('[data-form=wysihtml5]').wysihtml5()
                toolbar = $('[data-form=wysihtml5]').prev();
                btn = toolbar.find('.btn');
                
                $.each(btn, function(k, v){
                    $(v).addClass('btn-mini')
                });
            });
      
        </script>
</body>
</html>