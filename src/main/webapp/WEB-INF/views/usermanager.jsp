<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*"%>
<%@page import="org.cloudfoundry.client.lib.CloudFoundryClient"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudOrganization" %>
<%@page import="org.cloudfoundry.client.lib.domain.CloudSpace" %>
<%@page import="org.cloudfoundry.client.lib.domain.CloudUser" %>
<%@page import="org.cloudfoundry.client.lib.domain.CloudDomain" %>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.cloudconsole.model.RegisterUser" %>
<%
	CloudFoundryClient client = (CloudFoundryClient) session.getAttribute("client");
	List<CloudUser> registerUsers = new ArrayList<CloudUser>();
	List<CloudUser> notRegister = new ArrayList<CloudUser>();
	List<CloudUser> allUsers = new ArrayList<CloudUser>();
	registerUsers = (List<CloudUser>) session.getAttribute("registerUsers");
	notRegister = (List<CloudUser>)session.getAttribute("notRegister");
	allUsers = (List<CloudUser>)session.getAttribute("allUsers");
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
<link rel="stylesheet" href="<c:url value="/css/select2.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/responsive-tables.css"/>" />
<link rel="stylesheet"
	href="<c:url value="/css/bootstrap-wysihtml5.css"/>" />

<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<script type="text/javascript">
	function doAction(type,username){
		$.ajax({
			type:"GET",
			url:"userOperation",
			cache:"false",
			data:{
				type:type,
				username:username
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
						<li class="active first"><a href="./organization"
							title="Organizations">
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
						<li><a href="./dea" title="Dea">
								<div class="helper-font-24">
									<i class="icofont-envelope-alt"></i>
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
			
			<div class="span11">
				<div class="content">
					<div class="content-header">
						<h2>
							<i class="icofont-home"></i> 租户管理 <small>用户-RoleManager</small>
						</h2>
					</div>
					<div class="content-breadcrumb">
						<ul class="breadcrumb-nav pull-right">
							<li class="divider"></li>
							<li class="btn-group">
                            	<a href="./editUserPrivilege" class="btn btn-small btn-link">
                                	<i class="icofont-money"></i> 用户授权
                                </a>
                            </li>						
							<li class="divider"></li>
							<li class="btn-group"><a href="./usermanager"
								class="btn btn-small btn-link"> <i class="icofont-user"></i>
									用户管理 <span class="color-red">
									<%
										if( notRegister.size()>0 ){
									%>
									(+<%=notRegister.size() %>)
									<%
										}else{
									%>
									(0)
									<%
										}
									%>
									</span>
							</a></li>
						</ul>
						<!--/breadcrumb-nav-->

						<!--breadcrumb-->
						<ul class="breadcrumb">
							<li><a href="./home"><i class="icofont-home"></i>Dashboard</a> <span class="divider">&rsaquo;</span></li>
							<li><a href="./organization">数据中心概览</a><span class="divider">&rsaquo;</span></li>
							<li class="active">租户管理</li>
						</ul>
					</div>
					
					<!-- 租户分配 -->
					<div class="content-body">
						<div class="row-fluid">
							<div class="span12">
								<div class="box-tab corner-all">
									<div class="box-header corner-top">
										<ul class="nav nav-tabs">
											<li class="active"><a data-toggle="tab" href="#usertab">用户总概览</a></li>
											<li><a data-toggle="tab" href="#userroletab">用户团队分配</a></li>
										</ul>
									</div>
									<div class="box-body">
										<div class="tab-content">
										<!-- 用户概览 -->
										<div class="tab-pane fade in active" id="usertab">
											<table class="table table-bordered table-striped autoTable">
												<thead>
													<tr>
														<th>成员名</th>
														<th>成员提供邮箱</th>
														<th>成员提供联系方式</th>
														<th>归属组织</th>
														<th>成员注册日期</th>
														<th>编辑成员</th>
													</tr>
												</thead>
												
												<tbody>
													<%
														for( CloudUser user : allUsers){
													%>
														<tr>
															<td><%=user.getName() %></td>
															<td><%=user.getEmails().get(0) %></td>
															<td><%=user.getPhoneNumbers()==null ? "没有提供联系方式" : user.getPhoneNumbers().get(0)%></td>
															<td><%=user.getOrganizations().size()==0 ? "没有分配组织" : user.getOrganizations().get(0).getName() %></td>
															<td><%=user.getMeta().getCreated() %></td>
															<td width="80">
															<%
																if(user.getOrganizations().size() != 0){
															%>
																<a href="./edituser?username=<%=user.getName() %>" onclick="" ><button class="btn btn-small"><i class="icon-wrench"></i></button></a>
																<a href="#" onclick="if(confirm('确定你要删除[<%=user.getName()%>]用户?')){doAction('delete','<%=user.getName()%>')}"><button class="btn btn-small"><i class="icon-trash"></i></button></a>
															<%
																}else {
															%>	
																<a href="#" onclick="if(confirm('确定你要删除[<%=user.getName()%>]用户?')){doAction('delete','<%=user.getName()%>')}"><button class="btn btn-small"><i class="icon-trash"></i></button></a>
															<%
																}
															%>
															</td>
														</tr>
													<%
														}
													%>
												</tbody>
											</table>
										</div>
										<!-- 用户团队分配 -->
										<div class="tab-pane fade" id="userroletab">										
											<form class="form-horizontal" action="./adduserrole" method="post">
												<!-- 用户选择 -->
												<div class="control-group">
													<label class="control-label" for="multiUser"><strong>多用户选择:</strong></label>
													<div class="controls">
														<select id="multiUser" name="multiUser" data-form="select2" style="width:200px" data-placeholder="选择您希望加入团队的人员" multiple="multiple">
															<%
																for(CloudUser register: notRegister){
															%>
															<option value=<%=register.getMeta().getGuid().toString() %>><%=register.getName() %></option>
															<%
																}
															%>
														</select>
													</div>
												</div>
												<!-- 组织空间选择 -->
												<div class="control-group">
													<label class="control-label" for="teamSelect"><strong>请分配成员的组织空间:</strong></label>
													<div class="controls">
														<select id="teamSelect" name="teamSelect" data-form="select2" style="width:200px" 
														data-placeholder="选择用户下的团队" onchange='GetOptgroup(this.options[this.selectedIndex]);'>
															<option value="" />
															<%
																List<CloudOrganization> orgs = client.getOrganizations();
																for(CloudOrganization org : orgs){
																	String orgName = org.getName();
															%>
															<optgroup label="<%=org.getName() %>" id="<%=orgName %>" >
																<%
																	for(CloudSpace space: client.getSpaceFromOrgName(orgName)){
																%>
                                                            	<option value=<%=space.getMeta().getGuid().toString()%>><%=space.getName()%></option>
                                                            	<%
																	}
                                                            	%>
                                                           	</optgroup>
                                                           	<%
																}
                                                           	%>
														</select>
														<input type="hidden" name="orgValue" id="orgValue" value=""/>
													</div>
												</div>
												<div class="form-actions">
                                                	<button type="submit" class="btn btn-primary">提交</button>
                                                    <button type="button" class="btn">取消</button>
                                                </div>
											</form>
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
	<footer>
		<a rel="to-top" href="#top"><i class="icofont-circle-arrow-up"></i></a>
	</footer>
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
		src='<c:url value="/js/datepicker/bootstrap-datepicker.js"></c:url>'></script>
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
		src='<c:url value="/js/responsive-tables/responsive-tables.js"></c:url>'></script>
	<!-- this plugin required jquery ui-->

	<!-- required stilearn template js, for full feature-->
	<script type="text/javascript"
		src='<c:url value="/js/holder.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/stilearn-base.js"></c:url>'></script>
		
	<script type="text/javascript">
	function getopt()
    {
        var ss = teamSelect.options[teamSelect.selectedIndex].parentNode.attributes;
        orgValue.value = ss["label"].value;
    }
	function GetOptgroup(obj)
	{
	   var optgroup=obj.parentNode;
	   while(optgroup.previousSibling.label)
	   {
	        optgroup=optgroup.previousSibling;
	   }
	   if(optgroup.label)
	   orgValue.value = optgroup.label;
	}
	</script>

	<script type="text/javascript">
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
                
                // uniform
                $('[data-form=uniform]').uniform()

                // wysihtml5
                $('[data-form=wysihtml5]').wysihtml5();
                
            });
      
        </script>	
</body>

</html>