<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudInfo"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudApplication"%>
<%@page import="org.cloudfoundry.client.lib.CloudFoundryClient"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudOrganization" %>
<%@page import="org.cloudfoundry.client.lib.domain.CloudSpace" %>
<%@page import="org.cloudfoundry.client.lib.domain.CloudSecurityGroup" %>
<%@page import="org.cloudfoundry.client.lib.domain.CloudSecurityRules" %>
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
<style type="text/css">

</style>
</head>
<script type="text/javascript">
	function doAction(type,securityGroupName){
		$.ajax({
			type:"GET",
			url:"securityGroupOperation",
			cache:"false",
			data:{
				type:type,
				securityGroupName:securityGroupName
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
						</li>
						<li><a href="./spaceView" title="spaces">
								<div class="helper-font-24">
									<i class="icofont-edit"></i>
								</div> <span class="sidebar-text">租户空间</span>
						</a></li>
						<li class="active first">
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
							<i class="icofont-home"></i> Cloud Security Group <small>平台安全组管理</small>
						</h2>
					</div>
					<div class="content-breadcrumb">
						<ul class="breadcrumb">
							<li><a href="./home"><i class="icofont-home"></i>
									Dashboard</a> <span class="divider">&rsaquo;</span></li>
							<li class="active">安全组管理</li>
						</ul>
					</div>
					<div class="content-body">
						<div class="row-fluid">
							<div class="span12">
								<div class="box-tab corner-all">
									<div class="box-header corner-top">
										<ul class="nav nav-pills">
											<li class="active"><a data-toggle="tab" href="#securityGroupTab">安全访问列表</a></li>
											<li><a data-toggle="tab" href="#securityCreateTab">创建安全访问组</a></li>
											<li><a data-toggle="tab" href="#security2SpaceTab">分配安全组到空间</a></li>
										</ul>
									</div>
									<div class="box-body">
										<div class="tab-content">
											<div class="tab-pane fade in active" id="securityGroupTab">
												<table class="table table-bordered table-striped autoTable" id="securityTable">
													<thead>
														<tr>
															<th>安全组名称</th>
															<th>是否是运行安全组</th>
															<th>是否是编译安全组</th>
															<th>详细安全组规则</th>
															<th>创建时间</th>
															<th>操作</th>
														</tr>
													</thead>
													<tbody>
													<%
														List<CloudSecurityGroup> securityGroups =  client.getSecurityGroups();
														for (CloudSecurityGroup securityGroup : securityGroups) {
													%>
													<tr>
														<td>
															<%=securityGroup.getName() %>
														</td>
														<td><%=securityGroup.getRunning_default() %></td>
														<td><%=securityGroup.getStaging_default() %></td>
														<td>
														<%
															List<CloudSecurityRules> securityRules = securityGroup.getRules();
															for (CloudSecurityRules securityRule : securityRules) {
																if(securityRule.getProtocol().equals("icmp")){
														%>
															协议:<%=securityRule.getProtocol() %>,目标范围:<%=securityRule.getDestination() %>,
															ICMP_TYPE:<%=securityRule.getType() %>,ICMP_CODE:<%=securityRule.getCode() %><br>
															
														<%
																}
																if (securityRule.getProtocol().equals("tcp")){
														%>
															协议:<%=securityRule.getProtocol() %>,目标范围:<%=securityRule.getDestination() %>,
															端口:<%=securityRule.getPorts() %>,支持日志:<%=securityRule.getLog() %><br>
														<%
																}
																if (securityRule.getProtocol().equals("udp")){
														%>	
															协议:<%=securityRule.getProtocol() %>,目标范围:<%=securityRule.getDestination() %>,
															端口:<%=securityRule.getPorts() %><br>
														<%
																}
																if (securityRule.getProtocol().equals("all")){
														%>		
															协议:<%=securityRule.getProtocol() %>,目标范围:<%=securityRule.getDestination() %><br>
														<%
																}	
														%>				
														<%
															}
														%>
														</td>
														<td><%=securityGroup.getMeta().getCreated() %></td>
														<td width="120">
															<a href="securityGroupInfo?name=<%=securityGroup.getName() %>" title="Edit SecurityGroup"><button class="btn btn-small"><i class="icon-check"></i></button></a>
															<a href="editSpaceWithSecGroup?name=<%=securityGroup.getName()%>" title="Bing SecurityGroup"><button class="btn btn-small"><i class="icon-filter"></i></button></a>
															<a href="#" onclick="if(confirm('确定你要删除[<%=securityGroup.getName()%>]安全组?')){doAction('delete','<%=securityGroup.getName()%>')}"><button class="btn btn-small"><i class="icon-trash"></i></button></a>
														</td>
													</tr>
													<%
														}
													%>
													</tbody>
												</table>
											</div>
											<div class="tab-pane fade" id="securityCreateTab">
											<div class="span8">
												<form class="form-horizontal" action="doAddSecurityGroup" method="post" id="form-validate">
													<fieldset>
														<legend>创建安全组</legend>
														<div class="control-group">
															<label class="control-label" for="securityGroupName" >创建安全组名：</label>
                                   							<div class="controls">
                                                                <input type="text" id="securityGroupName" name="securityGroupName" class="grd-white" />
                                                            </div>
														</div>
														<div class="control-group">
															<label class="control-label" for="securityGroupRules" >创建安全组规则：</label>
                                   							<div class="controls" id="securityGroupRules">
                                                                <textarea id="securityGroupRules" name="securityGroupRules" class="span8" rows="8" >
                                                                </textarea>
                                                            </div>
														</div>
														<div class="form-actions">
                                                            <button type="submit" class="btn btn-primary">保存设置</button>
                                   							<button type="button" class="btn">取消设置</button>
                                                        </div>
													</fieldset>
												</form>
												</div>
												<div class="span4">
													<p><strong>应用安全组说明</strong></p>
													<p>一个安全组由一系列被定义的网络出口允许规则组成。这些规则定义允许应用容器被外部环境访问。 每个规则包含以下3点：</p>
													<ul>
														<li><strong>支持协议</strong>：TCP, UDP, 或者  ICMP</li>
														<li><strong>开放端口或端口范围</strong>：
															<ul>
																<li>对于TCP和UDP，支持单个端口或者一个端口范围</li>
																<li>对于ICMP，需要指定ICMP TYPE和 CODE,通常type=0,code=1</li>
															</ul>
														</li>
														<li><strong>目的地址</strong>：这里有3种选择
															<ul>
																<li>单独的IP地址，例如：192.168.172.124</li>
																<li>CIDR的地址范围，例如：10.10.1.0/24 </li>
																<li>指定一段地址范围，例如：0.0.0.0-9.255.255.255 </li>
															</ul>
														</li>
														<li><strong>范例</strong>：
															<pre>[
  {
    "protocol": "icmp",
    "destination": "0.0.0.0/0",
    "type": 0,
    "code": 1
  },
  {
    "protocol": "tcp",
    "destination": "0.0.0.0/0",
    "ports": "2048-3000",
    "log": true
  },
  {
    "protocol": "udp",
    "destination": "0.0.0.0/0",
    "ports": "53, 5353"
  },
  {
    "protocol": "all",
    "destination": "0.0.0.0/0"
  },
  {
    "protocol":"all",
    "destination":"10.0.0.0-10.255.255.255"
  }
]</pre>
														</li>
													</ul>
												</div>
											</div>
											<div class="tab-pane fade" id="security2SpaceTab">
												<form class="form-horizontal" action="bindSecurityGroup2Space" method="post" id="form-validate">
													<fieldset>
														<legend>绑定安全组到Space</legend>
														<div class="control-group">
															<label class="control-label" for="selectSecurityGroup">选择安全组：</label>
															<div class="controls">
																<select id="selectSecurityGroup" name="selectSecurityGroup" data-form="select2" style="width:200px" data-placeholder="请选择您的安全组">
																	<option></option>
																	<%
																		List<CloudSecurityGroup> selectSecurityGroups =  client.getSecurityGroups();
																		for (CloudSecurityGroup selectSecurityGroup : selectSecurityGroups) {
																	%>
																		<option><%=selectSecurityGroup.getName() %></option>
																	<%
																		}
																	%>
																</select>
															</div>
														</div>
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
                                                            		<option value=<%=space.getMeta().getGuid().toString()%>><%=orgName%> -- <%=space.getName()%></option>
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
													</fieldset>
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
	<script type="text/javascript"
		src='/cloudconsole/js/jquery.json.min.js'></script>
	
	
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

                // coloricker
                $('[data-form=colorpicker]').colorpicker();
                
                
                // uniform
                $('[data-form=uniform]').uniform()

                // wysihtml5
                //$('[data-form=wysihtml5]').wysihtml5();
                
                
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