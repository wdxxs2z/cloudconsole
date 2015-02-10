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
				<div class="content">
					<div class="content-header">
						<h2>
							<i class="icofont-home"></i> 空间管理 <small>用户角色分配-SpaceManager</small>
						</h2>
					</div>
					<div class="content-breadcrumb">
						<ul class="breadcrumb">
							<li><a href="./home"><i class="icofont-home"></i>
									Dashboard</a> <span class="divider">&rsaquo;</span></li>
									<li><a href="#"><%=space.getOrganization().getName() %></a> <span class="divider">&rsaquo;</span></li>
							<li><a href="#"><%=space.getName() %></a> <span class="divider">&rsaquo;</span></li>
							<li class="active">部门角色管理</li>
						</ul>
					</div>
					<!-- 正文 -->
					<div class="content-body">
						<div class="page-header">
                        	<h3>项目部门人员调动管理 <small> CloudFoundry Space Role Manager</small></h3>
                        </div>
						<!-- form -->
						<div class="row-fluid">
							<div class="box-body">
								<form class="form-horizontal" action="./editSpaceUser" method="post">
									<%
                                    	String spaceGuid = space.getMeta().getGuid().toString();
                                    %>
									<div class="control-group">
                                        <label class="control-label" for="managerSpace"><strong>部门管理组：</strong></label>
                                        <div class="controls">
                                        	<select id="managerSpace" data-form="select2" name="managerSpace" style="width:200px" data-placeholder="请选择您的管理组员" multiple="multiple">
                                            	<%
                                            		Set<Map.Entry<String, String>> managerSet =spaceUsers.entrySet();
                                            		for(Iterator<Map.Entry<String, String>> managerIt = managerSet.iterator();managerIt.hasNext();){
                                            			Map.Entry<String, String> managerEntry = (Map.Entry<String, String>) managerIt.next();
                                            			Boolean isExist = false;
                                            			List<CloudUser> managers = client.getUsersBySpaceRole(spaceGuid, "managers");
                                            			if(managers.size()!=0){
                                            				for(CloudUser manager :managers){
                                                				if(managerEntry.getKey().endsWith(manager.getMeta().getGuid().toString())){
                                                					isExist = true;
                                                	%>
                                                	<option selected="selected"><%=managerEntry.getValue()%></option>                                               	
                                                	<%
                                                				}
                                                			}
                                            				if(isExist==false){
                                            		%>
                                            		<option><%=managerEntry.getValue()%></option>
                                            		<%			
                                            				}
                                            			}else{
                                            		%>	
                                            		<option><%=managerEntry.getValue()%></option>		
                                            		<%		
                                            			}        			
                                            		}
                                            		%>
                                            </select>
                                       </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="developerSpace"><strong>部门研发组：</strong></label>
                                        <div class="controls">
                                        	<select id="developerSpace" data-form="select2" name="developerSpace" style="width:200px" data-placeholder="请选择您的开发组员" multiple="multiple">
                                            	<%
                                            		Set<Map.Entry<String, String>> developerSet =spaceUsers.entrySet();
                                            		for(Iterator<Map.Entry<String, String>> developerIt = developerSet.iterator();developerIt.hasNext();){
                                            			Map.Entry<String, String> developerEntry = (Map.Entry<String, String>) developerIt.next();
                                            			Boolean isExist = false;
                                            			List<CloudUser> developers = client.getUsersBySpaceRole(spaceGuid, "developers");
                                            			if(developers.size()!=0){
                                            				for(CloudUser developer :developers){
                                                				if(developerEntry.getKey().endsWith(developer.getMeta().getGuid().toString())){
                                                					isExist = true;
                                                	%>
                                                	<option selected="selected"><%=developerEntry.getValue()%></option>                                               	
                                                	<%
                                                				}
                                                			}
                                            				if(isExist==false){
                                            		%>
                                            		<option><%=developerEntry.getValue()%></option>
                                            		<%			
                                            				}
                                            			}else{
                                            		%>	
                                            		<option><%=developerEntry.getValue()%></option>		
                                            		<%		
                                            			}        			
                                            		}
                                            		%>
                                            </select>
                                       </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="testSpace"><strong>部门测试组：</strong></label>
                                        <div class="controls">
                                        	<select id="testSpace" data-form="select2" name="testSpace" style="width:200px" data-placeholder="请选择您的测试组员" multiple="multiple">
                                            	<%
                                            		Set<Map.Entry<String, String>> testSet =spaceUsers.entrySet();
                                            		for(Iterator<Map.Entry<String, String>> testIt = testSet.iterator();testIt.hasNext();){
                                            			Map.Entry<String, String> testEntry = (Map.Entry<String, String>) testIt.next();
                                            			Boolean isExist = false;
                                            			List<CloudUser> testers = client.getUsersBySpaceRole(spaceGuid, "auditors");
                                            			if(testers.size()!=0){
                                            				for(CloudUser tester :testers){
                                                				if(testEntry.getKey().endsWith(tester.getMeta().getGuid().toString())){
                                                					isExist = true;
                                                	%>
                                                	<option selected="selected"><%=testEntry.getValue()%></option>                                               	
                                                	<%
                                                				}
                                                			}
                                            				if(isExist==false){
                                            		%>
                                            		<option><%=testEntry.getValue()%></option>
                                            		<%			
                                            				}
                                            			}else{
                                            		%>	
                                            		<option><%=testEntry.getValue()%></option>		
                                            		<%		
                                            			}        			
                                            		}
                                            		%>
                                            </select>
                                       </div>
                                    </div>
                                    <div class="control-group">
                                    <label class="control-label" for="submit"><strong>提交我们的组员</strong></label>
										<div class="controls">
											<input type="submit" name="submit" class="btn btn-inverse" value="确认组队" />
										</div>					
									</div>
								</form>
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
            });
      
        </script>	
</body>
</html>