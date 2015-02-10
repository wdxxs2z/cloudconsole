<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Logn In - CloudFoundry Console</title>
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
<link rel="stylesheet" href="<c:url value="/css/animate.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/datepicker.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/colorpicker.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/responsive-tables.css"/>" />
<link rel="stylesheet"
	href="<c:url value="/css/bootstrap-wysihtml5.css"/>" />


<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
html {
	background: url('<c:url value="/img/bg.jpg"/>') no-repeat center center fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}

body {
	background: none;
}

.login, .register {
	margin-top: 70px;
	background: rgba(251, 251, 251, 0.5);
	border: 1px solid #ccc;
}
</style>
</head>

<body>
	<header class="header" data-spy="affix" data-offset-top="0">
		<div class="navbar-helper">
			<div class="row-fluid">
				<!--panel site-name-->
				<div class="span2">
					<div class="panel-sitename">
						<h2>
							<span class="color-teal">CloudFoundry</span>Console
						</h2>
					</div>
				</div>
			</div>
		</div>
	</header>

	<section class="section register">
		<div class="container">
			<div class="signin-form row-fluid">
				<!--Register-->
				<div class="span5 offset2">
					<div class="box corner-all">
						<div class="box-header grd-teal color-white corner-top">
							<span>注册CloudFoundry用户</span>
						</div>
						<div class="box-body bg-black" id="form-wizard">
							<form id="wrapped" class="form-horizontal" action="./register_post" method="post" >
								<div class="step">
                                	<div class="control-group">
                                    <label class="control-label" for="registername">请填写您要注册的用户名</label>
                                    	<div class="controls">
                                        	<input type="text" name="registername" class="grd-white" id="registername" 
                                        	data-validate="{required: true, minlength: 4, messages:{required:'请正确填写用户名', minlength:'请输入至少4个字符'}}" />
                                        </div>
                                    </div>
                                	<div class="control-group">
                                	<label class="control-label" for="registeremail">请填写您的注册邮箱</label>
                                		<div class="controls">
                                			<input type="text" name="registeremail" class="grd-white" id="registeremail" 
                                			data-validate="{required: true, email:true, messages:{required:'请您填写邮箱，注意格式', email:'请输入正确的邮箱格式'}}" />
                                		</div>
                               		</div>
                               		<div class="control-group">
                                	<label class="control-label" for="registerpasswd">请填写注册用户密码</label>
                                		<div class="controls">
                                			<input type="password" name="registerpasswd" class="grd-white" id="registerpasswd" data-validate="{required: true,minlength: 6, messages:{required:'请填写至少6位数的密码'}}" />
                                		</div>
                               		</div>
                               		<div class="control-group">
                                	<label class="control-label" for="cpassword">请确认注册用户密码</label>
                                		<div class="controls">
                                			<input type="password" name="cpassword" class="grd-white" id="cpassword" 
                                			data-validate="{required: true, equalTo: '#registerpasswd', messages:{required:'重复上面的密码，注意认真填写', equalTo: '两次密码不一致，请认真填写'}}" />
                                		</div>
                               		</div>
                                </div>
                                
								<div class="step">
                                	<div class="control-group">
                                    <label class="control-label" for="familyname">请填写FamilyName(option)</label>
                                    	<div class="controls">
                                        	<input type="text" name="familyname" class="grd-white" id="familyname" 
                                        	data-validate="{required: false}" />
                                        </div>
                                    </div>
                                    <div class="control-group">
                                    <label class="control-label" for="givenname">请填写GivenName(option)</label>
                                    	<div class="controls">
                                        	<input type="text" name="givenname" class="grd-white" id="givenname" 
                                        	data-validate="{required: false}" />
                                        </div>
                                    </div>
                                    <div class="control-group">
                                    <label class="control-label" for="phonenumber">请填写您的移动电话</label>
                                    	<div class="controls">
                                        	<input type="text" name="phonenumber" class="grd-white" id="phonenumber" 
                                        	data-validate="{required: true,number:true, minlength: 11,messages:{required:'此电话方便部门沟通，请认真填写', number:'请输入正确的11位数字号码'}}" />
                                        </div>
                                    </div>
                               	</div>
                               	
                               	<div class="submit step">
                                	<div class="control-group">
                                    	<p class="help-block">请提交您的申请</p>
                                    </div>
                                </div>
                                <div class="form-actions">
                                	<button type="button" name="backward" class="btn backward">后退查看</button>
                                    <button type="button" name="forward" class="btn forward">继续填写</button>
                                    <button type="submit" name="process" class="btn btn-primary submit">确认注册</button>
                                </div>
							</form>
						</div>
					</div>
				</div>
				<!--/Register-->
			</div>
		</div>
	</section>
</body>
<script type="text/javascript"
		src='<c:url value="/js/widgets.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/jquery.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/jquery-ui.min.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/bootstrap.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/datepicker/bootstrap-datepicker.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/colorpicker/bootstrap-colorpicker.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/uniform/jquery.uniform.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/validate/jquery.validate.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/validate/jquery.metadata.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/wizard/jquery.ui.widget.js"></c:url>'></script>
	<script type="text/javascript"
		src='<c:url value="/js/wizard/jquery.wizard.js"></c:url>'></script>
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
</html>