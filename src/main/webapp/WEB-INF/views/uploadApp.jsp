<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudInfo"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudApplication"%>
<%@page import="org.cloudfoundry.client.lib.CloudFoundryClient"%>
<%@page import="org.cloudfoundry.client.lib.domain.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%
	CloudFoundryClient client = (CloudFoundryClient) session.getAttribute("client");
	List<CloudDomain> domains = client.getDomains();
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

<script type="text/javascript">
	function doDeployment(appname,subdomain,frame,disk,memory,instanceNum,filename){
		$.ajax({
			type:"GET",
			url:"./appUpload",
			cache:"false",
			data:{
				frame:frame,
				appname:appname,
				subdomain:subdomain,
				disk:disk,
				memory:memory,
				instanceNum:instanceNum
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
						<li><a href="./spaceView" title="spaces">
								<div class="helper-font-24">
									<i class="icofont-edit"></i>
								</div> <span class="sidebar-text">租户空间</span>
						</a></li>
						<li><a href="./securityView" title="Security">
								<div class="helper-font-24">
									<i class="icofont-umbrella"></i>
								</div> <span class="sidebar-text">安全组</span>
						</a></li>
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
						<li><a href="./eventView" title="cloudEvent">
								<div class="helper-font-24">
									<i class="icofont-envelope-alt"></i>
								</div> <span class="sidebar-text">平台事件</span>
						</a></li>
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
							<i class="icofont-home"></i> 应用管理 <small>上传应用</small>
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
							<li class="active">上传我们的应用</li>
						</ul>
						<!--/breadcrumb-->
					</div>
					<!-- /content-breadcrumb -->
					<div class="content-body">
						<div class="row-fluid">
							<div class="span12">
								<div class="box-tab corner-all">
									<div class="box-header corner-top">
										<ul class="nav nav-pills">
											<li class="active"><a data-toggle="tab"
												href="#uploadAppTab">上传应用</a></li>
											<li><a data-toggle="tab" href="#createServiceTab">创建服务实例</a></li>
										</ul>
									</div>
									<div class="box-body">
										<div class="tab-content">
											<div class="tab-pane fade in active" id="uploadAppTab">
												<form class="form-horizontal" action="./appUpload"
													method="post" enctype="multipart/form-data">

													<div class="control-group">
														<label class="control-label" for="inputAuto">您的应用名：</label>
														<div class="controls">
															<input type="text" id="appname" name="appname"
																class="grd-white" required="required" /> <span
																class="add-on">.</span> <select id="subdomain"
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
													<!-- appname div -->

													<div class="control-group">
														<label class="control-label">请选择框架：</label>
														<div class="controls">
														<%
															List<CloudAdminBuildpack> buildpacks = client.getBuildpacks();
															for (CloudAdminBuildpack buildpack : buildpacks) {
														%>
															<label class="radio"> 
															<input type="radio" data-form="uniform" name="frame" id="frame"
																value=<%=buildpack.getName() %> checked="checked" /> 
															<%=buildpack.getName().replace("_buildpack", "_framework") %>
															</label>
														<%
															}
														%>
														</div>
													</div>
													<!-- frame div -->

													<div class="control-group">
														<label class="control-label" for="inputSelect">请选择内存：</label>
														<div class="controls">
															<select id="memory" name="memory" data-form="inputSelect"
																style="width: 200px" data-placeholder="请选择分配内存大小">
																<option value="128">128</option>
																<option value="256">256</option>
																<option value="512">512</option>
																<option value="1024">1024</option>
															</select>
														</div>
													</div>
													<!-- memory seletct -->

													<div class="control-group">
														<label class="control-label" for="inputSelect">请选择磁盘：</label>
														<div class="controls">
															<select id="disk" name="disk" data-form="select2"
																style="width: 200px" data-placeholder="请选择分配磁盘大小">
																<option value="256">256</option>
																<option value="512">512</option>
																<option value="1024">1024</option>
															</select>
														</div>
													</div>
													<!-- disk seletct -->

													<div class="control-group">
														<label class="control-label" for="inputSelect">选择实例数：</label>
														<div class="controls">
															<div class="span4">
																<p>
																	<input type="text" id="instanceNum" name="instanceNum"
																		style="border: 0; color: #f6931f; font-weight: bold;" />
																</p>
																<div id="instance-max" class="slider-black"></div>
															</div>
														</div>
													</div>
													<!-- instanceNum select -->

													<div class="control-group">
														<label class="control-label" for="serviceInstanceSelect">绑定服务(可选)：</label>
														<div class="controls">
															<select id="serviceInstanceSelect" data-form="select2"
																name="serviceInstanceSelect" style="width: 200px"
																data-placeholder="服务可选" multiple="multiple">
																<%
                                           					List<CloudService> serviceInstances = client.getServices();
                                           					for (CloudService serviceInstance : serviceInstances) {
                                           				%>
																<option value="<%=serviceInstance.getName() %>"><%=serviceInstance.getName() %></option>
																<%
                                           					}
                                           				%>
															</select>
														</div>
													</div>
													<!-- serviceInstance select -->

													<div class="control-group">
														<label class="control-label" for="filename">请打包文件：</label>
														<div class="controls">
															<input type="file" data-form="uniform" name="file" id="file"/>
														</div>
													</div>

													<div class="control-group">
														<label class="control-label" for="submit">提交任务：</label>
														<div class="controls">
															<input type="submit" name="submit"
																class="btn btn-success" value="上传代码"
																onclick="doDeployment(getAppName(),getSubdomain(),getFrame(),getDisk(),getMemory(),getInstance(),getFileName())" />
														</div>
													</div>
												</form>
											</div>
											<div class="tab-pane fade" id="createServiceTab">
												<form class="form-horizontal" action="doCreateServiceInstance" method="post" id="form-validate">
													<fieldset>
														<legend>创建服务实例</legend>
														<div class="control-group">
															<label class="control-label" for="serviceInstanceName" >服务实例名称：</label>
                                   							<div class="controls">
                                                                <input type="text" id="serviceInstanceName" name="serviceInstanceName" class="grd-white" />
                                                            </div>
														</div>
														<div class="control-group">
															<label class="control-label" for="serviceOffine">选择服务类型：</label>
															<div class="controls">
																<select id="serviceOffine" name="serviceOffine" data-form="select2" style="width:220px" data-placeholder="请选择服务类型">
																	<option></option>
																	<%
																		List<CloudServiceOffering> serviceOffines = client.getServiceOfferings();
																		for (CloudServiceOffering serviceOffine : serviceOffines) {
																	%>
																	<option><%=serviceOffine.getName() %></option>
																	<%
																		}
																	%>
																</select>
															</div>
														</div>
														<div class="control-group">
															<label class="control-label" for="servicePlan">选择服务计划：</label>
															<div class="controls">
																<select id="servicePlan" name="servicePlan" data-form="select2" style="width:220px" data-placeholder="请选择服务计划">
																	<option value="0"></option>
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
					</div>
				</div>
			</div>
		</div>
	</section>



	<!-- section footer -->
	<footer>
		<a rel="to-top" href="#top"><i class="icofont-circle-arrow-up"></i></a>
	</footer>

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
		src='/cloudconsole/js/calendar/fullcalendar.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/datatables/jquery.dataTables.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/datatables/DT_bootstrap.js'></script>
	<script type="text/javascript"
		src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
	<script type="text/javascript"
		src="<c:url value="/js/bootstrap-editable.js" />"></script>
	<script type="text/javascript"
		src='/cloudconsole/js/jquery.json.min.js'></script>

	<script type="text/javascript">
	//doDeployment script
	function getAppName(){
		var appName = $("input[name='appname']").val();
		return appName;
	}
	function getSubdomain(){
		var subdomain = $("#subdomain").val();
		return subdomain;
	}
	function getFrame(){
		var frame = $("input[name='frame']:checked").val();
		return frame;
	}
	function getMemory(){
		var memory = $("#memory").val();
		return memory;
	}
	function getDisk(){
		var disk = $("#disk").val();
		return disk;
	}
	function getInstance(){
		var instance = $("#instanceNum").attr();
		return instance;
	}
	function getFileName(){
		var fn = $("#file").val();
		var nf = fn.substr(fn.lastIndexOf("\\")+1,fn.length-fn.lastIndexOf("\\")-5);
		return nf;
	}
	</script>

	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							
							$("#serviceOffine").change(function(){
							 	var serviceOffineName = $("#serviceOffine").val();
							    $.ajax({
							    	type: "POST",
							        url: "./getServicePlan",
							        data: {
							        	serviceOffineName:serviceOffineName
							        },
							        dataType: 'json',
							        success: function(data) {
							        	$("#servicePlan").empty();
							        	$.each(data.servicePlans, function(index,item){							        	
							        	$("#servicePlan").append("<option>" + item.servicePlanName + "</option>")
							        	});
							       	}
								});
							    })
							
							// try your js
							// slider with max
							$("#instance-max").slider({
            				range: "max",
            				min: 1,
           					max: 5,
            				value: 1,
            				slide: function( event, ui ) {
                				$( "#instanceNum" ).val( ui.value );
            				}
        					});
							$( "#instanceNum" ).val( $( "#instance-max" ).slider( "value" ) );

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

							// Input tags with select2
							$('input[name=reseiver]').select2({
								tags : []
							});

							// datepicker
			                $('[data-form=datepicker]').datepicker()
			                
			                // validate form
                			$('#form-validate').validate();
							
							// uniform
							$('[data-form=uniform]').uniform();

							// wysihtml5
							$('[data-form=wysihtml5]').wysihtml5()
							toolbar = $('[data-form=wysihtml5]').prev();
							btn = toolbar.find('.btn');

							$.each(btn, function(k, v) {
								$(v).addClass('btn-mini')
							});
							
							// select2
			                $('#inputTags').select2({tags:["red", "green", "blue"]});
			                $('[data-form=select2]').select2();
			                $('[data-form=select2-group]').select2();
							
							// Server stat circular by knob
							$("input[data-chart=knob]").knob();
							
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