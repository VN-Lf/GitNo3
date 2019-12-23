<%@ page import="com.nothing.vo.Sdudent.Student" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/3
  Time: 10:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>学生端</title>
    <jsp:include page="../../index.jsp"></jsp:include>
    <%String yangshi = (String) session.getAttribute("color");%>
    <% Student use = (Student) session.getAttribute("stuId");%>
    <!--dark-hive 纯黑   gray 灰色 pepper-grinder咖啡色-->
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
            <%if("dark-hive".equals(yangshi)){%>
                color: white;
            <%}else {%>
            color: black;
            <%}%>
        }

        #caidan li:hover {
            <%if("dark-hive".equals(yangshi)){%>
                background-color: #0972a5;
            <%}else {%>
                background-color: #D0E5F5;
            <%}%>
            color: #D0E5F5;
        }

        #caidan a:hover {
        <%if("dark-hive".equals(yangshi)){%>
            color: white;
        <%}else {%>
            color: black;
        <%}%>
        }
        .hometop{
            height:80px;
            text-align:center;
        <%if("dark-hive".equals(yangshi)){%>
            background-color:black;
            color: white;
        <%}else {%>
            background-color: white;
            color: black;
        <%}%>
        }
        .emptask{
            height: 65px;
            width: 95%;
            margin: 30px auto;
            padding:10px 0 10px 15px;
        <%if("dark-hive".equals(yangshi)){%>
            background-color: #9F9F9F;
        <%}else {%>
            background-color: #f1f1f1;
        <%}%>
            border-radius: 8px;
            transition: 0.5s;
        }
        .pzuo{
            font-size: 16px;
            padding:5px 30px;
        <%if("dark-hive".equals(yangshi)){%>
            background-color: #9F9F9F;
        <%}else {%>
            background-color: #f1f1f1;
        <%}%>
            border-radius: 10px 10px 0 0;
        }
        .pyou{
            font-size: 14px;
            padding:5px 30px;
        <%if("dark-hive".equals(yangshi)){%>
            background-color: #9F9F9F;
        <%}else {%>
            background-color: #f1f1f1;
        <%}%>
            border-radius: 0 0 10px 10px;
        }
        .tishi{
            padding-right: 30px;
            margin-top: 10px;
            font-size: 16px;
        <%if("dark-hive".equals(yangshi)){%>
            color: #9F9F9F;
        <%}else {%>
            color: #f1f1f1;
        <%}%>
        }
    </style>
</head>
<body class="easyui-layout">
<div data-options="region:'north',split:true" class="hometop">
    <h1 style="margin: 1% 0">学生界面</h1>
</div>
<div data-options="iconCls:'icon-ok',region:'west',title:'菜单栏',split:true" style="width:250px;">
    <div title="Base" id="caidan" fit="true" style="height: 16px;font-size: 16px" class="easyui-accordion">
        <div title="个人中心" style="overflow:auto;padding:0;">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/email/toemail" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a>我的邮件</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: green">我要请假</a>
                </li>
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/to/end" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a href="JavaScript:parent.window.location.href= '/to/tologin';" style="color: red">退出登录</a>
                </li>
            </ul>
        </div>
        <div title="通知面板" style="overflow:auto;padding:0;">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/to/toMyNotice" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a>查看公告</a>
                </li>
            </ul>
        </div>
        <div title="学员管理" style="list-style-type:none;padding: 0">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/stu/home" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a>学生资料</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: green">我的考试成绩</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: green">我的答辩成绩</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: green">班级分配</a>
                </li>
            </ul>
        </div>
        <div title="教务管理" style="overflow:auto;padding:0;">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/courseManage/toCourse" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>我的课程</a>
                </li>
            </ul>
        </div>
        <div title="后勤管理" style="overflow:auto;padding:0;">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/houqin/repAddPage" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a>报修申请</a>
                </li>
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/houqin/toRepairListPage" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>维修管理</a>
                </li>
            </ul>
        </div>
        <div title="考核管理" style="list-style-type:none;padding: 0">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>教师考评</a>
                </li>
            </ul>
        </div>
        <div title="财务管理" style="list-style-type:none;padding: 0">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="" class="cs-navi-tab">
                    <a style="color: green">查看学费</a>
                </li>
            </ul>
        </div>
        <div title="问题反馈" style="list-style-type:none;padding: 0">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="" class="cs-navi-tab">
                    <a style="color: green">问题反馈</a>
                </li>
            </ul>
        </div>
    </div>
