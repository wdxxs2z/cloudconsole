<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudInfo"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudApplication"%>
<%@page import="org.cloudfoundry.client.lib.CloudFoundryClient"%>
<%@page import="org.apache.commons.lang.StringUtils"%>

<!DOCTYPE html>
<html>
<%
	CloudFoundryClient client = (CloudFoundryClient) session.getAttribute("client");
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
						<li class="active first"><a href="./organization"
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
							<i class="icofont-home"></i> Organization <small>Quota Definition</small>
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
							<li class="active">Org-资源配额管理分配</li>
						</ul>
					</div>
					
					<div class="content-body">
						<div class="row-fluid">
							<div class="span12">
								<div class="box-tab corner-all">
									<div class="box-header corner-top">
										<ul class="nav nav-pills">
											<li class="active"><a data-toggle="tab" href="#quotaListTab">Quota 资源列表</a></li>
											<li><a data-toggle="tab" href="#quotaCreateTab">创建 Quota</a></li>
										</ul>
									</div>
									<div class="box-body">
										<div class="tab-content">
											<div class="tab-pane fade in active" id="quotaListTab">
                                            	<p>Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown aliqua, retro synth master cleanse. Mustache cliche tempor, williamsburg carles vegan helvetica. Reprehenderit butcher retro keffiyeh dreamcatcher synth. Cosby sweater eu banh mi, qui irure terry richardson ex squid. Aliquip placeat salvia cillum iphone. Seitan aliquip quis cardigan american apparel, butcher voluptate nisi qui.</p>
                                            </div>
                                            <div class="tab-pane fade" id="quotaCreateTab">
                                            	<p>Food truck fixie locavore, accusamus mcsweeney's marfa nulla single-origin coffee squid. Exercitation +1 labore velit, blog sartorial PBR leggings next level wes anderson artisan four loko farm-to-table craft beer twee. Qui photo booth letterpress, commodo enim craft beer mlkshk aliquip jean shorts ullamco ad vinyl cillum PBR. Homo nostrud organic, assumenda labore aesthetic magna delectus mollit. Keytar helvetica VHS salvia yr, vero magna velit sapiente labore stumptown. Vegan fanny pack odio cillum wes anderson 8-bit, sustainable jean shorts beard ut DIY ethical culpa terry richardson biodiesel. Art party scenester stumptown, tumblr butcher vero sint qui sapiente accusamus tattooed echo park.</p>
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
		src='<c:url value="/js/calendar/fullcalendar.js"></c:url>'></script>
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
                
                // Server stat circular by knob
                $("input[data-chart=knob]").knob();
                
                // system stat flot
                d1 = [ ['jan', 231], ['feb', 243], ['mar', 323], ['apr', 352], ['maj', 354], ['jun', 467], ['jul', 429] ];
                d2 = [ ['jan', 87], ['feb', 67], ['mar', 96], ['apr', 105], ['maj', 98], ['jun', 53], ['jul', 87] ];
                d3 = [ ['jan', 34], ['feb', 27], ['mar', 46], ['apr', 65], ['maj', 47], ['jun', 79], ['jul', 95] ];
                
                var visitor = $("#visitor-stat"),
                order = $("#order-stat"),
                user = $("#user-stat"),
                
                data_visitor = [{
                        data: d1,
                        color: '#00A600'
                    }],
                data_order = [{
                        data: d2,
                        color: '#2E8DEF'
                    }],
                data_user = [{
                        data: d3,
                        color: '#DC572E'
                    }],
                 
                
                options_lines = {
                    series: {
                        lines: {
                            show: true,
                            fill: true
                        },
                        points: {
                            show: true
                        },
                        hoverable: true
                    },
                    grid: {
                        backgroundColor: '#FFFFFF',
                        borderWidth: 1,
                        borderColor: '#CDCDCD',
                        hoverable: true
                    },
                    legend: {
                        show: false
                    },
                    xaxis: {
                        mode: "categories",
                        tickLength: 0
                    },
                    yaxis: {
                        autoscaleMargin: 2
                    }
        
                };
                
                // render stat flot
                $.plot(visitor, data_visitor, options_lines);
                $.plot(order, data_order, options_lines);
                $.plot(user, data_user, options_lines);
                
                // tootips chart
                function showTooltip(x, y, contents) {
                    $('<div id="tooltip" class="bg-black corner-all color-white">' + contents + '</div>').css( {
                        position: 'absolute',
                        display: 'none',
                        top: y + 5,
                        left: x + 5,
                        border: '0px',
                        padding: '2px 10px 2px 10px',
                        opacity: 0.9,
                        'font-size' : '11px'
                    }).appendTo("body").fadeIn(200);
                }

                var previousPoint = null;
                $('#visitor-stat, #order-stat, #user-stat').bind("plothover", function (event, pos, item) {
                    
                    if (item) {
                        if (previousPoint != item.dataIndex) {
                            previousPoint = item.dataIndex;

                            $("#tooltip").remove();
                            var x = item.datapoint[0].toFixed(2),
                            y = item.datapoint[1].toFixed(2);
                            label = item.series.xaxis.ticks[item.datapoint[0]].label;
                            
                            showTooltip(item.pageX, item.pageY,
                            label + " = " + y);
                        }
                    }
                    else {
                        $("#tooltip").remove();
                        previousPoint = null;            
                    }
                    
                });
                // end tootips chart
                
                
                // Schedule Calendar
                var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		
                var calendar = $('#schedule').fullCalendar({
                    header: {
                        left: 'title',
                        center: '',
                        right: 'prev,next today,month,basicWeek,basicDay'
                    },
                    events: [
                        {
                            title: 'Start a project',
                            start: new Date(y, m, 1)
                        },
                        {
                            title: 'interview and data collection',
                            start: new Date(y, m, 3),
                            end: new Date(y, m, 7)
                        },
                        {
                            title: 'Creating design interface',
                            start: new Date(y, m, 9),
                            end: new Date(y, m, 12)
                        },
                        {
                            title: 'Meeting',
                            start: new Date(y, m, 19, 10, 30),
                            allDay: false
                        },
                        {
                            title: 'Meeting',
                            start: new Date(y, m, 28, 10, 30),
                            allDay: false
                        },
                        {
                            title: 'Date',
                            start: new Date(y, m, d, 12, 0),
                            end: new Date(y, m, d, 14, 0),
                            allDay: false
                        },
                        {
                            title: 'Birthday Party',
                            start: new Date(y, m, d+1, 19, 0),
                            end: new Date(y, m, d+1, 22, 30),
                            allDay: false
                        }
                    ]
                });
                // end Schedule Calendar
            });
      
        </script>
</body>
</html>