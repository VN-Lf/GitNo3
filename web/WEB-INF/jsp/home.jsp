<%@ page import="com.nothing.vo.emp.Emp" %>
<%@ page import="com.nothing.vo.emp.Post" %><%--
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
    <jsp:include page="../../index.jsp"></jsp:include>
    <%String yangshi = (String) session.getAttribute("color");%>
    <% Emp use = (Emp) session.getAttribute("empId");%>
    <% Post post = (Post) session.getAttribute("post");%>
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
    <script>
        function chazhaoAct() {  //查找员工请假任务
            $.ajax({
                url:"${pageContext.request.contextPath}/tasksize",
                type:"post",
                dataType:"json",
                success:function (data) {
                    var empact = data.size;
                    if(empact != 0){
                        var taskl = data.task;
                        actTaskTis(empact,1);
                        $.each(taskl,function (index,item) {
                            var name = item.name;
                            var time = item.sj;
                            tianjiaAct(name,time);
                        })
                    }else {
                        actTaskTis(empact,0);
                    }
                }
            });
        }

        function chazhaoWeek() {
            var date = new Date();
            date.setDate(date.getDate() - date.getDay() + 1);
            var begin = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate() + " 00:00:00";
            // 本周日的日期
            date.setDate(date.getDate() + 6);
            var end = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate() + " 17:00:00";
            $.ajax({
                url:"${pageContext.request.contextPath}/Weekly/weeksize",
                type:"post",
                data: {
                    empId:""+<%=use.getEmpId()%>,
                    ks:begin,
                    end:end
                },
                dataType:"json",
                success:function (data) {
                    var size = data.size;
                    var weekl = data.week;
                    if(size != 0){
                        weekTis(size);
                        $.each(weekl,function (index,item) {
                            var misu = item.weekDescription;
                            var time = new Date(item.weekCycle);
                            var d = new Date(time)
                            var t=d.getFullYear()+'-'+(d.getMonth()+1)+'-'+d.getDate()+' '+d.getHours()+':'+d.getMinutes()+':'+ d.getSeconds();
                            tianjiaWeek(misu,t);
                        })
                    }else {
                        weekTis(size);
                    }
                }
            });
        }

        function chazhaoChat() {
            var now = new Date(); //当前日期
            var nowMonth = now.getMonth(); //当前月
            var nowYear = now.getFullYear(); //当前年
            //本月的开始时间
            var mont = new Date(nowYear, nowMonth, 1);
            var ks=mont.getFullYear()+'-'+(mont.getMonth()+1)+'-'+mont.getDate()+' 00:00:00';
            //本月的结束时间
            var mEndD = new Date(nowYear, nowMonth+1, 0);
            var end=mEndD.getFullYear()+'-'+(mEndD.getMonth()+1)+'-'+mEndD.getDate()+' 00:00:00';

            $.ajax({
                url:"${pageContext.request.contextPath}/emp/Chatsize",
                type:"post",
                data: {
                    empId:""+<%=use.getEmpId()%>,
                    ks:ks,
                    end:end
                },
                dataType:"json",
                success:function (data) {
                    var size = data.size;
                    var chat = data.chat;
                    if(size != 0){
                        chatTis(size);
                        $.each(chat,function (index,item) {
                            var di = item.addr;
                            var name = item.stuName;
                            var time = new Date(item.chatDate);
                            var d = new Date(time);
                            var t=d.getFullYear()+'-'+(d.getMonth()+1)+'-'+d.getDate()+' '+d.getHours()+':'+d.getMinutes()+':'+ d.getSeconds();
                            tianjiaChat(di,name,t);
                        })
                    }else {
                        chatTis(size);
                    }
                }
            });
        }

        function shuaF5(f) {
            if(f == 1){
                $("#weektask").remove();
                $("#emptask").remove();
                $("#chattask").remove();
            }
            chazhaoWeek();
            chazhaoAct();
            chazhaoChat();
        }

        <%if(post.getPostName().indexOf("部长")!=-1 || post.getPostName().indexOf("校长")!=-1){%>
        shuaF5(0);
        <%}%>
    </script>