</div>
<div data-options="region:'center',title:'操作区'" style="background:#eee;">
    <div id="tabs" class="easyui-tabs" fit="true">
        <div title="首页">
            <div style="width: 90%;margin: 0 auto;padding: 50px 0">
                <h1>欢迎到来，<%=use.getStuName()%> 今天敲代码了吗？</h1>
                <h2 id="time"></h2>
                <!--dark-hive 纯黑   gray 灰色 pepper-grinder咖啡色-->
                换肤
                <select id="ys" onchange="qieColor()">
                    <option value="gray" <%if("gray".equals(yangshi)){%>selected<%}%>>白昼模式</option>
                    <option value="dark-hive" <%if("dark-hive".equals(yangshi)){%>selected<%}%>>夜间模式</option>
                    <option value="pepper-grinder" <%if("pepper-grinder".equals(yangshi)){%>selected<%}%>>咖啡主题</option>
                </select>
                <fieldset id="hometask" class="layui-elem-field">
                    <legend><h3>事件<button>刷新列表</button></h3></legend>
                    <div class="layui-field-box">
                        待参与教师考评()<br>
                    </div>
                </fieldset>
            </div>
        </div>

    </div>
</div>
<div data-options="region:'south'" style="text-align:center">版权所有：宏图18级开发1班</div>

</body>
<script type="text/javascript">
    var timeStart,timeEnd,time;//申明全局变量

    function getTimeNow(){
        var now=new Date();
        return now.getTime();
    }
    function holdDown(id)//鼠标按下时触发
    {
        timeStart=getTimeNow();//获取鼠标按下时的时间
        time=setInterval(function()//setInterval会每100毫秒执行一次
        {
            timeEnd=getTimeNow();//也就是每100毫秒获取一次时间

            if(timeEnd-timeStart>800){
                $(id).css("background-color","#ff0000");
            }else if(timeEnd-timeStart>650){
                $(id).css("background-color","#ff2d2d");
            }else if(timeEnd-timeStart>500){
                $(id).css("background-color","#ff5151");
            }else if(timeEnd-timeStart>350){
                $(id).css("background-color","#f47920");
            }else if(timeEnd-timeStart>200){
                $(id).css("background-color","#ffd2d2");
            }
            if(timeEnd-timeStart>1000){
                clearInterval(time);//便不再继续重复此函数 （clearInterval取消周期性执行）
                $(id).css("display","none");
            }
        },100);
    }
    function holdUp(id,bs){
        if(bs == 1){
            <%if("dark-hive".equals(yangshi)){%>
            $(id).css("background-color","black");
            <%}else {%>
            $(id).css("background-color","#9F9F9F");
            <%}%>
        }else if(bs == 0){
            <%if("dark-hive".equals(yangshi)){%>
            $(id).css("background-color","#9F9F9F");
            <%}else {%>
            $(id).css("background-color","#f1f1f1");
            <%}%>
        }
        clearInterval(time);//如果按下时间不到1000毫秒便弹起，
    }
</script>
<script>
    var shang = null;

    function biaoti() {
        var date = new Date();
        var day = date.getDate();
        var yue = date.getMonth()+1;
        date.setDate(date.getDate() + 6);
        var end = (date.getMonth() + 1) + "月" + date.getDate()+"日";
        document.getElementById("time").innerText = '今天是：'+yue+'月'+day+"日   周日为："+end;
    }
    biaoti();

    function qiehuan(id2){
        var id = $(id2);
        if(shang == null){
            shang = id;
            <%if("dark-hive".equals(yangshi)){%>
            id.css('background-color','#0972a5');
            <%}else {%>
            id.css('background-color','#D0E5F5');
            <%}%>
            id.css('border-radius','0 40px 40px 0');
        }else {
            shang.css("background-color","");
            shang.css("border-radius","");
            shang = id;
            <%if("dark-hive".equals(yangshi)){%>
            id.css('background-color','#0972a5');
            <%}else {%>
            id.css('background-color','#D0E5F5');
            <%}%>
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
