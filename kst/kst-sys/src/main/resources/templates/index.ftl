<!DOCTYPE html>
<html>
<head>
    <#import "spring.ftl" as spring />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${projectName}</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/skins/all-skins.min.css">
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <!--http://aimodu.org:7777/admin/index_iframe.html?q=audio&search=#-->
    <style type="text/css">
        /*html {*/
        /*overflow: hidden;*/
        /*}*/

        body {
            -ms-overflow-style: scrollbar;
        }
    </style>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

    <header class="main-header">
        <!-- Logo -->
        <#--<a href="../index2.html" class="logo">-->
        <a href="javascript:void(0)" class="logo">
            <!-- mini logo for sidebar mini 50x50 pixels -->
            <span class="logo-mini">${adminText}</span>
            <!-- logo for regular state and mobile devices -->
            <span class="logo-lg"><p>${adminText}</p></span>
        </a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top">
            <!-- Sidebar toggle button-->
            <a href="javascript:void(0)" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>
            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a href="javascript:void(0)" class="dropdown-toggle" data-toggle="dropdown">
                            <cite><@spring.message "sys.message.language"/></cite>
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu" style="min-width: 100px;">
                            <li><a href="index?l=zh_CN">中文</a></li>
                            <li><a href="index?l=en_US">English</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="javascript:void(0)" class="dropdown-toggle" data-toggle="dropdown">
                            <img src="<#if (currentUser.icon??)>${base}${currentUser.icon}<#else>${base}/static/AdminLTE/img/user2-160x160.jpg</#if>"
                                 style="float: left;width: 25px;height: 25px;border-radius: 50%;margin-right: 10px;margin-top: -2px;">
                            <cite><#if currentUser.nickName!''>${currentUser.nickName}<#else>${currentUser.loginName}</#if></cite>
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="javascript:userInfo()"
                                   class="fa fa-address-card-o">&nbsp;&nbsp;<@spring.message "sys.index.personalData" /></a>
                            </li>
                            <li><a href="javascript:changePassword()"
                                   class="fa fa-key">&nbsp;&nbsp;<@spring.message "sys.index.changePassword" /></a></li>
                            <li class="divider"></li>
                            <li><a href="${base}/systemLogout"
                                   class="fa fa-power-off">&nbsp;&nbsp;<@spring.message "sys.index.exit" /></a></li>
                        </ul>
                    </li>
                    <!-- Control Sidebar Toggle Button -->
                    <li>
                        <a href="javascript:void(0)" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
                    </li>
                </ul>
            </div>
        </nav>
    </header>
    <!-- Left side column. contains the logo and sidebar -->
    <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
            <!-- Sidebar user panel -->
            <div class="user-panel">
                <div class="pull-left image">
                    <img src="<#if (currentUser.icon??)>${currentUser.icon}<#else>${base}/static/AdminLTE/img/user2-160x160.jpg</#if>"
                         class="img-circle" alt="User Image">
                </div>
                <div class="pull-left info">
                    <p><#if currentUser.nickName!''>${currentUser.nickName}<#else>${currentUser.loginName}</#if></p>
                    <a href="javascript:void(0)"><i
                                class="fa fa-circle text-success"></i> <@spring.message "sys.index.online" /></a>
                </div>
            </div>
            <!-- search form -->
            <form action="#" method="get" class="sidebar-form">
                <div class="input-group">
                    <input type="text" name="q" class="form-control" placeholder="Search...">
                    <span class="input-group-btn">
                <button type="button" name="search" id="search-btn" class="btn btn-flat" onclick="search_menu()"><i
                            class="fa fa-search"></i>
                </button>
              </span>
                </div>
            </form>
            <!-- /.search form -->
            <!-- sidebar menu: : style can be found in sidebar.less -->
            <ul class="sidebar-menu">
            </ul>
        </section>
        <!-- /.sidebar -->
    </aside>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper" id="content-wrapper" style="min-height: 421px;">
        <!--bootstrap tab风格 多标签页-->
        <div class="content-tabs">
            <button class="roll-nav roll-left tabLeft" onclick="scrollTabLeft()">
                <i class="fa fa-backward"></i>
            </button>
            <nav class="page-tabs menuTabs tab-ui-menu" id="tab-menu">
                <div class="page-tabs-content" style="margin-left: 0px;">

                </div>
            </nav>
            <button class="roll-nav roll-right tabRight" onclick="scrollTabRight()">
                <i class="fa fa-forward" style="margin-left: 3px;"></i>
            </button>
            <div class="btn-group roll-nav roll-right">
                <button class="dropdown tabClose" data-toggle="dropdown">
                    <@spring.message "sys.index.tabOperation" /><i class="fa fa-caret-down"
                                                                   style="padding-left: 3px;"></i>
                </button>
                <ul class="dropdown-menu dropdown-menu-right" style="min-width: 128px;">
                    <li><a class="tabReload"
                           href="javascript:refreshTab();"><@spring.message "sys.index.refreshCurrent" /></a></li>
                    <li><a class="tabCloseCurrent"
                           href="javascript:closeCurrentTab();"><@spring.message "sys.index.closeCurrent" /></a></li>
                    <li><a class="tabCloseAll"
                           href="javascript:closeOtherTabs(true);"><@spring.message "sys.index.closeAll" /></a></li>
                    <li><a class="tabCloseOther"
                           href="javascript:closeOtherTabs();"><@spring.message "sys.index.closeOther" /></a></li>
                </ul>
            </div>
            <button class="roll-nav roll-right fullscreen" onclick="App.handleFullScreen()"><i
                        class="fa fa-arrows-alt"></i></button>
        </div>
        <div class="content-iframe" style="background-color: #ffffff; ">
            <div class="tab-content " id="tab-content">

            </div>
        </div>
    </div>
    <!-- /.content-wrapper -->

    <footer class="main-footer">
        <div class="pull-right hidden-xs">
            <b>Version</b> 1.0.0
        </div>
        <strong>Copyright &copy; 2006-2019 <a href="http://almsaeedstudio.com">Koshida Shanghai</a>.</strong> All rights
        reserved.
    </footer>

