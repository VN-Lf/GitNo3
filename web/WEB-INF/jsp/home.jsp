<%@ page import="com.nothing.vo.emp.Emp" %><%--
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
    <script src="${pageContext.request.contextPath}/jquery.js"></script>
    <jsp:include page="../../index.jsp"></jsp:include>
    <% Emp use = (Emp) session.getAttribute("empId");%>
    <!--dark-hive 纯黑   gray 灰色 pepper-grinder咖啡色-->
    <%String yangshi = (String) session.getAttribute("color");%>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath }/jquery-easyui-1.3.0/themes/<%=yangshi%>/easyui.css" />
    <style>
        #caidan li {
            width: 100%;
            line-height: 60px;
            text-align: center;
            cursor:pointer;
        }

        #caidan a{
            text-decoration: none;
            font-size: 16px;
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
<div data-options="region:'north',split:true" style="height:60px;background-color: aquamarine;text-align:center">
    <h1>管理员界面</h1>
</div>
<div data-options="iconCls:'icon-ok',region:'west',title:'菜单栏',split:true" style="width:250px;">
    <div title="Base" id="caidan" fit="true" style="height: 16px;font-size: 16px" class="easyui-accordion">
        <div title="个人中心" style="overflow:auto;padding:0;">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a style="color: aquamarine">我的邮件</a>
                </li>
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/myJobList" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>请假相关</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: aquamarine">学生请假</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: aquamarine">考勤管理</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: aquamarine">离职申请</a>
                </li>
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/to/end" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a href="JavaScript:parent.window.location.href= '/to/tologin';" style="color: red">退出登录</a>
                </li>
            </ul>
        </div>
        <div title="通知面板" style="overflow:auto;padding:0;">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/to/tonotice" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a>公告发布</a>
                </li>
            </ul>
        </div>
        <div title="员工管理" style="overflow:auto;padding:0;">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/to/toempzl" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>员工资料</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a style="color: aquamarine">周报管理</a>
                </li>
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/Weekly/toWeeklyCollect" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>周报汇总--审阅</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: aquamarine">谈心记录</a>
                </li>
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/myTask" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>员工请假管理-上级可看</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: aquamarine">考勤管理-上级可看</a>
                </li>
            </ul>
        </div>
        <div title="学员管理" style="list-style-type:none;padding: 0">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/stu/home" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a>学生资料</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: aquamarine">学生请假</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: aquamarine">考试成绩</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: aquamarine">答辩成绩</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: aquamarine">班级分配</a>
                </li>
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/dormitory/todormitory" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>宿舍管理</a>
                </li>
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/Building/toys" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>楼栋管理</a>
                </li>
            </ul>
        </div>
        <div title="教务管理" style="overflow:auto;padding:0;">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: aquamarine">课程类别</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: aquamarine">课程管理</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: aquamarine">试讲培训</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: aquamarine">值班管理</a>
                </li>
            </ul>
        </div>
        <div title="后勤管理" style="overflow:auto;padding:0;">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/to/toRepairListPage" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a>报修申请</a>
                </li>
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/to/toRepairListPage" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: aquamarine">维修管理</a>
                </li>
            </ul>
        </div>
        <div title="考核管理" style="list-style-type:none;padding: 0">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/exam/examlist" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>考核指标（日常考核）</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: aquamarine">考核录入</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: aquamarine">考评内容</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: red">教师考评*</a>
                </li>
            </ul>
        </div>
        <div title="财务管理" style="list-style-type:none;padding: 0">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="" class="cs-navi-tab">
                    <a style="color: aquamarine">学费管理</a>
                </li>
            </ul>
        </div>
        <div title="问题反馈" style="list-style-type:none;padding: 0">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/exam/toexam" class="cs-navi-tab">
                    <a>问题反馈</a>
                </li>
            </ul>
        </div>
        <div title="文件管理" style="overflow:auto;padding:0;">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a style="color: aquamarine">资料文档-文件上传</a>
                </li>
            </ul>
        </div>
        <div title="系统报表" style="overflow:auto;padding:0;">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/to/toempzl" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: aquamarine">日常考核</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a style="color: aquamarine">员工请假</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a style="color: aquamarine">学生请假</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: aquamarine">未打卡说明</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a style="color: aquamarine">宿舍统计报表</a>
                </li>
            </ul>
        </div>
        <div title="系统设置" style="overflow:auto;padding:0;">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/list" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>流程</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a style="color: aquamarine">权限管理</a>
                </li>
            </ul>
        </div>
    </div>
</div>
<div data-options="region:'center',title:'操作区'" style="background:#eee;">
    <div id="tabs" class="easyui-tabs" fit="true">
        <div title="首页">
            <h1>欢迎到来，<%=use.getEmpName()%> 今天有哪些任务呢？</h1>
            <h2 id="time"></h2>
            <!--dark-hive 纯黑   gray 灰色 pepper-grinder咖啡色-->
            换肤
            <select id="ys" onchange="qieColor()">
                <option value="gray" <%if("gray".equals(yangshi)){%>selected<%}%>>灰色框架</option>
                <option value="dark-hive" <%if("dark-hive".equals(yangshi)){%>selected<%}%>>纯黑主题</option>
                <option value="pepper-grinder" <%if("pepper-grinder".equals(yangshi)){%>selected<%}%>>咖啡主题</option>
            </select>
        </div>
    </div>
</div>
<div data-options="region:'south'" style="text-align:center">版权所有：宏图18级开发1班</div>

</body>
<script>
    var shang = null;
    function createXMLHttp(){
        try {
            return new ActiveXObject("Msxm12.XMLHTTP");
        }catch (e){}
        try {
            return new ActiveXObject("Microsoft.XMLHTTP");
        }catch (e){}
        try{
            return new XMLHttpRequest();
        }catch (e){}
        alert("无法打开");
        return null;
    }
    function gettime(){
        var date = new Date();
        var hour = date.getHours();
        var minute = date.getMinutes();
        var second = date.getSeconds();
        document.getElementById("time").innerText=hour+':'+minute+':'+second;
    }
    gettime();
    function qiehuan(id2){
        var id = $(id2);
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
    function qieColor(){
        var type = $("#ys").val();

        window.location.href="${pageContext.request.contextPath}/to/home?color="+type;
    }

    $(function() {
        $('.cs-navi-tab').click(function(){
            var $this = $(this);
            var href = $this.attr('src');
            var title = $this.text();
            addTab(title, href);
        });
    });
    function addTab(title, url){
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

    function createFrame(url){ //创建窗口
        var s = '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:99%;"></iframe>';
        return s;
    }

    function tabClose(){
        $(".tabs-inner").dblclick(function() {
            var subtitle = $(this).children(".tabs-closable").text();
            $('#tabs').tabs('close', subtitle);
        })
    }
</script>
</html>
