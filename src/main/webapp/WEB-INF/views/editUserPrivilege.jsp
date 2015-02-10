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
						<li class="active first"><a href="./organization" title="Organizations">
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
			<div class="span11">
				<div class="content">
					<div class="content-header">
						<h2>
							<i class="icofont-home"></i> 数据中心人员权限管理 <small>用户权限分配-OrgUserManager</small>
						</h2>
					</div>
					<div class="content-breadcrumb">
						<ul class="breadcrumb">
							<li><a href="./home"><i class="icofont-home"></i>
									Dashboard</a> <span class="divider">&rsaquo;</span></li>
									<li><a href="#">全体人员</a> <span class="divider">&rsaquo;</span></li>
							<li class="active">数据中心人员管理</li>
						</ul>
					</div>
					<div class="content-body">
					<!-- 头部 -->
					<div class="page-header">
                    	<h3>数据中心人员管理 <small>CloudFoundry Organization User Manager</small></h3>
                    </div>
                    <!-- 表单数据 -->
                    <div class="row-fluid">
                    	<div class="box-body">
                    		<form class="form-horizontal" action="./editAllUserPrivilegePost" method="post">
                    			<%
                    				List<CloudUser> allUsers = client.getAllUsers();
                    			%>
                    			<div class="control-group">
                    				<label class="control-label" for="allUserMember" style="width:200px"><strong>数据中心成员访问权组：</strong></label>
                    				<div class="controls">
                    					<select id="allUserMember" data-form="select2" name="allUserMember" style="width:250px" data-placeholder="请选择您的中心MEMBER组员" multiple="multiple">
                    						<%
                    							for(CloudUser user : allUsers){
                    								String user_Id = user.getMeta().getGuid().toString();
                    								if(client.isMemberByUserAndDisplayName(user_Id, "cloud_controller.admin")){
                    									if(user.getName().endsWith("admin")){
                    						%>
                    						<option selected="selected"><%=user.getName() %></option>
                    						<%
                    									}else{
                    						%>
                    						<option selected="selected"><%=user.getName() %></option>	
                    						<%			
                    									}
                    						%>
                    						<%
                    								}else{
                    						%>
                    						<option><%=user.getName() %></option>			
                    						<%
                    								}
                    							}
                    						%>
                    					</select>
                    				</div>
                    			</div>
                    			<div class="control-group">
                    				<label class="control-label" for="allUserReader" style="width:200px"><strong>数据中心成员READER组：</strong></label>
                    				<div class="controls">
                    					<select id="allUserReader" data-form="select2" name="allUserReader" style="width:250px" data-placeholder="请选择您的中心READER组员" multiple="multiple">
                    						<%
                    							for(CloudUser user : allUsers){
                    								String user_Id = user.getMeta().getGuid().toString();
                    								if(client.isReaderByUserAndDisplayName(user_Id, "cloud_controller.admin")){                   									
                    						%>
                    						<option selected="selected"><%=user.getName() %></option>
                    						<%
                    								}else{
                    						%>
                    						<option><%=user.getName() %></option>			
                    						<%
                    								}
                    							}
                    						%>
                    					</select>
                    				</div>
                    			</div>
                    			<div class="control-group">
                    				<label class="control-label" for="allUserWriter" style="width:200px"><strong>数据中心成员Writer组：</strong></label>
                    				<div class="controls">
                    					<select id="allUserWriter" data-form="select2" name="allUserWriter" style="width:250px" data-placeholder="请选择您的中心WRITER组员" multiple="multiple">
                    						<%
                    							for(CloudUser user : allUsers){
                    								String user_id = user.getMeta().getGuid().toString();
                    								if(client.isWriterByUserAndDisplayName(user_id, "cloud_controller.admin")){                   									
                    						%>
                    						<option selected="selected"><%=user.getName() %></option>
                    						<%
                    								}else{
                    						%>
                    						<option><%=user.getName() %></option>			
                    						<%
                    								}
                    							}
                    						%>
                    					</select>
                    				</div>
                    			</div>
                    			<div class="control-group">
                                <label class="control-label" for="submit" style="width:200px"><strong>提交我们的管理权组：</strong></label>
									<div class="controls">
										<input type="submit" name="submit" class="btn btn-inverse" value="确认授权" />
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
		$('select option').each(function(){
			if(this.style.display == 'none'){
    			$(this).remove();
			}
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
                    event.preventDefault();
                    alert('Form submitted!');
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