</div>
<!-- ./wrapper -->

<!-- jQuery 2.2.3 -->
<script src="${base}/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="${base}/static/bootstrap/js/bootstrap.min.js"></script>
<!-- Slimscroll -->
<script src="${base}/static/plugins/slimScroll/jquery.slimscroll.min.js"></script>

<script src="${base}/static/plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="${base}/static/AdminLTE/js/app.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="${base}/static/AdminLTE/js/demo.js"></script>
<!--tabs-->
<script src="${base}/static/AdminLTE/js/app_iframe.js"></script>
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<script type="text/javascript">
    /**
     * 本地搜索菜单
     */
    function search_menu() {
        //要搜索的值
        var text = $('input[name=q]').val();

        var $ul = $('.sidebar-menu');
        if(text!=null && text!=""){
            $ul.find("a.nav-link").each(function () {
                var $a = $(this).css("border", "");

                //判断是否含有要搜索的字符串
                if ($a.children("span.menu-text").text().indexOf(text) >= 0) {
                    //如果a标签的父级是隐藏的就展开
                    $ul = $a.parents("ul");
                    if ($ul.is(":hidden")) {
                        $a.parents("ul").prev().click();
                    }
                    //点击该菜单
                    $a.click().css("border", "1px solid");
                }
            });
        }
    }

    var defaultLength = 0;
    $(function () {
//        console.log(window.location);
        toastr.options.positionClass = 'toast-center-center';

        App.setbasePath("${base}/");
        App.setGlobalImgPath("${base}/static/AdminLTE/img/");
        addTabs({
            id: '10008',
            title: '<@spring.message "sys.index.main" />',
            close: false,
            height: 800,
            href: '${base}/sys/user/home',
            urlType: "relative"
        });

        defaultLength = $("#content-wrapper").height();
        App.fixIframeCotent();

        var url = "${base}/sys/user/getUserMenu";
        $.get(url, function (strData) {

            //显示左侧菜单
            var data;
            if (typeof (strData) === "string") {
                var data = JSON.parse(strData); //部分用户解析出来的是字符串，转换一下
            } else {
                data = strData;
            }
            $('.sidebar-menu').sidebarMenu({data: data});

        });

        // 动态创建菜单后，可以重新计算 SlimScroll
        $.AdminLTE.layout.fixSidebar();

        // if ($.AdminLTE.options.sidebarSlimScroll) {
        //     if (typeof $.fn.slimScroll != 'undefined') {
        //         //Destroy if it exists
        //         var $sidebar = $(".sidebar");
        //         $sidebar.slimScroll({destroy: true}).height("auto");
        //         //Add slimscroll
        //         $sidebar.slimscroll({
        //             height: ($(window).height() - $(".wrapper").height()) + "px",
        //             color: "rgba(0,0,0,0.2)",
        //             size: "3px"
        //         });
        //     }
        // }
        $(".sidebar").click(function () {
            setTimeout(function () {
                var height = $(".sidebar").height()-$(".logo").height();
                if (defaultLength >= height) {
                    height = defaultLength;
                }

                $("#tab-content").height(height);
                $(".tab-pane").height(height);
                $(".tab_iframe").height(height);
                $("body").height(height);
            }, 500);
        })


    });

    //修改密码
    function changePassword() {
        addTabs({
            id: 'changePassword',
            title: '<@spring.message "sys.index.changePassword" />',
            close: true,
            href: '${base}/sys/user/changePassword',
            urlType: "relative"
        });
    }

    //修改个人资料
    function userInfo() {
        addTabs({
            id: 'userInfo',
            title: '<@spring.message "sys.index.personalData" />',
            close: true,
            href: '${base}/sys/user/userinfo',
            urlType: "relative"
        });
    }
</script>

</body>
</html>