</head>
<body class="easyui-layout">
<div data-options="region:'north',split:true" class="hometop">
    <h1 style="margin: 1% 0">管理员界面</h1>
</div>
<div data-options="iconCls:'icon-ok',region:'west',title:'菜单栏',split:true" style="width:250px;">
    <div title="Base" id="caidan" fit="true" style="height: 16px;font-size: 16px" class="easyui-accordion">
        <div title="个人中心" style="overflow:auto;padding:0;">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/email/toemail" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a style="color: green">我的邮件</a>
                </li>
                <%if(post.getPostName().indexOf("校长")==-1){%>
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/myJobList" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>请假相关</a>
                </li>
                <%}%>
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/Weekly/toWeekly" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>我的周报</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: green">学生请假</a>
                </li>
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/Weekly/toWeekly" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>我的周报</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: green">考勤管理</a>
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
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/Tuition/todept" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a>部门管理</a>
                </li>
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/emp/tochatList" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>谈心记录</a>
                </li>
                <%if(post.getPostName().indexOf("部长")!=-1 || post.getPostName().indexOf("校长")!=-1){%>
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/myTask" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>员工请假管理</a>
                </li>
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/Weekly/toWeeklyCollect" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>周报汇总</a>
                </li>
                <%}%>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: green">考勤管理-上级可看</a>
                </li>
            </ul>
        </div>
        <div title="学员管理" style="list-style-type:none;padding: 0">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/stu/home" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a>学生资料</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: green">学生请假</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>考试成绩</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>答辩成绩</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>班级分配</a>
                </li>
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/stu/claMian" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>班级管理</a>
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
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/course/toCourseType" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>课程类别</a>
                </li>
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/courseManage/toCourse" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>课程管理</a>
                </li>
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/Trial/toTrial" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>试讲培训</a>
                </li>
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/to/weeklist" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>值班管理</a>
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
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/exam/toexam" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>考核指标</a>
                </li>
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/exam/lookexam" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>员工考核</a>
                </li>
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/exam/empexam" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>教师考评</a>
                </li>
            </ul>
        </div>
        <div title="财务管理" style="list-style-type:none;padding: 0">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="" class="cs-navi-tab">
                    <a style="color: green">学费管理</a>
                </li>
            </ul>
        </div>
        <div title="问题反馈" style="list-style-type:none;padding: 0">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="" class="cs-navi-tab">
                    <a>问题反馈</a>
                </li>
            </ul>
        </div>
        <div title="文件管理" style="overflow:auto;padding:0;">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/upload/toupload" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a>资料文档</a>
                </li>
            </ul>
        </div>
        <div title="系统报表" style="overflow:auto;padding:0;">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/to/toempzl" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: green">日常考核</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a style="color: green">员工请假</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a style="color: green">学生请假</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a style="color: green">未打卡说明</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a style="color: green">宿舍统计报表</a>
                </li>
            </ul>
        </div>
        <div title="系统设置" style="overflow:auto;padding:0;">
            <ul style="list-style-type:none;padding: 0">
                <li href="javascript:void(0);" src="${pageContext.request.contextPath}/list" onclick="qiehuan(this)" class="cs-navi-tab">
                    <a>流程</a>
                </li>
                <li href="javascript:void(0);" src="" onclick="qiehuan(this)"  class="cs-navi-tab">
                    <a style="color: green">权限管理</a>
                </li>
            </ul>
        </div>
    </div>
