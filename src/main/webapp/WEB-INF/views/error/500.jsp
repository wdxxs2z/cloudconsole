<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>服务器内部错误 - Cloud Console</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta name="description" content="" />
        <meta name="author" content="stilearning" />

        <!-- google font -->
        <link href="<c:url value="/css/google-css.css"/>" rel="stylesheet" type="text/css" />
        
        <!-- styles -->
        <link rel="stylesheet" href="<c:url value="/css/bootstrap.css"/>" />
        <link rel="stylesheet" href="<c:url value="/css/bootstrap-responsive.css"/>" />
		<link rel="stylesheet" href="<c:url value="/css/stilearn.css"/>" />
		<link rel="stylesheet" href="<c:url value="/css/stilearn-responsive.css"/>" />
		<link rel="stylesheet" href="<c:url value="/css/stilearn-helper.css"/>" />
		<link rel="stylesheet" href="<c:url value="/css/stilearn-icon.css"/>" />
        <link rel="stylesheet" href="<c:url value="/css/font-awesome.css"/>" />
		<link rel="stylesheet" href="<c:url value="/css/animate.css"/>" />
        
        <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>

    <body>
        <!-- section header -->
        <header class="header" data-spy="affix" data-offset-top="0">
            <!--nav bar helper-->
            <div class="navbar-helper">
                <div class="row-fluid">
                    <!--panel site-name-->
                    <div class="span2">
                        <div class="panel-sitename">
                            <h2><a href="./home"><span class="color-teal">CloudFoundry</span>Console</a></h2>
                        </div>
                    </div>
                    <!--/panel name-->
                </div>
            </div><!--/nav bar helper-->
        </header>
        
        <!-- section content -->
        <section class="section">
            <div class="container">
                <div class="error-page">
                    <h1 class="error-code color-red">Error 500</h1>
                    <p class="error-description muted">我们的服务器可能是出错啦，或者是由于您的权限不够，请求页面没有执行权限</p>
                    <form action="#">
                        <div class="control-group">
                            <div class="input-append input-icon-prepend">
                                <div class="add-on">
                                    <a title="search" style="" class="icon"><i class="icofont-search"></i></a>
                                    <input class="input-xxlarge animated grd-white" type="text" placeholder="您想找什么呢？" />
                                </div>
                                <input type="submit" class="btn" value="Search" />
                            </div>
                        </div>
                    </form>
                    <a href="./home" class="btn btn-small btn-primary"><i class="icofont-arrow-left"></i> 返回到主页面</a>
                    <a href="./home" target="_blank" class="btn btn-small btn-success">返回到主页面 <i class="icofont-arrow-right"></i></a>
                </div>
            </div>
        </section>

        <!-- section footer -->
        <footer>
            <a rel="to-top" href="#top"><i class="icofont-circle-arrow-up"></i></a>
        </footer>

        <!-- javascript
        ================================================== -->
        <script type="text/javascript" src='/cloudconsole/js/widgets.js'></script>
        <script type="text/javascript" src='/cloudconsole/js/jquery.js'></script>
        <script type="text/javascript" src='/cloudconsole/js/bootstrap.js'></script>
        
        <script type="text/javascript">
            $(document).ready(function() {
                // try your js
                
            })
        </script>
    </body>
</html>