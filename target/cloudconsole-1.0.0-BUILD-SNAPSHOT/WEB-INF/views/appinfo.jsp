<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.cloudfoundry.client.lib.domain.InstanceStats"%>
<%@page import="org.cloudfoundry.client.lib.domain.ApplicationStats"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@page import="org.cloudfoundry.client.lib.domain.CrashInfo"%>
<%@page import="org.cloudfoundry.client.lib.domain.CrashesInfo"%>
<%@page
	import="org.cloudfoundry.client.lib.domain.CloudApplication.DebugMode"%>
<%@page import="org.cloudfoundry.client.lib.domain.InstanceInfo"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudDomain"%>
<%@page import="org.cloudfoundry.client.lib.domain.InstancesInfo"%>
<%@page import="java.util.List"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudApplication"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudInfo"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudRoute"%>
<%@page import="org.cloudfoundry.client.lib.CloudFoundryClient"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%
	CloudFoundryClient client = (CloudFoundryClient) session.getAttribute("client");
	String appName = request.getParameter("name");
	CloudApplication app = client.getApplication(appName);
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
	href="<c:url value="/css/bootstrap-editable.css"/>" />
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
<script type="text/javascript">
	function doAction(type,appname,index){
		$.ajax({
			type:"GET",
			url:"deleteAppInstance",
			cache:"false",
			data:{
				type:type,
				appname:appname,
				index:index
			},
			complete : function(data, textStatus, jqXHR){
				if("error" == textStatus){
					var err =  data.responseText;
					var errorMsg = "<div class='alert alert-error'> " +  
				  				"<a class=\"close\" data-dismiss='alert'>*</a>"+  
				  				"<strong>Error!</strong>"+err+"</div>";  
					$(".container").prepend(errorMsg);
				}else{
					location.reload();
				}
			}
		});
	}
	</script>
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
						<li><a href="./spaceView" title="spaces">
								<div class="helper-font-24">
									<i class="icofont-edit"></i>
								</div> <span class="sidebar-text">租户空间</span>
						</a></li>
						<li>
                        	<a href="./securityView" title="spaces">
                            <div class="helper-font-24">
                            	<i class="icofont-umbrella"></i>
                            </div>
                            <span class="sidebar-text">安全组</span>
                            </a>
                         </li>
						<li class="active first"><a href="./appView" title="apps">
								<div class="helper-font-24">
									<i class="icofont-bar-chart"></i>
								</div> <span class="sidebar-text">应用管理</span>
						</a>
							<ul class="sub-sidebar corner-top shadow-silver-dark">
								<li><a href="./uploadApp" title="cluster monit">
										<div class="helper-font-24">
											<i class="icofont-warning-sign"></i>
										</div> <span class="sidebar-text">上传应用</span>
									</a>
								</li>
							</ul>
						</li>
						<li><a href="./domain" title="Routes">
								<div class="helper-font-24">
									<i class="icofont-table"></i>
								</div> <span class="sidebar-text">域名管理</span>
						</a></li>
						<li>
                                <a href="./services" title="ServiceMarket">
                                    <div class="helper-font-24">
                                        <i class="icofont-columns"></i>
                                    </div>
                                    <span class="sidebar-text">服务市场</span>
                                </a>
                        </li>
						<li><a href="./serviceGateway" title="ServiceGateway">
								<div class="helper-font-24">
									<i class="icofont-reorder"></i>
								</div> <span class="sidebar-text">服务网关</span>
						</a></li>
						<li>
                        	<a href="./eventView" title="spaces">
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
								<li><a href="./monit" title="cluster monit">
										<div class="helper-font-24">
											<i class="icofont-warning-sign"></i>
										</div> <span class="sidebar-text">集群状态</span>
								</a></li>
								<li><a href="./loadBalance" title="router loadbalance">
										<div class="helper-font-24">
											<i class="icofont-lock"></i>
										</div> <span class="sidebar-text">负载均衡</span>
								</a></li>
								<li><a href="./trafficView" title="traffice controller">
										<div class="helper-font-24">
											<i class="icofont-barcode"></i>
										</div> <span class="sidebar-text">流量控制</span>
								</a></li>
								<li><a href="./monitEvent" title="monit event">
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
						<ul class="content-header-action pull-right">
							<li><a href="#"> <span data-chart="peity-bar"
									data-height="32" data-colours='["#00A600", "#00A600"]'>5,3,9,6,5,9,7,3,5,2</span>
									<div class="action-text color-green">
										8765 <span class="helper-font-small color-silver-dark">访问数量</span>
									</div>
							</a></li>
							<li class="divider"></li>
							<li><a href="#"> <span data-chart="peity-bar"
									data-height="32" data-colours='["#00A0B1", "#00A0B1"]'>9,7,9,6,3,5,3,5,5,2</span>
									<div class="action-text color-teal">
										1437 <span class="helper-font-small color-silver-dark">用户数量</span>
									</div>
							</a></li>
							<li class="divider"></li>
							<li><a href="#"> <span data-chart="peity-bar"
									data-height="32" data-colours='["#BF1E4B", "#BF1E4B"]'>6,5,9,7,3,5,2,5,3,9</span>
									<div class="action-text color-red">
										4367 <span class="helper-font-small color-silver-dark">应用数量</span>
									</div>
							</a></li>
						</ul>
						<h2>
							<i class="icofont-home"></i> 云应用实例管理 <small>Application
								Manager</small>
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
							<li><a href="./home"><i class="icofont-home"></i>Dashboard</a>
								<span class="divider">&rsaquo;</span></li>
							<li><a href="./appView">应用列表</a><span class="divider">&rsaquo;</span></li>
							<li class="active"><%=app.getName()%></li>
						</ul>
						<!--/breadcrumb-->
					</div>
					<!-- /content-breadcrumb -->
					<!-- /content-breadcrumb -->
					<div class="content-body">
						<div class="row-fluid">
							<div class="span12">
								<div class="box-tab corner-all">
									<div class="box-header corner-top">
										<ul class="nav nav-pills">
											<li class="active"><a href="#tabResources"
												data-toggle="tab">参数配置</a></li>
											<li><a href="#tabInstances" data-toggle="tab">应用资源监控</a></li>
											<li><a href="#tabCrashes" data-toggle="tab">域名管理</a></li>
											<li><a href="#tabEnv" data-toggle="tab">运行环境</a></li>
											<li><a href="#tabServices" data-toggle="tab">代码管理</a></li>
											<li><a href="#tabDownloadApp" data-toggle="tab">下载应用</a></li>
										</ul>
										<div class="box-body">
											<div class="tab-content">
												<div class="tab-pane active" id="tabResources">
													<table class="table table-hover table-bordered">
														<tr>
															<td class="span2"><strong>名称</strong></td>
															<td><a href="#" id="name" data-url="appOperation"
																data-value="<%=app.getName()%>"
																data-original-title="input new name" data-type="text"
																data-pk="<%=app.getName()%>"><%=app.getName()%></a></td>
														</tr>
														<tr>
															<td><strong>状态</strong></td>
															<td><%=app.getState().name()%></td>
														</tr>
														<tr>
															<td><strong>实例</strong></td>
															<td
																title="Running:<%=app.getRunningInstances()%>&#10;AllInstance:<%=app.getInstances()%>"><a
																href="#" id="instances" data-url="appOperation.do"
																data-value="<%=app.getInstances()%>"
																data-original-title="input instances count"
																data-type="text" data-pk="<%=app.getName()%>"><%=app.getRunningInstances() + "/" + app.getInstances()%></a></td>
														</tr>
														<tr>
															<td><strong>磁盘</strong></td>
															<td><%=app.getResources().get("disk_quota")%></td>
														</tr>
														<tr>
															<%
															String memoryData = "";
																							int[] memoryChoices = {128,256,512,1024};
																							for (int memoryChoice : memoryChoices) {
																								String tmp = "{value:" + memoryChoice + ",text:'" + memoryChoice + "'}";
																								if (StringUtils.isNotBlank(memoryData)) {
																									memoryData = memoryData + "," + tmp;
																								} else {
																									memoryData = tmp;
																								}
																							}
														%>
															<td><strong>内存(MB)</strong></td>
															<td><a id="memory" href="#" data-url="appOperation"
																data-value="<%=app.getMemory()%>" data-type="select"
																data-source="[<%=memoryData%>]"
																data-pk="<%=app.getName()%>"
																data-original-title="Select Memory"><%=app.getMemory()%></a></td>
														</tr>
														<tr>
															<td><strong>架构</strong></td>
															<td><%=client.getApplication(appName).getStaging().getBuildpackUrl()%></td>
														</tr>
														<tr>
															<td><strong>执行命令</strong></td>
															<td><%=client.getApplication(appName).getStaging().getCommand()%></td>
														</tr>
													</table>
												</div>
												<div class="tab-pane" id="tabInstances">
													<table class="table table-hover table-bordered  autoTable">
														<thead>
															<tr>
																<th>实例</th>
																<th>运行状态</th>
																<th>IP地址</th>
																<th>实例端口</th>
																<th>CPU(核心数)</th>
																<th>磁盘使用/Limit(MB)</th>
																<th>内存使用/Limit(MB)</th>
																<th>运行时间/时：分:秒</th>
																<th>编译日志</th>
																<th>运行时日志</th>
																<th>停止实例</th>
																<th>代码</th>
															</tr>
														</thead>
														<tbody>
															<%
															DecimalFormat format = new DecimalFormat();
																					format.setMaximumFractionDigits(1);
																					format.setMinimumFractionDigits(0);

																					ApplicationStats applicationStats = client.getApplicationStats(appName);
																					List<InstanceStats> instanceStats = applicationStats.getRecords();
																					for (InstanceStats info : instanceStats) {
															%>
															<tr>
																<td><%=info.getId()%></td>
																<td><%=info.getState()%></td>
																<td><%=info.getHost()%></td>
																<td><%=info.getPort()%></td>
																<td><%=info.getUsage() == null ? 0 : info.getUsage().getCpu()%>%(<%=info.getCores()%>)</td>
																<td><%=info.getUsage() == null ? 0 : format.format(info.getUsage().getDisk() / (1024 * 1024.0))%>/<%=format.format(info.getDiskQuota() / (1024 * 1024.0))%></td>
																<td><%=info.getUsage() == null ? 0 : format.format(info.getUsage().getMem() / (1024 * 1024.0))%>/<%=format.format(info.getMemQuota() / (1024 * 1024.0))%></td>
																<td>
																<%
																	Double d = info.getUptime();
																	int theSecond = d.intValue();
																	int h = 0;
																	int m = 0;
																	int s = 0;
																	h = (int) Math.floor(theSecond / 3600);
																	if (h > 0) {
																		m = (int) Math.floor((theSecond - h * 3600) / 60);
																		if (m > 0) {
																			s = theSecond - h * 3600 - m * 60;
																		} else {
																			s = theSecond - h * 3600;
																		}
																	} else {
																		m = (int) Math.floor(theSecond / 60);
																		if (m > 0) {
																			s = theSecond - m * 60;
																		} else {
																			s = theSecond;
																		}
																	}
																%>
																<%=h %>:<%=m %>:<%=s %>
																</td>
																<td>
																	<a data-toggle="modal" href="log?name=<%=appName%>&instance=<%=info.getId()%>" data-target="#logModal" role="button" class="btn btn-info">查看日志</a>
																	<!-- Modal -->
                                                                    <div class="modal fade" id="logModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                                    	<div class="modal-dialog">
                                                                    		<div class="modal-content">
            																	<div class="modal-header">
                																	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                 																	<h4 class="modal-title">应用编译日志查询</h4>

            																	</div>
            																	<div class="modal-body"><div class="te"></div></div>
            																	<div class="modal-footer">
                																	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            																	</div>
        																	</div>
        																	<!-- /.modal-content -->
    																	</div>
    																	<!-- /.modal-dialog -->
																	</div>
																	<!-- /.modal -->
																</td>
																<!-- runtime log -->
																<td>
																	<a data-toggle="modal" href="recentLog?name=<%=appName%>&instance=<%=info.getId()%>" data-target="#runlogModal" role="button" class="btn btn-info">运行日志</a>
																	<!-- Modal -->
                                                                    <div class="modal fade" id="runlogModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                                    	<div class="modal-dialog">
                                                                    		<div class="modal-content">
            																	<div class="modal-header">
                																	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                 																	<h4 class="modal-title">应用运行日志查询</h4>
            																	</div>
            																	<div class="modal-body" id="content" ><div class="runlog"></div></div>
            																	<div class="modal-footer">
                																	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            																	</div>
        																	</div>
        																	<!-- /.modal-content -->
    																	</div>
    																	<!-- /.modal-dialog -->
																	</div>
																	<!-- /.modal -->
																</td>
																<td width="65">
																	<a href="#" onclick="if(confirm('确定你要停止应用[<%=appName%>]的实例?')){doAction('terminate','<%=appName %>','<%=info.getId()%>')}"><button class="btn btn-small"><i class="icon-trash"></i></button></a>
																</td>
																<td>
																	<a href="appCodeView?name=<%=appName%>&instance=<%=info.getId()%>"><button class="btn btn-small" title="查看代码"><i class="icon-folder-open"></i></button></a>
																</td>
															</tr>
															<%
															}
														%>
														</tbody>
													</table>
													<div id="instance_mem" style="height: 400px" class="span5">
														<input type="hidden" id="appInstance_mem" name="appInstance_mem" value=<%=appName %> />
													</div>
													<div class="span1"></div>
													<div id="instance_cpu" style="height: 400px" class="span5">
														<input type="hidden" id="appInstance_cpu" name="appInstance_cpu" value=<%=appName %> />
													</div>
												</div>
												<div class="tab-pane" id="tabCrashes">
													<div class="box-tab corner-all">
														<div class="tabbable tabs-left">
															<ul class="nav nav-tabs">
																<li class="active"><a data-toggle="tab" href="#uri-left-1"><strong>路由列表</strong></a></li>
																<li><a data-toggle="tab" href="#uri-left-2"><strong>绑定路由</strong></a></li>
																<li><a data-toggle="tab" href="#uri-left-3"><strong>添加路由</strong></a></li>										
															</ul>
															<div class="tab-content">
																<div class="tab-pane fade in active" id="uri-left-1">
																	<div class="page-header">
																		<div class="pull-right"></div>
                                    							 		<h3>路由列表<small> Application URI</small></h3>
																	</div>
																	<table class="table table-bordered table-striped">
																		<thead>
																		<tr>
																			<th class="span2">个数</th>
																			<th>域名</th>
																			<th>解除绑定</th>
																		</tr>
																		</thead>
																		<tbody>
																		<%
																			List<String> uri = client.getApplication(appName).getUris();
																			for(int i=0;i<uri.size();i++){
																		%>
																		<tr>
																			<td><%=i%></td>
																			<td><a href="http://<%=uri.get(i)%>" target="_blank"><%=uri.get(i)%></a></td>
																			<td width="65" style="text-align:center"> 
																				<a href="unbindAppUrl?name=<%=appName %>&uri=<%=uri.get(i)%>"><button class="btn btn-small" title="解除绑定"><i class="icon-eye-close"></i></button></a>
																			</td>
																		</tr>
																		<%
																			}
																		%>
																		</tbody>
																	</table>
																</div>
																<div class="tab-pane fade" id="uri-left-2">
																	<div class="page-header">
																		<div class="pull-right"></div>
                                    							 		<h3>绑定路由<small> Bind Already URI</small></h3>
																	</div>
																	<div class="span6">
																		<form action="bindAppUrl" method="post" class="form-horizontal">
																			<fieldset>
																			<div class="control-group">
																				<label class="control-label" for="appName" ><strong>被绑定应用：</strong></label>
                                   												<div class="controls">
                                                                					<input type="text" id="name" name="name" class="grd-white" value=<%=appName %> readonly="readonly"/>
                                                            					</div>
																			</div>
																			<div class="control-group">
																				<label class="control-label" for="uris" ><strong>绑定实例URI：</strong></label>
                                   												<div class="controls">
                                   													<select id="uris" data-form="select2" name="uris"
                                           											style="width:220px" data-placeholder="Bing Running App Uri" multiple="multiple">
                                           											<%
                                           												List<CloudDomain> domains = client.getDomains();
                                           												for (CloudDomain domain : domains) {
                                           													String domainName = domain.getName();
                                           												
                                           											%>
                                           												<optgroup label=<%=domainName %>>
                                           												<%
                                           													List<CloudRoute> domainRoutes = client.getRoutes(domainName);
                                           													List<CloudRoute> runningRoutes = new ArrayList<CloudRoute>();
                                           													for (CloudRoute domainRoute : domainRoutes) {
                                           														if (domainRoute.inUse()) {
                                           															runningRoutes.add(domainRoute);
                                           														}
                                           													}
                                           													List<CloudRoute> notSelfRoute = new ArrayList<CloudRoute>();
                                           													List<String> appUris = client.getApplication(appName).getUris();
                                           													for (CloudRoute runningRoute : runningRoutes) {
                                           														Boolean exist = false;
                                           														for (String appUri : appUris) {
                                           															if (appUri.equals(runningRoute.getName())) {
                                           																exist = true;
                                           															}
                                           														}
                                           														if (exist == false) {
                                           															notSelfRoute.add(runningRoute);
                                           														}
                                           													}
                                           													for (CloudRoute route : notSelfRoute) {
                                           												%>
                                           													<option value=<%=route.getName() %>><%=route.getName() %></option>
                                           												<%
                                           													}
                                           												%>
                                           												</optgroup>
                                           											<%
                                           												}
                                           											%>
                                           											</select>
                                                            					</div>
																			</div>
																			<div class="form-actions">
                                                            					<button type="submit" class="btn btn-primary">保存设置</button>
                                   												<button type="button" class="btn">取消设置</button>
                                                    						</div>
																			</fieldset>
																		</form>
																	</div>
																	<div class="span5">
																		<p><font size="3"><strong>灰度上线说明</strong></font></p>
																		<p>当我们需要对其中一个应用不停止的时候发布新的产品时，需要重新创建一个应用，这个应用是在原来应用基础上的版本叠加，这时候只需要绑定上一个版本的路由，两个版本的应用将被路由同时发现，并负载的分配这两个版本的实例，等当前版本稳定后，先解除绑定之前版本的路由，然后所有流量将会负载到现在的应用实例上，最后去掉当前版本的临时路由，只留下默认路由。</p>
																		<p><font size="3"><strong>上线步骤：</strong></font></p>
																		
																		<ul>
																			<li>Step 1: 上传一个应用假设为Blue,Route为risk.cloud.io</li>
																			<li>Step 2: 上传迭代版本应用假设为Green,Route为temp-risk.cloud.io</li>
																			<li>Step 3: 添加绑定Green的路由为risk.cloud.io,这时候Green有两条路由：risk.cloud.io,temp-risk.cloud.io</li>
																			<li>Step 4: Green版本稳定后,解除Blue的路由绑定</li>
																			<li>Step 5: 如果有必要可以删除Blue,也可以留作版本回滚,操作类似</li>
																		</ul>
																		
																	</div>
																</div>
																<div class="tab-pane fade" id="uri-left-3">
																	<div class="page-header">
																		<div class="pull-right"></div>
                                    							 		<h3>添加路由<small> Add New URI</small></h3>
																	</div>
																	<div class="span11">
																		<form action="addAppUrl" method="post" class="form-horizontal">
																			<fieldset>
																			<div class="control-group">
																				<label class="control-label" for="appName" ><strong>应用名称：</strong></label>
                                   												<div class="controls">
                                                                					<input type="text" id="name" name="name" class="grd-white" value=<%=appName %> readonly="readonly"/>
                                                            					</div>
																			</div>
																			<div class="control-group">
																				<label class="control-label" for="inputAuto">新的域名：</label>
																				<div class="controls">
																					<input type="text" id="host" name="host"
																					class="grd-white" required="required" /> 
																					<span class="add-on">.</span> <select id="subdomain"
																					name="subdomain" data-form="select2"
																					style="width: 180px" data-placeholder="选择您需要的域名">
																				<%
																					for(CloudDomain clouddomain:domains){
																				%>
																					<option><%=clouddomain.getName() %></option>
																				<%
																					}
																				%>
																					</select>
																				</div>
																			</div>
																			<div class="form-actions">
                                                            					<button type="submit" class="btn btn-primary">保存设置</button>
                                   												<button type="button" class="btn">取消设置</button>
                                                    						</div>
																			</fieldset>
																		</form>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>

												<div class="tab-pane" id="tabEnv">
													<table class="table table-hover table-bordered  autoTable">
														<thead>
															<tr>
																<th class="span2">名称</th>
																<th>结果</th>
															</tr>
														</thead>
														<tbody>
															<%
															Map<String, String> envMap = app.getEnvAsMap();
																				Iterator<Entry<String, String>> iter = envMap.entrySet().iterator();
																				while (iter.hasNext()) {
																					Entry<String, String> entry = iter.next();
														%>
															<tr>
																<td><%=entry.getKey()%></td>
																<td><%=entry.getValue()%></td>
															</tr>
															<%
															}
														%>
														</tbody>
													</table>
												</div>
												<div class="tab-pane" id="tabServices">
													<div class="file-box">
														<form action="reUploadApp.do?name=<%=app.getName()%>"
															enctype="multipart/form-data" method="post">
															<input type="hidden" id="newF" name="newF" value="">
															<div class="control-group">
																<label class="control-label" for="inputUpload">请将新代码上传,如果是war请上传war包，其它请上传zip格式文件</label>
																<div class="controls">
																	<input type="file" data-form="uniform" id="newfile" />
																</div>
															</div>
															<br> <input type="submit" name="submit"
																class="btn btn-success" value="上传新代码" />
														</form>
													</div>
													<br> <br>
												</div>
												<div class="tab-pane" id="tabDownloadApp">
													<a href="appDownload?name=<%=appName%>"><button type="button" class="btn btn-success">下载应用</button></a>
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



	<!-- section footer
	<footer>
		<a rel="to-top" href="#top"><i class="icofont-circle-arrow-up"></i></a>
	</footer>
	-->

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
		src='<c:url value="/js/knob/jquery.knob.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/flot/jquery.flot.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/flot/jquery.flot.resize.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/flot/jquery.flot.categories.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/wysihtml5/wysihtml5-0.3.0.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/wysihtml5/bootstrap-wysihtml5.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/datatables/DT_bootstrap.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
	<script type="text/javascript"
		src="<c:url value="/js/bootstrap-editable.js" />"></script>
	<script type="text/javascript"
		src="<c:url value="/js/highcharts/highcharts.js" />"></script>
	<!-- this plugin required jquery ui-->

	<!-- required stilearn template js, for full feature-->
	<script type="text/javascript"
		src='<c:url value="/js/holder.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/stilearn-base.js"></c:url>'></script>
		

	<!-- script jquery -->
	<script>
	$.fn.editable.defaults.mode = 'popup';
	$(function() {
		$.each($(".autoEdit"), function(index, value) {
			$(value).editable();
		});

		var callback = function(data, config) {
			var res = eval('(' + data + ')');
			if (!res.success) {
				var errorMsg = "<div class='alert alert-error'> "
						+ "<a class=\"close\" data-dismiss='alert'>close</a>"
						+ "<strong>Error!</strong>" + res.msg + "</div>";
				$("#tabResources").prepend(errorMsg);
			}
		};

		$("#name").editable({
			success : callback
		});

		$("#instances").editable({
			success : callback
		});

		$('#memory').editable({
			success : callback
		});
	});
	</script>

	<script type="text/javascript">
	$('body').on('hidden', '.modal', function () {
		$(this).removeData('modal');
	});
	var name = $("#appInstance_mem").attr("value");
	 function sleep(n)   
     {   
         var start=new Date().getTime();   
         while(true){  
        	 if(new Date().getTime()-start>n){  
        		 break; 
        	 }
         }
     }
	
	$(document).ready(function() {
		Highcharts.setOptions({
	        global: {
	            useUTC: false
	        }
	    });
		window.chart = new Highcharts.Chart({
			series : (function() {
	        	var datas;
	        	$.ajax({
                	type: "POST",
                	url: "appInstanceMemView",
                	cache: false,
                	async: false,
                	data: {
                		name: name
                	},
                	dataType: "json",
                	success: function(data){
                		datas = data;
                	}
	        	});
	        	return datas;
	        }()),
			chart: {
		    	renderTo: 'instance_mem',
	    		events: {
	                load: function() {
	                    var series = this.series;
	                    setInterval(function() {
	                    	$.ajax({
	                        	type: "POST",
	                        	url: "appInstanceMemView",
	                        	cache: false,
	                        	data: {
	                        		name: name
	                        	},
	                        	dataType: "json",
	                        	success: function(data){  
	                        		if (series.length==data.length) {
	                        			$.each(data, function(index,item){
		                        			if (series.length == 0) {
		                        				this.series = data;
		                        			}else{
		                        				for (var i = 0; i <= series.length-1; i++) {
		                        					if (series[i].name == item.name) {
		                        						var x = item.data[0][0];
														var y = item.data[0][1];
		                        						if (i==data.length-1) {
		                        							series[i].addPoint([x, y], true, false);
		                        						}else{
		                        							series[i].addPoint([x, y], false, false);
		                        						}	                        						
		                        					}
		                        				}
		                        			}
		                        		});
	                        		}else{
	                        			//添加
	                        			var serieses = series;
	                        			if (series.length < data.length) {
	                        				$.each(data, function(index,item){
	                        					var exist = false;
	                        					for (var i = 0; i <= serieses.length-1; i++) {
	                        						if (series[i].name == item.name) {
	                        							exist = true;
	                        							var x = item.data[0][0];
														var y = item.data[0][1];
	                        							series[i].addPoint([x, y], false, false);
	                        						}
	                        					}
	                        					if (!exist) {
	                        						var chart = $('#instance_mem').highcharts();
	                        						chart.addSeries({
	                        							name : item.name,
	                        							data : item.data
	                        						});
	                        					}
	                        				});
	                        			};
	                        			//删除
	                        			if (series.length > data.length) {
	                        				var seriesList = series;
	                        				for (var i = 0; i <= seriesList.length-1; i++) {
	                        					var exist = false;
	                        					$.each(data, function(index,item){
	                        						if (series[i].name == item.name) {
	                        							exist = true;
	                        							var x = item.data[0][0];
														var y = item.data[0][1];
	                        							series[i].addPoint([x, y], false, false);
	                        						}
	                        					});
	                        					if (!exist) {
	                        						series[i].remove();
	                        					}
	                        				};
	                        			};
	                        		}	                        		
	                        	}
	                        });	                        
	                    }, 10000);
	                }
	            }
			},
			credits:{//去水印
				enabled: false
			},
			title: {
	            text: '应用实例内存监控',
	            x: -20 //center
	        },
	        subtitle: {
	            text: 'Cloud App Memory Monit',
	            x: -20
	        },
	        xAxis: {
	        	type: 'datetime',
	        	labels : {
	        		rotation:80
	        	}
	        },
	        yAxis: {
	            title: {
	                text: '内存占用 (M)'
	            },
	            plotLines: [{
	                value: 0,
	                width: 1,
	                color: '#808080'
	            }]
	        },
	        tooltip: {
	            valueSuffix: 'M'
	        },
	        legend: {
	            layout: 'vertical',
	            align: 'right',
	            verticalAlign: 'left',
	            borderWidth: 0
	        }
		});
		//CPU记录仪
		window.chart = new Highcharts.Chart({
			series : (function() {
	        	var datas;
	        	$.ajax({
                	type: "POST",
                	url: "appInstanceCPUView",
                	cache: false,
                	async: false,
                	data: {
                		name: name
                	},
                	dataType: "json",
                	success: function(data){
                		datas = data;
                	}
	        	});
	        	return datas;
	        }()),
			chart: {
		    	renderTo: 'instance_cpu',
	    		events: {
	                load: function() {
	                    var series = this.series;
	                    setInterval(function() {
	                    	$.ajax({
	                        	type: "POST",
	                        	url: "appInstanceCPUView",
	                        	cache: false,
	                        	data: {
	                        		name: name
	                        	},
	                        	dataType: "json",
	                        	success: function(data){  
	                        		if (series.length==data.length) {
	                        			$.each(data, function(index,item){
		                        			if (series.length == 0) {
		                        				series = data;
		                        			}else{
		                        				for (var i = 0; i <= series.length-1; i++) {
		                        					if (series[i].name == item.name) {
		                        						var x = item.data[0][0];
														var y = item.data[0][1];
		                        						if (i==data.length-1) {
		                        							series[i].addPoint([x, y], true, false);
		                        						}else{
		                        							series[i].addPoint([x, y], false, false);
		                        						}	                        						
		                        					}
		                        				}
		                        			}
		                        		});
	                        		}else{
	                        			//添加
	                        			if (series.length < data.length) {
	                        				var serieses = series;
	                        				$.each(data, function(index,item){
	                        					var exist = false;
	                        					for (var i = 0; i <= serieses.length-1; i++) {
	                        						if (series[i].name == item.name) {
	                        							exist = true;
	                        							var x = item.data[0][0];
														var y = item.data[0][1];
	                        							series[i].addPoint([x, y], false, false);
	                        						}
	                        					}
	                        					if (!exist) {
	                        						var chart = $('#instance_cpu').highcharts();
	                        						chart.addSeries({
	                        							name : item.name,
	                        							data : item.data
	                        						});
	                        					}
	                        				});
	                        			};
	                        			//删除
	                        			if (series.length > data.length) {
	                        				var seriesList = series;
	                        				for (var i = 0; i <= seriesList.length-1; i++) {
	                        					var exist = false;
	                        					$.each(data, function(index,item){
	                        						if (series[i].name == item.name) {
	                        							exist = true;
	                        							var x = item.data[0][0];
														var y = item.data[0][1];
	                        							series[i].addPoint([x, y], false, false);
	                        						}
	                        					});
	                        					if (!exist) {
	                        						series[i].remove();
	                        					}
	                        				};
	                        			};
	                        		}	                        		
	                        	}
	                        });	                        
	                    }, 10000);
	                }
	            }
			},
			credits:{//去水印
				enabled: false
			},
			title: {
	            text: '应用实例CPU监控',
	            x: -20 //center
	        },
	        subtitle: {
	            text: 'Cloud App CPU Monit',
	            x: -20
	        },
	        xAxis: {
	        	type: 'datetime',
	        	labels : {
	        		rotation:80
	        	}
	        },
	        yAxis: {
	            title: {
	                text: 'CPU (%)'
	            },
	            plotLines: [{
	                value: 0,
	                width: 1,
	                color: '#808080'
	            }]
	        },
	        tooltip: {
	            valueSuffix: '%'
	        },
	        legend: {
	            layout: 'vertical',
	            align: 'right',
	            verticalAlign: 'left',
	            borderWidth: 0
	        }
		});
		
		
		// normalize event tab-stat, we hack something here couse the flot re-draw event is any some bugs for this case
		$('#tab-stat > a[data-toggle="tab"]').on('shown',
				function() {
					if (sessionStorage.mode == 4) { // this hack only for mode side-only
						$('body,html').animate({
							scrollTop : 0
						}, 'slow');
					}
				});

		// peity chart
		$("span[data-chart=peity-bar]").peity("bar");

		$('[data-form=select2]').select2();
		
              $('[data-form=select2-group]').select2();
              
		// Input tags with select2
		$('input[name=reseiver]').select2({
			tags : []
		});

		// uniform
		$('[data-form=uniform]').uniform();

		// wysihtml5
		$('[data-form=wysihtml5]').wysihtml5()
		toolbar = $('[data-form=wysihtml5]').prev();
		btn = toolbar.find('.btn');

		$.each(btn, function(k, v) {
			$(v).addClass('btn-mini')
		});

		// Server stat circular by knob
		$("input[data-chart=knob]").knob();

		// system stat flot
		d1 = [ [ 'jan', 231 ], [ 'feb', 243 ],
				[ 'mar', 323 ], [ 'apr', 352 ],
				[ 'maj', 354 ], [ 'jun', 467 ],
				[ 'jul', 429 ] ];
		d2 = [ [ 'jan', 87 ], [ 'feb', 67 ], [ 'mar', 96 ],
				[ 'apr', 105 ], [ 'maj', 98 ],
				[ 'jun', 53 ], [ 'jul', 87 ] ];
		d3 = [ [ 'jan', 34 ], [ 'feb', 27 ], [ 'mar', 46 ],
				[ 'apr', 65 ], [ 'maj', 47 ],
				[ 'jun', 79 ], [ 'jul', 95 ] ];

		var visitor = $("#visitor-stat"), order = $("#order-stat"), user = $("#user-stat"),

		data_visitor = [ {
			data : d1,
			color : '#00A600'
		} ], data_order = [ {
			data : d2,
			color : '#2E8DEF'
		} ], data_user = [ {
			data : d3,
			color : '#DC572E'
		} ],

		options_lines = {
			series : {
				lines : {
					show : true,
					fill : true
				},
				points : {
					show : true
				},
				hoverable : true
			},
			grid : {
				backgroundColor : '#FFFFFF',
				borderWidth : 1,
				borderColor : '#CDCDCD',
				hoverable : true
			},
			legend : {
				show : false
			},
			xaxis : {
				mode : "categories",
				tickLength : 0
			},
			yaxis : {
				autoscaleMargin : 2
			}

		};

		// render stat flot
		$.plot(visitor, data_visitor, options_lines);
		$.plot(order, data_order, options_lines);
		$.plot(user, data_user, options_lines);

		// tootips chart
		function showTooltip(x, y, contents) {
			$(
					'<div id="tooltip" class="bg-black corner-all color-white">'
							+ contents + '</div>').css({
				position : 'absolute',
				display : 'none',
				top : y + 5,
				left : x + 5,
				border : '0px',
				padding : '2px 10px 2px 10px',
				opacity : 0.9,
				'font-size' : '11px'
			}).appendTo("body").fadeIn(200);
		}

		var previousPoint = null;
		$('#visitor-stat, #order-stat, #user-stat')
				.bind(
						"plothover",
						function(event, pos, item) {

							if (item) {
								if (previousPoint != item.dataIndex) {
									previousPoint = item.dataIndex;

									$("#tooltip").remove();
									var x = item.datapoint[0]
											.toFixed(2), y = item.datapoint[1]
											.toFixed(2);
									label = item.series.xaxis.ticks[item.datapoint[0]].label;

									showTooltip(item.pageX,
											item.pageY,
											label + " = "
													+ y);
								}
							} else {
								$("#tooltip").remove();
								previousPoint = null;
							}

						});
		// end tootips chart
	});
	</script>
</body>
</html>