<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
        <meta http-equiv="content-type" content="text/html; charset=utf-8">

        <script type="text/javascript">
            <#-- 一些从后台初始化的js数据可以放这里 -->
            window.ctx = '${ctx!""}';
        </script>

        <title>Cory简单框架</title>
        <link rel="stylesheet" type="text/css" href="/static/css/jquery.dialog.css" />
        <link rel="stylesheet" type="text/css" href="/static/css/jquery.treetable.css" />
        <link rel="stylesheet" type="text/css" href="/static/css/jquery.treetable.theme.default.css" />
        <link rel="stylesheet" href="/static/css/frame.css" />
        <link rel="stylesheet" href="/static/css/my.css" />

        <script src="/static/js/jquery.min.js"></script>
        <script src="/static/js/frame.js"></script>
    </head>
    <body>
    <div id="container">
        <div id="hd">
            <div class="hd-wrap ue-clear">
                <div class="top-light"></div>
                <h1 class="logo">你好</h1>
                <div class="login-info ue-clear">
                    <div class="welcome ue-clear"><span>欢迎使用Cory简单框架</span></div>
                </div>
            </div>
        </div>
        <div id="bd">
            <div class="wrap ue-clear">
                <div class="sidebar">
                    <h2 class="sidebar-header"><p>功能导航</p></h2>
                    <ul class="nav">
                        <li class="nav-item office">
                            <div class="nav-header">
                                <a href="/my_page/index" class="ue-clear"><span>首页</span><i class="icon"></i></a>
                            </div>
                        </li>
                        <li class="nav-item lock">
                            <div class="nav-header">
                                <a href="javascript:void(0);" class="ue-clear" ><span>主菜单一</span><i class="icon hasChild"></i></a>
                            </div>
                            <ul class="subnav">
                                <li><a href="/my_page/table">表格示例</a></li>
                                <li><a href="/my_page/blank1">子菜单一</a></li>
                                <li><a href="/my_page/blank2">子菜单二</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dossier">
                            <div class="nav-header">
                                <a href="javascript:void(0);" class="ue-clear" ><span>主菜单二</span><i class="icon hasChild"></i></a>
                            </div>
                            <ul class="subnav">
                                <li><a href="/my_page/blank3">子菜单三</a></li>
                                <li><a href="/my_page/blank4">子菜单四</a></li>
                            </ul>
                        </li>
                        <li class="nav-item part">
                            <div class="nav-header">
                                <a href="javascript:void(0);" class="ue-clear" ><span>系统设置</span><i class="icon hasChild"></i></a>
                            </div>
                            <ul class="subnav">
                                <li><a href="/my_page/setting">系统设置</a></li>
                                <li><a href="/my_page/test">测试页面</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div class="global-toast"></div>
                <div class="global-content">
                    <div class="global-title"><h2></h2></div>
                    <div class="global-container">