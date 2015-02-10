<%@page import="com.cloudconsole.common.FileUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.cloudfoundry.client.lib.domain.InstanceStats"%>
<%@page import="org.cloudfoundry.client.lib.domain.InstanceInfo"%>
<%@page import="org.cloudfoundry.client.lib.domain.InstancesInfo"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudApplication"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudInfo"%>
<%@page import="org.cloudfoundry.client.lib.CloudFoundryClient"%>
<%
	CloudFoundryClient client = (CloudFoundryClient) session.getAttribute("client");
	String appName = request.getParameter("name");
	String instance = request.getParameter("instance");
%>
<!DOCTYPE html>
<html lang="en">
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
<link rel="stylesheet" href="<c:url value="/css/select2.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/jqueryFileTree.css"/>" media="screen" />
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
				<div class="content">
					<div class="content-header">
						<h2>
							<i class="icofont-home"></i> 云应用实例管理 <small>Application
								Manager</small>
						</h2>
					</div>
					<div class="content-breadcrumb">
						<!--breadcrumb-->
						<ul class="breadcrumb">
							<li><a href="./home"><i class="icofont-home"></i>Dashboard</a>
								<span class="divider">&rsaquo;</span></li>
							<li><a href="./appView">应用列表</a><span class="divider">&rsaquo;</span></li>
							<li><%=appName %></li>
						</ul>
						<!--/breadcrumb-->
					</div>
					<div class="content-body">
						<div class="row-fluid">
							<div class="span10">
								<div class="box corner-all">
									<div class="box-header grd-white corner-top">
										<span>Select a file you want to change</span>
									</div>
									<div class="box-body">
										<div id="aceEditor" class="ace-editor"></div>
										<div class="form-actions" style="margin-top: 10px">
											<div class="row-fluid">
												<div class="span6"></div>
												<div class="span6">
													<select id="mode" data-form="select2" style="width:200px" data-placeholder="select mode">
                                                    	<option></option>
                                                    </select>
                                                    <select id="theme" data-form="select2" style="width:200px" data-placeholder="select theme">
                                                                <option></option>
                                                                <optgroup label="Bright">
                                                                    <option value="ace/theme/chrome">Chrome</option>
                                                                    <option value="ace/theme/clouds">Clouds</option>
                                                                    <option value="ace/theme/eclipse">Eclipse</option>
                                                                    <option value="ace/theme/github">GitHub</option>
                                                                </optgroup>
                                                                <optgroup label="Dark">
                                                                    <option value="ace/theme/clouds_midnight">Clouds Midnight</option>
                                                                    <option value="ace/theme/cobalt">Cobalt</option>
                                                                    <option value="ace/theme/idle_fingers">idleFingers</option>
                                                                    <option value="ace/theme/merbivore_soft">Merbivore Soft</option>
                                                                    <option value="ace/theme/mono_industrial">Mono Industrial</option>
                                                                    <option value="ace/theme/monokai">Monokai</option>
                                                                    <option value="ace/theme/pastel_on_dark">Pastel on dark</option>
                                                                    <option value="ace/theme/solarized_dark">Solarized Dark</option>
                                                                    <option value="ace/theme/twilight">Twilight</option>
                                                                    <option value="ace/theme/tomorrow_night">Tomorrow Night</option>
                                                                    <option value="ace/theme/vibrant_ink">Vibrant Ink</option>
                                                                </optgroup>
                                                	</select>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="span2">
								<div class="side-nav">
									<div id="filetree">
									
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
		src='<c:url value="/js/select2/select2.js"></c:url>'></script>
	<script type="text/javascript" charset="utf-8" 
		src='<c:url value="/js/ace/ace.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/holder.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/stilearn-base.js"></c:url>'></script>
	<script type="text/javascript" 
		src='<c:url value="/js/filetree/jqueryFileTree.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/filetree/jquery.easing.js"></c:url>'></script>
		
	<script type="text/javascript">
            
            $(document).ready(function() {
                // try your js
                
                // uniform
                $('[data-form=uniform]').uniform()
                
                // select2
                $('[data-form=select2]').select2();
                
                // ace editor
                // mode name list
                var modesByName = {
                    asciidoc:   ["AsciiDoc"     , "asciidoc"],
                    c9search:   ["C9Search"     , "c9search_results"],
                    coffee:     ["CoffeeScript" , "coffee|^Cakefile"],
                    coldfusion: ["ColdFusion"   , "cfm"],
                    csharp:     ["C#"           , "cs"],
                    css:        ["CSS"          , "css"],
                    diff:       ["Diff"         , "diff|patch"],
                    glsl:       ["Glsl"         , "glsl|frag|vert"],
                    golang:     ["Go"           , "go"],
                    groovy:     ["Groovy"       , "groovy"],
                    haxe:       ["haXe"         , "hx"],
                    html:       ["HTML"         , "htm|html|xhtml"],
                    c_cpp:      ["C/C++"        , "c|cc|cpp|cxx|h|hh|hpp"],
                    clojure:    ["Clojure"      , "clj"],
                    jade:       ["Jade"         , "jade"],
                    java:       ["Java"         , "java"],
                    jsp:        ["JSP"                , "jsp"],
                    javascript: ["JavaScript"   , "js"],
                    json:       ["JSON"         , "json"],
                    jsx:        ["JSX"          , "jsx"],
                    latex:      ["LaTeX"        , "latex|tex|ltx|bib"],
                    less:       ["LESS"         , "less"],
                    liquid:     ["Liquid"       , "liquid"],
                    lua:        ["Lua"          , "lua"],
                    luapage:    ["LuaPage"      , "lp"], // http://keplerproject.github.com/cgilua/manual.html#templates
                    markdown:   ["Markdown"     , "md|markdown"],
                    ocaml:      ["OCaml"        , "ml|mli"],
                    perl:       ["Perl"         , "pl|pm"],
                    pgsql:      ["pgSQL"        , "pgsql"],
                    php:        ["PHP"          , "php|phtml"],
                    powershell: ["Powershell"   , "ps1"],
                    python:     ["Python"       , "py"],
                    ruby:       ["Ruby"         , "ru|gemspec|rake|rb"],
                    scad:       ["OpenSCAD"     , "scad"],
                    scala:      ["Scala"        , "scala"],
                    scss:       ["SCSS"         , "scss|sass"],
                    sh:         ["SH"           , "sh|bash|bat"],
                    sql:        ["SQL"          , "sql"],
                    svg:        ["SVG"          , "svg"],
                    tcl:        ["Tcl"          , "tcl"],
                    text:       ["Text"         , "txt"],
                    textile:    ["Textile"      , "textile"],
                    typescript: ["Typescript"   , "typescript|ts|str"],
                    xml:        ["XML"          , "xml|rdf|rss|wsdl|xslt|atom|mathml|mml|xul|xbl"],
                    xquery:     ["XQuery"       , "xq"]
                };
                
                var editor = ace.edit("aceEditor");
                editor.getSession().setMode("ace/mode/javascript");
                
                $('#filetree').fileTree({ root: '/', script: 'jqueryFileTree' }, function(file) {
					alert(file);
				});
                
                // append mode
                $.each(modesByName, function(k, v){
                    $('#mode').append('<option value="'+k+'">'+v[0]+'</option>'); // if you use chosen you need update list .trigger("liszt:updated");
                })
                
                $('#data-files').change(function(){
                    var url = '/js/ace-editor/file-changer.php',
                    value = $(this).val();
                    $.post(url, {data:value}, function(o){
                        if(o == '0'){
                            alert('file not found, may be broken.')
                        }
                        else{
                            editor.setValue(o, 0);
                        }
                    })
                    
                })
                $('#mode').change(function(){
                    mode = $(this).val();
                    editor.getSession().setMode("ace/mode/"+mode+"");
                })
                $('#theme').change(function(){
                    theme = $(this).val();
                    editor.setTheme(theme);
                })
                $('#update').click(function(){
                    alert('action update here... :)')
                    return false;
                })
            });
            
        </script>
</body>

</html>