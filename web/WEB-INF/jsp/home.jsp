<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/3
  Time: 10:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>主界面</title>
    <script src="http://localhost:8888/jquery.js"></script>
    <jsp:include page="../../index.jsp"></jsp:include>
    <style>
        #caidan li {
            width: 100%;
            line-height: 60px;
            text-align: center;
        }

        #caidan a {
            text-decoration: none;
            color: black;
        }

        #caidan li:hover {
            background-color: #D0E5F5;
            color: #D0E5F5;
        }

        #caidan a:hover {
            color: blue;
            text-decoration: blue;
        }
    </style>
</head>
<body class="easyui-layout">
<div data-options="region:'north',split:true" style="height:100px;background-color: aquamarine;text-align:center">
    <h1>管理员界面</h1>
</div>
<div data-options="iconCls:'icon-ok',region:'west',title:'菜单栏',split:true" style="width:250px;">
    <div title="Base" id="caidan" fit="true" class="easyui-accordion">
        <div title="员工管理" style="overflow:auto;padding:0;">
            <ul style="list-style-type:none;padding: 0">
                <li>
                    <a href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">效果预览</a>
                </li>
                <li>
                    <a href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">效果预览</a>
                </li>
                <li>
                    <a href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">效果预览</a>
                </li>
                <li>
                    <a href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">效果预览</a>
                </li>
                <li>
                    <a href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">效果预览</a>
                </li>
            </ul>
        </div>
        <div title="标题2" style="padding:10px;">

        </div>
        <div title="标题3" style="padding:10px;">

        </div>
    </div>
</div>
<div data-options="region:'center',title:'操作区'" style="background:#eee;">
    <div id="tabs" class="easyui-tabs" fit="true">
        <div title="首页">
            <h1>欢迎到来，今天有哪些任务呢？</h1>
        </div>
    </div>
</div>
<div data-options="region:'south'" style="text-align:center">版权所有：宏图18级开发1班</div>

</body>
<script>
    var qid = "sy";
    var shang = null;

    function qiehuan(id2) {
        var id = $(id2).parent();
        if(shang == null){
            shang = id;
            id.css('background-color','#FBEC88');
            id.css('border-radius','0 40px 40px 0');
        }else {
            shang.css("background-color","");
            shang.css("border-radius","");
            shang = id;
            id.css('background-color','#FBEC88');
            id.css('border-radius','0 40px 40px 0');
        }
    }

    $(function() {
        $('.cs-navi-tab').click(function() {
            var $this = $(this);
            var href = $this.attr('src');
            var title = $this.text();
            addTab(title, href);
        });
    });
    function addTab(title, url) {
        if ($('#tabs').tabs('exists', title)) { //如果存在
            $('#tabs').tabs('select', title); //让标签页选中

            var currTab = $('#tabs').tabs('getSelected'); //获取当前选中的选项页(返回panel对象)
            var url = $(currTab.panel('options').content).attr('src');
            if (url != undefined && currTab.panel('options').title != 'Home') {
                $('#tabs').tabs('update', {
                    tab: currTab,
                    options: {
                        content: createFrame(url)
                    }
                })
            }
        } else { //如果这个标题的选项卡不存在
            var content = createFrame(url);
            $('#tabs').tabs('add', {
                title: title, //标题
                content: content, //内容
                closable: true //显示关闭按钮
            });
        }
        tabClose();
    }

    function createFrame(url) { //创建窗口
        var s = '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:99%;"></iframe>';
        return s;
    }

    function tabClose() {
        $(".tabs-inner").dblclick(function() {
            var subtitle = $(this).children(".tabs-closable").text();
            $('#tabs').tabs('close', subtitle);
        })
    }
</script>
</html>