</div>
<div data-options="region:'center',title:'操作区'" style="background:#eee;">
    <div id="tabs" class="easyui-tabs" fit="true">
        <div title="首页">
            <div style="width: 90%;margin: 0 auto;padding: 50px 0">
                <h1>欢迎到来，<%=use.getEmpName()%> 今天有哪些任务呢？</h1>
                <h2 id="time"></h2>
                <!--dark-hive 纯黑   gray 灰色 pepper-grinder咖啡色-->
                换肤
                <select id="ys" onchange="qieColor()">
                    <option value="gray" <%if("gray".equals(yangshi)){%>selected<%}%>>白昼模式</option>
                    <option value="dark-hive" <%if("dark-hive".equals(yangshi)){%>selected<%}%>>夜间模式</option>
                    <option value="pepper-grinder" <%if("pepper-grinder".equals(yangshi)){%>selected<%}%>>咖啡主题</option>
                </select>
                <fieldset id="hometask" class="layui-elem-field">
                    <legend><h3 onclick="shuaF5(1)" style="cursor: pointer;" title="点我可刷新哦">任务</h3></legend>
                    <div class="layui-field-box">
                        学生请假待审批()<br>
                        未打卡待审批()<br>
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

    //请假提示区
    function actTaskTis(san,pand) {
        var html = "";
        if(pand == 1){
            html = "<div id=\"emptask\" title='长按清除该通知' onmousedown=\"holdDown(this)\" onmouseup=\"holdUp(this,1)\" onmouseenter=\"baoyiru(this)\"" +
                " onmouseleave=\"baoyichu(this)\" class='emptask' onclick=\"zhankaiAct(this,"+san+",'act')\">\n" +
                "           <span style=\"font-size: 24px\">有 "+san+" 个员工任务待审核</span>\n" +
                "           <p class=\"tishi\" id='tishi' align=\"right\">点击展开</p>\n" +
                "        </div>"
        }else if(pand == 0){
            html = "<div id=\"emptask\" class='emptask'  onmousedown=\"holdDown(this)\" onmouseup=\"holdUp(this,0)\">\n" +
                "           <span style=\"font-size: 24px\">暂无员工申请假期</span>\n" +
                "           <p class=\"tishi\" align=\"right\"></p>\n" +
                "        </div>"
        }
        $("#hometask").append(html);
        if(san > 4){
            $("#emptask").css("background-color","red");
        }else if(san >= 3) {
            $("#emptask").css("background-color","#FF5722");
        }
    }
    function tianjiaAct(name,time) {
        var html = "<div class=\"xxnr\" style=\"padding:8px 50px;display: none\">\n" +
            "            <p align=\"left\" class=\"pzuo\">任务名称："+name+"</p>\n" +
            "            <p align=\"right\" class=\"pyou\">请假单申请时间："+time+"</p>\n" +
            "       </div>"
        $("#emptask").append(html);
    }
    var dianji = 0;
    var dianjiw = 0;
    var dianjic = 0;
    var cid,wid,tid;
    function zhankaiAct(id,san,type) {
        if(type == "act"){
            if(dianji == 0){
                cid = id;
                var he = 65 + san*75;
                $(id).css("height",he+"px");
                document.getElementById("tishi").innerHTML="点击关闭";
                setTimeout("yanchiguan()","300");
                dianji = 1;
            }else {
                cid = id;
                $(id).css("height","65px");
                document.getElementById("tishi").innerHTML="点击展开";
                $(id).children(".xxnr").css("display","none");
                dianji = 0;
            }
        }else if(type == "week"){
            if(dianjiw == 0){
                wid = id;
                var he = 65 + san*75;
                $(id).css("height",he+"px");
                document.getElementById("tishi2").innerHTML="点击关闭";
                setTimeout("yanchiguan2()","300");
                dianjiw = 1;
            }else {
                wid = id;
                $(id).css("height","65px");
                document.getElementById("tishi2").innerHTML="点击展开";
                $(id).children(".xxnr").css("display","none");
                dianjiw = 0;
            }
        }else if(type == "chat"){
            if(dianjic == 0){
                tid = id;
                var he = 65 + san*75;
                $(id).css("height",he+"px");
                document.getElementById("tishi3").innerHTML="点击关闭";
                setTimeout("yanchiguan3()","300");
                dianjic = 1;
            }else {
                tid = id;
                $(id).css("height","65px");
                document.getElementById("tishi3").innerHTML="点击展开";
                $(id).children(".xxnr").css("display","none");
                dianjic = 0;
            }
        }
    }
    //延迟暂时里数据
    function yanchiguan() {
        $(cid).children(".xxnr").css("display","block");
    }
    function yanchiguan2() {
        $(wid).children(".xxnr").css("display","block");
    }
    function yanchiguan3() {
        $(tid).children(".xxnr").css("display","block");
    }

    //周报提示区
    function weekTis(size) {
        var html = "";
        if(size == 0){
            html = "<div class=\"emptask\" title='长按清除该通知' onmousedown=\"holdDown(this)\" onmouseup=\"holdUp(this,0)\">\n" +
                "       <span style=\"font-size: 24px\">本周周报尚未完成</span>\n" +
                "       <p align=\"right\" id=\"sysj\" style=\"padding-right: 30px;margin-top: 10px;font-size: 16px\"></p>\n" +
                "   </div>";
            $("#hometask").append(html);
            setInterval("gettime('week')","1000");
        }else {
            html = "<div id=\"weektask\"  title='长按清除该通知' onmousedown=\"holdDown(this)\" onmouseup=\"holdUp(this,1)\" onmouseenter=\"baoyiru(this)\"" +
                " onmouseleave=\"baoyichu(this)\" class=\"emptask\" onclick=\"zhankaiAct(this,"+size+",'week')\">\n" +
                "       <span style=\"font-size: 24px\">本周周报已填写 "+size+" 条</span>\n" +
                "       <p align=\"right\" id='tishi2' style=\"padding-right: 30px;margin-top: 10px;font-size: 16px\">点击查看更多</p>\n" +
                "   </div>";
            $("#hometask").append(html);
        }
    }
    function tianjiaWeek(misu,time) {
        var html = "<div class=\"xxnr\" style=\"padding:8px 50px;display: none\">\n" +
            "            <p align=\"left\" class=\"pzuo\">工作描述："+misu+"</p>\n" +
            "            <p align=\"right\" class=\"pyou\">填写时间："+time+"</p>\n" +
            "       </div>"
        $("#weektask").append(html);
    }

    function gettime(type){
        if(type == "week"){
            var date = new Date();
            date.setDate(date.getDate() - date.getDay() + 1);
            var begin = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate() + " 00:00:00";
            // 本周日的日期
            date.setDate(date.getDate() + 6);
            var end = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate() + " 17:00:00";
            document.getElementById("sysj").innerText = "剩余 "+huoquEndDate(end,'#sysj');
        }else if(type == "chat"){
            var now = new Date(); //当前日期
            var nowMonth = now.getMonth(); //当前月
            var nowYear = now.getFullYear(); //当前年
            //本月的结束时间
            var mEndD = new Date(nowYear, nowMonth+1, 0);
            document.getElementById("sysj2").innerText = "距离月底剩余 "+huoquEndDate(mEndD,'#sysj2');
        }
    }
    function huoquEndDate(date,id) {
        var Today = new Date();
        var endDate = new Date(date);
        var leftTime = endDate.getTime() - Today.getTime();
        var leftSecond = parseInt(leftTime / 1000);
        var Day = Math.floor(leftSecond / (60 * 60 * 24));
        var Hour = Math.floor((leftSecond - Day * 24 * 60 * 60) / 3600);
        var Minute = Math.floor((leftSecond - Day * 24 * 60 * 60 - Hour * 3600) / 60);
        var Second = Math.floor(leftSecond - Day * 24 * 60 * 60 - Hour * 3600 - Minute * 60);
        if(Day == 1){
            $(id).parent().css("background-color","red");
        }else if(Day <= 3) {
            $(id).parent().css("background-color","#FF5722");
        }
        return Day+"日 "+Hour+"时 "+Minute+"分 "+Second+"秒";
    }
    //谈心提示区
    function chatTis(size) {
        var html = "";
        if(size == 0){
            html = "<div class=\"emptask\"  title='长按清除该通知' onmousedown=\"holdDown(this)\" onmouseup=\"holdUp(this,0)\">\n" +
                "       <span style=\"font-size: 24px\">本月谈心还未完成 5 条</span>\n" +
                "       <p align=\"right\" id=\"sysj2\" style=\"padding-right: 30px;margin-top: 10px;font-size: 16px\"></p>\n" +
                "   </div>";
            $("#hometask").append(html);
            setInterval("gettime('chat')","1000");
        }else {
            if(size > 4){
                html = "<div id=\"chattask\"  title='长按清除该通知' onmousedown=\"holdDown(this)\" onmouseup=\"holdUp(this,1)\" onmouseenter=\"baoyiru(this)\"" +
                    " onmouseleave=\"baoyichu(this)\" class=\"emptask\" onclick=\"zhankaiAct(this,"+size+",'chat')\">\n" +
                    "<span style=\"font-size: 24px\">本月谈心任务已完成 数量："+size+"</span>\n"+
                    "       <p align=\"right\" id='tishi3' style=\"padding-right: 30px;margin-top: 10px;font-size: 16px\">点击查看更多</p>\n" +
                    "   </div>";
                $("#hometask").append(html);
            }else {
                var js = 5 - size;
                var ti ="<p align='left' style='width:50%;padding-right: 30px;margin-top: 10px;font-size: 16px;float: left'>本月谈心已完成 "+size+" 条 还需 "+js+" 条</p>";

                html = "<div id=\"chattask\"  title='长按清除该通知' onmousedown=\"holdDown(this)\" onmouseup=\"holdUp(this,1)\" onmouseenter=\"baoyiru(this)\"" +
                    " onmouseleave=\"baoyichu(this)\" class=\"emptask\" onclick=\"zhankaiAct(this,"+size+",'chat')\">\n" +
                    "<p align=\"left\" style=\"font-size: 24px;padding-right: 30px;float:left;width:45%;\">本月谈心任务已完成 "+size+" 条 还有 "+js+" 条待完成</p>\n"+
                    "<p align=\"left\" id='sysj2' style=\"padding-right: 18px;float:right;width:18%;font-size: 16px\"></p>\n"+
                "       <p align=\"right\" id='tishi3' style=\"padding-right: 30px;margin-top: 45px;font-size: 16px\">点击查看更多</p>\n" +
                "   </div>";
                $("#hometask").append(html);
                setInterval("gettime('chat')","1000");
            }
        }
    }
    function tianjiaChat(di,name,time) {
        var html = "<div class=\"xxnr\" style=\"padding:8px 50px;display: none\">\n" +
            "            <p align=\"left\" class=\"pzuo\">在"+di+"与 "+name+" 完成了一次谈心</p>\n" +
            "            <p align=\"right\" class=\"pyou\">时间："+time+"</p>\n" +
            "       </div>"
        $("#chattask").append(html);
    }

    function biaoti() {
        var date = new Date();
        var day = date.getDate();
        var yue = date.getMonth()+1;
        date.setDate(date.getDate() + 6);
        var end = (date.getMonth() + 1) + "月" + date.getDate()+"日";
        document.getElementById("time").innerText = '今天是：'+yue+'月'+day+"日   周日为："+end;
    }
    biaoti();

    function baoyiru(id) {
        <%if("dark-hive".equals(yangshi)){%>
        $(id).css("background-color","black");
        <%}else {%>
        $(id).css("background-color","#9F9F9F");
        <%}%>
    }//移除列表区
    function baoyichu(id) {
        <%if("dark-hive".equals(yangshi)){%>
        $(id).css("background-color","#9F9F9F");
        <%}else {%>
        $(id).css("background-color","#f1f1f1");
        <%}%>
    }
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
