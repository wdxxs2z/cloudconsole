<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudInfo"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudApplication"%>
<%@page import="org.cloudfoundry.client.lib.CloudFoundryClient"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudOrganization"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudSpace"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
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
	function doAction(type,appName){
		$.ajax({
			type:"GET",
			url:"appOperation",
			cache:"false",
			data:{
				type:type,
				appName:appName
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
                        	<a href="./securityView" title="Security">
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
							<i class="icofont-home"></i> 应用管理  <small>应用-Application</small>
						</h2>
					</div>
					<!-- /content-header -->

					<!-- content-breadcrumb -->
					<div class="content-breadcrumb">
						<!--breadcrumb-nav-->
						<ul class="breadcrumb-nav pull-right">
							<li class="divider"></li>
							<li class="btn-group">
								<a href="#" class="btn btn-small btn-link dropdown-toggle" data-toggle="dropdown"> 
									<i class="icofont-tasks"></i> 应用空间切换
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
                                        		<li><a href="appSwitchSpace?orgName=<%=organization.getName()%>&spaceName=<%=space.getName() %>" ><%=space.getName() %></a></li>
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
							<li class="active">应用列表</li>
						</ul>
						<!--/breadcrumb-->
					</div>
					<!-- /content-breadcrumb -->
					<div class="content-body">
                    <div class="row-fluid">
                    <div class="span12">
                    <div class="box corner-all">
					<div id="memResource" style="height: 300px">
			
					</div>
					<div class="box-body">
						<table class="table table-bordered table-striped autoTable">
						<thead>
						<tr>
							<th>应用名称</th>
							<th>状态</th>
							<th>实例</th>
							<th>应用磁盘</th>
							<th>使用内存</th>
							<th>架构</th>
							<th>运行时</th>
							<th>服务</th>
							<th>URLS</th>
							<th>操作</th>
						</tr>
						</thead>
						<tbody>
			<%
				/*
				*void org.cloudfoundry.client.lib.CloudFoundryClient.createApplication(String appName, Staging 
						 staging, int memory, List<String> uris, List<String> serviceNames)
				*/
			
				int maxUrlPerApp = client.getCloudInfo().getLimits().getMaxUrisPerApp();
				List<CloudApplication> apps = client.getApplications();
				for(CloudApplication app : apps){
			%>
				<tr>
					<td><a href="appView?name=<%=app.getName() %>"><%=app.getName() %></a></td>
					<td><%=app.getState().name() %></td>
					<td title="Running:<%=app.getRunningInstances()%>&#10;All:<%=app.getInstances()%>"><%=app.getRunningInstances()+"/"+app.getInstances() %></td>					
					<td><%=app.getResources().get("disk") %></td>
					<td><%=app.getMemory() %></td>
					<td><%=app.getStaging().getBuildpackUrl() %></td>
					<td><%=app.getStaging().getStack() %></td>
					<%
						List<String> services = app.getServices();
						if(services.size() != 0 ){
					%>
					<td><%=services.toString().replaceAll("[\\[\\]]", "") %></td>
					<%
						}else{
					%>
					<td>没有绑定任何服务</td>
					<%
						}
					%>
					<%
						String url = "";
						for(String uri : app.getUris()){
							if(StringUtils.isBlank(url)){
								url = uri;
							}else{
								url = url+"&#10;"+uri;
							}
						}
					 %>
					<td title="MaxUrlSize:<%=maxUrlPerApp%>&#10;&#10;CurrentUrlList:&#10;<%=url%>"><%=app.getUris().size()+"/"+maxUrlPerApp %></td>
					<td width="110">
					<% if(app.getRunningInstances()>0){ %>
						<a href="#" onclick="doAction('restart','<%=app.getName()%>')"><button class="btn btn-small"><i class="icon-refresh"></i></button></a>
					<%}else{ %>
						<a href="#" onclick="doAction('start','<%=app.getName()%>')"><button class="btn btn-small"><i class="icofont-play"></i></button></a>
					<%} %>
						<a href="#" onclick="doAction('stop','<%=app.getName()%>')"><button class="btn btn-small"><i class="icofont-stop"></i></button></a>
						<a href="#" onclick="if(confirm('are you sure to delete this app[<%=app.getName()%>]?')){doAction('delete','<%=app.getName()%>')}"><button class="btn btn-small"><i class="icon-remove"></i></button></a>
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
	</section>



	<!-- section footer -->
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
		src='<c:url value="/js/datatables/jquery.dataTables.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/datatables/DT_bootstrap.js"></c:url>'></script>
	<script type="text/javascript"
		src="<c:url value="/js/highcharts/highcharts.js" />"></script>
	<!-- this plugin required jquery ui-->

	<!-- required stilearn template js, for full feature-->
	<script type="text/javascript"
		src='<c:url value="/js/holder.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/stilearn-base.js"></c:url>'></script>

	<script type="text/javascript">
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
	                	url: "spaceMemResourceView",
	                	cache: false,
	                	async: false,
	                	dataType: "json",
	                	success: function(data){
	                		datas = data;
	                	}
		        	});
		        	return datas;
		        }()),
				chart: {
					plotBackgroundColor: null,
					plotBorderWidth: 1,
					plotShadow: false,
			    	renderTo: 'memResource',
		    		events: {
		                load: function() {
		                    var series = this.series;
		                    setInterval(function() {
		                    	$.ajax({
		                        	type: "POST",
		                        	url: "spaceMemResourceView",
		                        	cache: false,
		                        	dataType: "json",
		                        	success: function(data){
		                        		var chart = $('#memResource').highcharts();
		                        		$.each(data, function(index,item){
		                        			chart.series[0].setData(item.data);
		                        		});
		                        	}
		                        });	                        
		                    }, 10000);
		                }
		            },
		            type: 'pie'
				},
				credits:{//去水印
					enabled: false
				},
				title: {
		            text: '空间应用资源内存监控',
		            x: -20 //center
		        },
		        subtitle: {
		            text: 'Cloud Memory Monit',
		            x: -20
		        },
		        plotOptions: {
		            pie: {
		                startAngle: -90,
		                endAngle:90,  
		                center: ['50%', '70%'],
		                allowPointSelect: true,
		                cursor: 'pointer',
		                dataLabels: {
		                    enabled: true,
		                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
		                    style: {
		                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
		                    }
		                }
		            }
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