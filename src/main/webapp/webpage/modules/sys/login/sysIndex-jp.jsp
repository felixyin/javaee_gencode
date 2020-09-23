<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="renderer" content="webkit">
	<title>${fns:getConfig('productName')}</title>
	<meta name="decorator" content="ani"/>
	<link href="${ctxStatic}/common/css/jp-menu.css" rel="stylesheet" />

	<script src="${ctxStatic}/plugin/js-menu/contabs.js"></script>
	<link id="theme-tab" href="${ctxStatic}/plugin/js-menu/menuTab-${cookie.theme.value==null?'blue':cookie.theme.value}.css" rel="stylesheet" />

<%--	<%@ include file="/webpage/include/systemInfoSocket-init.jsp"%>--%>
<%--	<%@ include file="/webpage/include/layIM-init.jsp"%>--%>
<style>
	.push-right #sidebar-nav{
	  display:block;
	}
	.navbar-inverse .navbar-toggle:hover, .navbar-inverse .navbar-toggle:focus {
		 background-color: transparent !important;
	}
	.navbar-inverse .navbar-toggle {
		 border-color: transparent !important;
	}
</style>

</head>

<body class="${cookie.white.value}  jp-hr">
<nav class="navbar navbar-inverse display-default opnav-navbar navbar-fixed-top" role="navigation">
	<div class="topnav-navbar">
		<div class="navbar-header text-center">
			<button type="button" class="navbar-toggle" id="showMenu">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>

			<a class="navbar-brand J_menuItem" href="${ctx}/home" data-index="0">Qdqtrj 代码生成服务</a>
		</div>
	</div>

</nav>

<aside id="sidebar">
	<div class="tab-content">
				<div id="page-wrapper"> <!--class="nav-small"-->
						<div id="nav-col" class="nav-col">
							<section id="col-left" class="nano">
								<div id="col-left-inner" class="nano-content">
									<div class="collapse navbar-collapse navbar-ex1-collapse tab-content" id="sidebar-nav">
										<t:jpMenu  menu="${fns:getTopMenu()}" position="left"></t:jpMenu>
									</div>
								</div>
							</section>
						</div>
				</div>

	</div>

</aside>
<section id="body-container" class="animation">


	<!--选项卡  -->
	<div class="main-container" id="main-container">
		<div class="main-content">
			<div class="main-content-inner">
				<div id="breadcrumbs" class="${cookie.tab.value!=false?'breadcrumbs':'un-breadcrumbs'}">
					<div class="content-tabs">
						<a id="hideMenu" class="roll-nav roll-left-0 J_tabLeft"><i class="fa fa-align-justify"></i>
						</a>
						<button class="roll-nav roll-left J_tabLeft"><i class="fa fa-backward"></i>
						</button>
						<nav class="page-tabs J_menuTabs">
							<div class="page-tabs-content">
								<a href="javascript:;" class="active J_menuTab" data-id="${ctx}/gen/genTable">表单配置</a>
							</div>
						</nav>
						<button class="roll-nav roll-right J_tabRight"><i class="fa fa-forward"></i>
						</button>
						<a href="${ctx}/logout" class="roll-nav roll-right J_tabExit"><i class="fa fa fa-sign-out"></i> 退出</a>
					</div>
				</div>

				<div class="J_mainContent"  id="content-main" style="${cookie.tab.value!=false?'height:calc(100% - 40px)':'height:calc(100%)'}">
					<iframe class="J_iframe" name="iframe0" width="100%" height="100%" src="${ctx}/gen/genTable" frameborder="0" data-id="${ctx}/gen/genTable" seamless></iframe>
				</div>
			</div>


		</div>
	</div>

	<div class="footer">
		<div class="pull-left"><a href="http://www.qdqtrj.com">http://www.qdqtrj.com</a> &copy; 2015-2025</div>
	</div>

</section>




