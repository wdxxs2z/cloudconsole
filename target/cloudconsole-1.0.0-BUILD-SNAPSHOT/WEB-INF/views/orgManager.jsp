<%@page import="org.cloudfoundry.client.lib.domain.CloudOrganization"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudInfo"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudOrganization"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudSpace"%>
<%@page import="org.cloudfoundry.client.lib.CloudFoundryClient"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudApplication"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudDomain"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudUser"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudSpaceQuota"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
<%
	CloudFoundryClient client = (CloudFoundryClient) session.getAttribute("client");
	String orgName = request.getParameter("orgName");
	CloudOrganization organization = client.getOrgByName(orgName, true);
%>
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
<link rel="stylesheet" href="<c:url value="/css/bootstrap-responsive.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/stilearn.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/stilearn-responsive.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/stilearn-helper.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/stilearn-icon.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/font-awesome.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/animate.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/uniform.default.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/DT_bootstrap.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/select2.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/bootstrap-wysihtml5.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/responsive-tables.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/datepicker.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/colorpicker.css"/>" />
<link href="<c:url value="/css/google-css.css"/>" rel="stylesheet" type="text/css" />

<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<script type="text/javascript">
	function doDelete(spaceQuotaName){
		$.ajax({
			type:"GET",
			url:"spaceQuotaOperation",
			cache:"false",
			data:{
				spaceQuotaName:spaceQuotaName
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
	
	<section class="section">
		<div class="row-fluid">
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
						<li><a href="./organization"
							title="Organizations">
								<div class="helper-font-24">
									<i class="icofont-magnet"></i>
								</div> <span class="sidebar-text">租户管理</span>
						</a>
							<ul class="sub-sidebar corner-top shadow-silver-dark">
								<li><a href="./orgManager" title="组织管理">
										<div class="helper-font-24">
											<i class="icofont-warning-sign"></i>
										</div> <span class="sidebar-text">管理组织</span>
								</a></li>
								<li><a href="./quotaManager" title="资源配额管理">
										<div class="helper-font-24">
											<i class="icofont-warning-sign"></i>
										</div> <span class="sidebar-text">配额管理</span>
								</a></li>
							</ul>
						</li>
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
								<li><a href="/bonus-page/resume/index.html" title="resume">
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
							<i class="icofont-home"></i> Cloud Space <small>管理-manager Space</small>
						</h2>
					</div>
					<!-- /content-header -->
					<div class="content-breadcrumb">
						<ul class="breadcrumb-nav pull-right">
							<li class="divider"></li>
						</ul>
						<ul class="breadcrumb">
							<li><a href="./home"><i class="icofont-home"></i>
									Dashboard</a> <span class="divider">&rsaquo;</span></li>
							<li><a href="./organization">数据中心-<%=orgName %></a> <span class="divider">&rsaquo;</span></li>
							<li class="active">Space-空间统一管理</li>
						</ul>
					</div>
					
					<div class="content-body">
						<div class="row-fluid">
							<div class="span12">
								<div class="box corner-all">
												<!--box tab-->
												<div class="box-tab corner-all">
													<div class="tabbable tabs-left">				
														<ul class="nav nav-tabs">
															<!--tab menus-->
															<li class="active"><a data-toggle="tab"
																href="#<%=orgName %>-left-1"><strong>组织空间</strong></a></li>
															<li><a data-toggle="tab"
															href="#<%=orgName %>-left-2"><strong>创建空间</strong></a></li>
															<li><a data-toggle="tab" 
															href="#<%=orgName %>-left-3"><strong>组织域名</strong></a></li>
															<li><a data-toggle="tab" 
															href="#<%=orgName %>-left-4"><strong>中心成员</strong></a></li>
															<li><a data-toggle="tab" 
															href="#<%=orgName %>-left-5"><strong>空间配额</strong></a></li>
														</ul>
														<!-- widgets-tab-body -->
														<div class="tab-content">
															<div class="tab-pane fade in active" id="<%=orgName %>-left-1">
															<div class="page-header">
                                    							 <div class="pull-right"></div>
                                    							 <h3>数据中心空间概要<small>Space Information</small></h3>
                                							</div>
																<table class="table table-bordered table-striped">
																	<thead>
																	<tr>
																		<th>空间名称</th>
																		<th>空间APP启动个数</th>
																		<th>空间APP停止个数</th>
																		<th>空间APP就为个数</th>
																		<th>绑定服务实例个数</th>
																		<th>占用资源(内存)</th>
																		<th>被分配空间配额</th>
																	<tr>
																	</thead>
																	<tbody>
																	<%
																		List<CloudSpace> spaces = client.getSpaceFromOrgName(orgName);
																		for (CloudSpace space : spaces) {
																			List<CloudApplication> apps = client.getAppsFromSpaceName(space.getMeta().getGuid().toString());
																			int startNum = 0;
																			int stopNum = 0;
																			int spendNum = 0;
																			int serviceBindNum = 0;
																			for (CloudApplication app : apps) {
																				if (app.getState().name().equalsIgnoreCase("STARTED")){
																					startNum = startNum + 1;
																				}
																				if (app.getState().name().equalsIgnoreCase("STOPPED")) {
																					stopNum = stopNum + 1;
																				}
																				if (app.getState().name().equalsIgnoreCase("UPDATING")) {
																					spendNum = spendNum + 1;
																				}
																				if (app.getServices() != null) {
																					serviceBindNum = app.getServices().size() + serviceBindNum;
																				}
																			}																				
																	%>
																	<tr>
																		<td><a href="spaceView?spaceGuid=<%=space.getMeta().getGuid().toString()%>&orgName=<%=orgName%>"><%=space.getName()%></a></td>
																		<td><%=startNum %></td>
																		<td><%=stopNum %></td>
																		<td><%=spendNum %></td>
																		<%
																			List<CloudSpaceQuota> spaceQuotaList = client.getSpaceQuotaWithSpace(space.getName(), orgName);
																			if(spaceQuotaList.size()!=0){
																		%>
																		<td><%=spaceQuotaList.get(0).getTotalServices() %></td>
																		<td><%=spaceQuotaList.get(0).getMemoryLimit() %></td>
																		<td><%=client.getSpaceQuotaWithSpace(space.getName(), orgName).get(0).getName() %></td>
																		<%
																			}else{
																		%>
																		<td><%=client.getCloudInfo().getUsage().getServices() %></td>
																		<td><%=client.getCloudInfo().getUsage().getTotalMemory() %>M of <%=client.getCloudInfo().getLimits().getMaxTotalMemory() %>M</td>
																		<td>没有配置空间配额</td>
																		<%
																			}
																		%>									
																		
																	</tr>
																	<%
																		}
																	%>
																	</tbody>
																</table>
															</div>
															<div class="tab-pane fade" id="<%=orgName %>-left-2">
																<form class="form-horizontal" action="doAddSpace" method="post" id="form-validate">
                                            					<fieldset>
                                            					<legend>创建空间</legend>
																<div class="control-group">
																	<label class="control-label" for="spaceName" >创建空间名：</label>
                                   									<div class="controls">
                                                                		<input type="text" id="spaceName" name="spaceName" class="grd-white" />
                                                            		</div>
																</div>
																
																<div class="control-group">
																<label class="control-label" for="organization">选择空间所属数据中心：</label>
																<div class="controls">
																<select id="organization" name="organization" data-form="select2" style="width:200px" data-placeholder="请选择您的资源配额">
																	<option><%=orgName %></option>																	
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
															<div class="tab-pane fade" id="<%=orgName %>-left-3">
																 <div class="page-header">
                                    							 	<div class="pull-right">
                                        								<img data-src="holder.js/120x120" class="img-circle" />
                                    								</div>
                                    							 	<h3>域名托管 <small>Configuration Your Domains</small></h3>
                                								 </div>
                                								 <div class="row-fluid">
                                								 	<div class="span6">
                                								 		<p class="muted">Organization</p>
                                								 		<p><%=orgName %></p>
                                								 	</div>
                                								 	<div class="span4">
                                        								<p class="muted">Domain</p>
                                        								<%
                                        									List<CloudDomain> domains = client.getDomainFromOrgName(orgName);
                                        									for(CloudDomain domain : domains){
                                        								%>
                                        								<p><%=domain.getName() %></p>
                                        								<%
                                        									}
                                        								%>
                                   									</div>
                                								 </div>
															</div>
															<div class="tab-pane fade" id="<%=orgName %>-left-4">
																<div class="page-header">
                                    							 	<div class="pull-right">
                                        								<img data-src="holder.js/120x120" class="img-circle" />
                                    								</div>
                                    							 	<h3>数据中心团队成员 <small>Configuration Your Users</small></h3>
                                								 </div>
                                								 <div class="row-fluid">
                                								 	<div class="span4">
                                								 		<p class="muted">Organization</p>
                                								 		<p><%=orgName %></p>                               								 		
                                								 	</div>
                                								 	<div class="span6">
                                        								<p class="muted">团队成员</p>
                                        								<div class="invoice-table" >
                                        									<table class="table table-bordered invoice responsive autoTable">
                                        										<thead>
                                        											<tr>
                                        												<td>小组成员队名</td>
                                        												<td>联系方式</td>
                                        											</tr>
                                        										</thead>
                                        										<tbody>
                                        											<%
                                        												List<CloudUser> cloudUsers = client.getUsersByOrgName(orgName);
                                        												for(CloudUser user : cloudUsers){
                                        											%>
                                        											<tr>
                                        												<td><strong><%=user.getName()%></strong></td>
                                        												<td><%=user.getEmails().get(0) %>@hylandtec.com</td>
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
															<div class="tab-pane fade" id="<%=orgName %>-left-5">
																<div class="page-header">
                                    							 	<div class="pull-right"></div>
                                    							 	<h3>数据中心空间配额管理 <small>Space Quota Definition</small></h3>
                                								 </div>
                                								 <!-- 空间配额设置 -->
                                								 <div class="box-tab corner-all">
                                								 	<div class="box-header corner-top">
																		<ul class="nav nav-pills">
																			<li class="active"><a data-toggle="tab" href="#spaceQuotaListTab">空间配额列表</a></li>
																			<li><a data-toggle="tab" href="#spaceQuotaCreateTab">创建空间配额</a></li>
																			<li><a data-toggle="tab" href="#spaceQuotaAssociateTab">分配空间配额</a></li>
																		</ul>
																	</div>
																	<div class="box-body">
																		<div class="tab-content">
																			<div class="tab-pane fade in active" id="spaceQuotaListTab">
                                            									<table class="table table-bordered table-striped">
                                            										<thead>
                                            											<tr>
																							<th>空间配额名</th>
																							<th>允许最大服务数量</th>
																							<th>允许最大路由数</th>
																							<th>空间内存资源极限</th>
																							<th>空间配额所属</th>
																							<th>空间配额创建时间</th>
																							<th>操作</th>
																						<tr>
                                            										</thead>
                                            										<%
                                            											List<CloudSpaceQuota> spaceQuotas = client.getSpaceQuotas();
                                            											if(spaceQuotas.size()!=0){
                                            												for(CloudSpaceQuota spaceQuota : spaceQuotas){
                                            													if(spaceQuota.getOrganization_guid().equals(
                                            														client.getOrgByName(orgName, true).getMeta().getGuid().toString())){
                                            										%>
                                            										<tbody>
                                            											<tr>
                                            												<td>
                                            													<a data-toggle="modal" data-target="#spaceQuotaModal" href="spaceQuotaInfo?name=<%=spaceQuota.getName() %>"><%=spaceQuota.getName() %></a>
                                            													<!-- Modal -->
                                                    											<div class="modal fade" id="spaceQuotaModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                    												<div class="modal-dialog">
                                                        											<div class="modal-content">
            																							<div class="modal-header">
                																							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                 																							<h4 class="modal-title">空间配额明细</h4>
            																							</div>
            																							<div class="modal-body"><div class="spaceQuotaTable"></div></div>
            																							<div class="modal-footer">
                																						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            																							</div>
        																							</div>
        																							<!-- /.modal-content -->
    																								</div>
    																							<!-- /.modal-dialog -->
																								</div>
                                            												</td>
                                            												<td><%=spaceQuota.getTotalServices() %></td>
                                            												<td><%=spaceQuota.getTotalRoutes() %></td>
                                            												<td><%=spaceQuota.getMemoryLimit() %></td>
                                            												<td><%=orgName %></td>
                                            												<td><%=spaceQuota.getMeta().getCreated() %></td>
                                            												<td width="60">
                                            													<a href="#" onclick="doDelete('<%=spaceQuota.getName() %>')"><button class="btn btn-small"><i class="icon-remove"></i></button></a>
                                            												</td>
                                            											</tr>
                                            										</tbody>
                                            										<%
                                            													}
                                            												}
                                            											}
                                            										%>
                                            									</table>
                                            								</div>
                                            								<div class="tab-pane fade" id="spaceQuotaCreateTab">
                                            									<form class="form-horizontal" action="doAddSpaceQuota" method="post" id="form-validate">
                                            									<fieldset>
                                            										<legend>创建资源配额</legend>
																					<div class="control-group">
																						<label class="control-label" for="quotaName" >资源配额名：</label>
                                                            							<div class="controls">
                                                                							<input type="text" id="quotaName" name="quotaName" class="grd-white" />
                                                            							</div>
																					</div>
																					<div class="control-group">
																						<label class="control-label" for="total_services">请输入最大支持服务：</label>
																						<div class="controls">
																							<input type="text" class="grd-white" placeholder="5到200" data-validate="{required: true, number:true, min: 5, max: 200, messages:{required:'请输入5到200之间的数', number:'请输入数字', min:'请输入最小超过5的数(包括5)', max:'请输入最大不超过200的数(包括200)'}}" name="total_services" id="total_services" />
																						</div>
																					</div>
																					<div class="control-group">
																						<label class="control-label" for="total_routes">请输入最大支持路由：</label>
																						<div class="controls">
																							<input type="text" class="grd-white" placeholder="10到20" data-validate="{required: true, number:true, min: 10, max: 20, messages:{required:'请输入10到20之间的数', number:'请输入数字', min:'请输入最小超过10的数(包括10)', max:'请输入最大不超过20的数(包括20)'}}" name="total_routes" id="total_routes" />
																						</div>
																					</div>
																					<div class="control-group">
																						<label class="control-label" for="memory_limit">最大的内存资源限制：</label>
																						<div class="controls">
																							<input type="text" class="grd-white" placeholder="2048到10024" data-validate="{required: true, number:true, min: 2048, max: 10024, messages:{required:'请输入2048到10024之间的数', number:'请输入数字', min:'请输入最小超过2048的数(包括2048)', max:'请输入最大不超过10024的数(包括10024)'}}" name="memory_limit" id="memory_limit" />
																						</div>
																					</div>
																					<div class="control-group">
																						<label class="control-label" for="orgSelect">请选择绑定的组织：</label>
																						<div class="controls">
																							<input type="text" id="orgSelect" name="orgSelect" class="grd-white" value=<%=orgName %> readonly="readonly"/>
																						</div>
																					</div>
																					<div class="form-actions">
                                                            							<button type="submit" class="btn btn-primary">保存设置</button>
                                                            							<button type="button" class="btn">取消设置</button>
                                                        							</div>
																				</fieldset>
																				</form>
                                            								</div>
                                            								<div class="tab-pane fade" id="spaceQuotaAssociateTab">
                                            									<form class="form-horizontal" action="doAssociateSpaceQuota" method="post" id="form-associateQuota">
                                            										<input type="hidden" name="orgName" value=<%=orgName %> />
                                            										<fieldset>
                                            											<legend>分配配额资源到空间</legend>
                                            											<div class="control-group">
                                            												<label class="control-label" for="associateQuota2Space">请选择分配空间：</label>
                                            												<div class="controls">
                                            													<select id="associateQuota2Space" name="associateQuota2Space" data-form="select2" style="width:200px" data-placeholder="请选择需要分配的空间">
                                            														<option></option>
                                            														<%
                              	              															List<CloudSpace> associateSpaces = client.getSpaceFromOrgName(orgName);
                                            															for(CloudSpace associateSpace: associateSpaces){
                                            														%>
                                            															<option><%=associateSpace.getName() %></option>
                                            														<%
                                            															}
                                            														%>
                                            													</select>
                                            												</div>
                                            											</div>
                                            											<div class="control-group">
                                            												<label class="control-label" for="associateQuota">请选择资源配额：</label>
                                            												<div class="controls">
                                            													<select id="associateQuota" name="associateQuota" data-form="select2" style="width:200px" data-placeholder="请选择您的资源配额">
                                            														<option></option>
                                            														<%
                                            															List<CloudSpaceQuota> associateQuotas = client.getSpaceQuotas();
                                            															CloudOrganization org = client.getOrgByName(orgName, true);
                                            															String org_id = org.getMeta().getGuid().toString();
                                            															for(CloudSpaceQuota associateQuota : associateQuotas){
                                            																String orgGuid = associateQuota.getOrganization_guid();
                                            																if(org_id.equals(orgGuid)){
                                            														%>
                                            															<option><%=associateQuota.getName() %></option>
                                            														<%
                                            																}
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
														<!--/widgets-tab-body-->
													
												<!--/box tab-->
											</div>
											<!--/span-->
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
		src='/cloudconsole/js/widgets.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/jquery.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/jquery-ui.min.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/bootstrap.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/datepicker/bootstrap-datepicker.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/colorpicker/bootstrap-colorpicker.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/uniform/jquery.uniform.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/validate/jquery.validate.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/validate/jquery.metadata.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/wizard/jquery.ui.widget.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/wizard/jquery.wizard.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/peity/jquery.peity.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/select2/select2.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/knob/jquery.knob.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/flot/jquery.flot.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/flot/jquery.flot.resize.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/flot/jquery.flot.categories.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/wysihtml5/wysihtml5-0.3.0.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/wysihtml5/bootstrap-wysihtml5.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/datatables/jquery.dataTables.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/datatables/DT_bootstrap.js'></script>

	<script type="text/javascript">
	$('body').on('hidden', '.modal', function () {
		$(this).removeData('modal');
	});
            $(document).ready(function() {
                // try your js
                
                // auto complete
                $('#inputAuto').typeahead({
                    source : ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Dakota","North Carolina","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"]
                });
                
                // select2
                $('#inputTags').select2({tags:["red", "green", "blue"]});
                $('[data-form=select2]').select2();
                $('[data-form=select2-group]').select2();
                
                // this select2 on side right
                $('#tagsSelect').select2({
                    tags:["red", "green", "blue"],
                    tokenSeparators: [",", " "]
                });
                
                
                // datepicker
                $('[data-form=datepicker]').datepicker();

                // coloricker
                $('[data-form=colorpicker]').colorpicker();
                
                
                // uniform
                $('[data-form=uniform]').uniform()

                // wysihtml5
                $('[data-form=wysihtml5]').wysihtml5();
                
                
                // validate form
                $('#form-validate').validate();
                
                // wizard
                $('#form-wizard').wizard({
                    stepsWrapper: "#wrapped",
                    submit: ".submit",
                    beforeSelect: function( event, state ) {
                        var inputs = $(this).wizard('state').step.find(':input');
                        return !inputs.length || !!inputs.valid();
                    }
                }).submit(function( event ) {
                    
                    
                }).wizard('form').validate({
                    errorPlacement: function(error, element) { 
                        if ( element.is(':radio') || element.is(':checkbox') ) {
                                $('#error-gender').html(error);
                        } else { 
                                error.insertAfter( element );
                        }
                    }
                });
                
            });
            </script>
</body>
</html>