<script>


    $(function(){
        $.addtabs.drop();
        $('#showMenu').click(function() {
            $('body').toggleClass('push-right');
        });
        $('#hideMenu').click(function () {
			$('#page-wrapper').toggleClass('nav-small');
            $('#col-left').toggleClass('nano');
            $('body').removeClass('push-right')
            $('body').toggleClass('push-left');
        });

        $('#showTab').click(function () {
            $('#showTab').parent().toggleClass("active")
            $('#closeTab').parent().toggleClass("active")
            $("#breadcrumbs").attr("class","breadcrumbs");
            $("#content-main").css("height","calc(100% - 40px)")
            $.get('${ctx}/tab/true?url='+window.top.location.href,function(result){  });
        });

        $('#closeTab').click(function () {
            $('#showTab').parent().toggleClass("active")
            $('#closeTab').parent().toggleClass("active")
            $("#breadcrumbs").attr("class","un-breadcrumbs");
            $("#content-main").css("height","calc(100%)")
            $.get('${ctx}/tab/false',function(result){  });
        });

        $(".theme-icons label").click(function () {
            $("#theme-font").remove();
            $(this).append('<i id="theme-font" class=" anticon anticon-check ng-star-inserted fa fa-check "></i>');
            changeTheme($(this).attr('data-theme'));
        })

    });
    /**
     *切换主题
     */
    function changeStyle(){
        $.get('${ctx}/style/default',function(result){
            window.location.reload();
        });
    }
    /**
     * 切换颜色
     * @param theme
     */
    function changeTheme(style_theme) {
        var style = style_theme.split("_")[0];
        var theme = style_theme.split("_")[1];
        if(style == "black"){
            $("body").removeClass("theme-whbl");
		}else{
            $("body").addClass("theme-whbl");
		}
        var link = $('<link>')
            .appendTo('head')
            .attr({type : 'text/css', rel : 'stylesheet'})
            .attr('href', '${ctxStatic}/common/css/app-'+theme+'.css');


        var tabLink = $('<link>')
            .appendTo('head')
            .attr({type : 'text/css', rel : 'stylesheet'})
            .attr('href', '${ctxStatic}/plugin/js-menu/menuTab-'+theme+'.css');

        var childrenLink= $('<link>').appendTo($(".J_iframe").contents().find("head"))
            .attr({type : 'text/css', rel : 'stylesheet'})
            .attr('href', '${ctxStatic}/common/css/app-'+theme+'.css');

        $.get('${ctx}/theme/'+style_theme,function(result){
            setTimeout(function () {
                $('#theme').remove();
                $('#theme-tab').remove();
                $(".J_iframe").contents().find("#theme").remove();
            }, 500);
            link.attr("id","theme");
            childrenLink.attr("id","theme");
            tabLink.attr("id","theme-tab")
        });

    }
    $(function ($) {
        $('#sidebar-nav  a').on('click', function (e) {
			  var _this = $(this);
             $('#sidebar-nav  a').each(function(){
                 if($(this) != _this){
                     if($(this).hasClass("active")){
                         $(this).removeClass("active");
					 }
				 }

             });
             if(!_this.hasClass("active")){
                 _this.addClass("active")
                 _this.parent("li.open").find("a").first().addClass("active");
			 }


        });
        $('#sidebar-nav .dropdown-toggle').on('click', function (e) {
            e.preventDefault();
            var $item = $(this).parent();
            if (!$item.hasClass('open')) {
                $item.parent().find('.open .submenu').slideUp('fast');
                $item.parent().find('.open').toggleClass('open');
            }
            $item.toggleClass('open');
            if ($item.hasClass('open')) {
                $item.children('.submenu').slideDown('fast');
            }
            else {
                $item.children('.submenu').slideUp('fast');
            }
            if ($("#user-menu").parent().hasClass('open')) {
                $("#user-menu").slideUp('fast');
                $("#user-menu").parent().toggleClass('open');
            }
        });
        $('#user-link').on('click',function () {
            var $item = $("#user-menu");
            $item.parent().toggleClass('open');
            if ($item.parent().hasClass('open')) {
                $item.slideDown('fast');
            }
            else {
                $item.slideUp('fast');
            }
			$("#sidebar-nav .tab-pane").find('.open .submenu').slideUp('fast');
			$("#sidebar-nav .tab-pane").find('.open').toggleClass('open');


        })
        $('body').on('mouseenter', '#page-wrapper.nav-small #sidebar-nav .dropdown-toggle', function (e) {
            var $sidebar = $(this).parents('#sidebar-nav');
            if ($(document).width() >= 992) {
                var $item = $(this).parent();
                $item.addClass('open');
                $item.children('.submenu').slideDown('fast');
            }
        });
        $('body').on('mouseleave', '#page-wrapper.nav-small #sidebar-nav > div > .nav-pills > li', function (e) {
            var $sidebar = $(this).parents('#sidebar-nav');
            if ($(document).width() >= 992) {
                var $item = $(this);
                if ($item.hasClass('open')) {
                    $item.find('.open .submenu').slideUp('fast');
                    $item.find('.open').removeClass('open');
                    $item.children('.submenu').slideUp('fast');
                }
                $item.removeClass('open');
            }
        });


    });


</script>
</body>
</html>