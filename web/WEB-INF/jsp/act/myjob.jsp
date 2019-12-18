<%@ page import="com.nothing.vo.emp.Emp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/19
  Time: 15:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的申请单</title>
    <%String yangshi = (String) session.getAttribute("color");%>
    <script src="${pageContext.request.contextPath}/jquery.js"></script>
    <style>
        table tr{
        <%if("dark-hive".equals(yangshi)){%>
            background-color: black;
            color: white;
        <%}else {%>
            background-color: #f1f1f1;
            color: black;
        <%}%>
        }
        table a{
        <%if("dark-hive".equals(yangshi)){%>
            color: white;
        <%}else {%>
            color: black;
        <%}%>
            text-decoration:none;
            font-size: 15px;
            transition: 0.25s;
        }
        table a:hover{
        <%if("dark-hive".equals(yangshi)){%>
            color: yellow;
        <%}else {%>
            color: blue;
        <%}%>
        }
        #sqd table tr:hover{
        <%if("dark-hive".equals(yangshi)){%>
            background-color: #0972a5;
        <%}else {%>
            background-color: #D0E5F5;
        <%}%>
        }
        #sqd table {
            width: 94%;
            margin: 0 auto;
            display:block;
        }
        #sqd table tbody::-webkit-scrollbar {
            display: none;
        }
        #sqd table tbody {
            display:block;
            height:349px;
            overflow-y:scroll;
            -webkit-overflow-scrolling: touch;
        }
        #sqd table th,tr{
            padding: 5px;
        }
        #sqd table thead {
            width: calc( 100% - 1em )
        }
        #qinjia{
            width: 500px;
            height:160px;
            margin: 0 auto;
            margin-top:150px;
            background-color: #f1f1f1;
            transition: 0.5s;
            display: none
        }
        .tishis {
            transition: 0.5s;
            position: absolute;
            left: 150px;
            top: 5px;
            font-size: 14px;
        }
        #select{
            transition: 0.5s;
            width: 105px;
            height: 21px;
            position: absolute;
            outline: none;
            left: 19px;
            top: 5px;
        }
        #dayr{
            width: 100px;
            position: absolute;
            top: 5px;
            z-index: 10;
            transition: 0.5s;
        }
        table td{
            padding: 5px;
        }
    </style>
</head>
<body>
<div id="sqd" style="width: 80%;margin: 0 auto;transition: 0.5s;text-align: center;">
    <table id="tab1" cellspacing="1">
        <tr>
            <th colspan="9">
                <h2 style="margin: 10px">我的申请单</h2>
                <c:if test="${fn:length(jobList) > 7}">
                    <span id="totishi" style="font-size: 14px">(鼠标滑轮下滑可查看更多)</span>
                </c:if>
            </th>
        </tr>
        <tr>
            <th style="width: 80px">申请人</th>
            <th style="width: 50px">天数</th>
            <th style="width: 160px">申请时间</th>
            <th style="width: 160px">假期开始时间</th>
            <th style="width: 160px">假期结束时间</th>
            <th style="width: 100px">审批状态</th>
            <th style="width: 274px" >申请说明</th>
            <th style="width: 140px"  colspan="2">操作</th>
        </tr>
        <c:if test="${zhi==0}">
            <tr style="padding: 5px;">
                <td colspan="10">
                    <h2 align="center" style="margin: 10px">暂无上传过申请单</h2>
                </td>
            </tr>
        </c:if>
        <c:if test="${zhi==1}">
            <c:forEach items="${jobList}" var="t">
                <tr style="padding: 5px;">
                    <td style="width: 80px" align='center'>${t.userId }</td>
                    <td style="width: 50px" align='center'>${t.day }</td>
                    <td align='center'>${t.jobDate}</td>
                    <td align='center'>${t.goDate}</td>
                    <td align='center'>${t.endDate}</td>
                    <c:if test="${t.processFlag==1}">
                        <td bgcolor="fcaf17" align='center'>
                            <font style="font-size: 14px" color="white">审批中</font>
                        </td>
                    </c:if>
                    <c:if test="${t.processFlag==2}">
                        <td bgcolor="2ec770" align='center'>
                            <font style="font-size: 14px" color="white">审批通过</font>
                        </td>
                    </c:if>
                    <c:if test="${t.processFlag==3}">
                        <td bgcolor="red" align='center'>
                            <font style="font-size: 14px" color="white">审批未通过</font>
                        </td>
                    </c:if>
                    <td style="width: 274px"  align='center'>${t.remark }</td>
                    <td style="width: 70px"><a href="${pageContext.request.contextPath}/lookComment?jobId=${t.jobId}">查看批注</a></td>
                    <td style="width: 70px"><a href="${pageContext.request.contextPath}/lookMyJob?jobId=${t.jobId}" target="_blank">办理进度</a></td>

                </tr>
            </c:forEach>
        </c:if>

        <tr>
            <td  id="abt2" onclick="shangHua()" colspan="9" style="cursor:pointer;padding: 5px" align="center">
                <a id="abt" style="
                    <%if("dark-hive".equals(yangshi)){%>
                        color: white;
                    <%}else {%>
                        color: black;
                        <%}%>">>  申请假期  <</a>
            </td>
        </tr>
    </table>
</div>
<div id="qinjia">
    <% Emp use = (Emp) session.getAttribute("empId");%>
    <form action="${pageContext.request.contextPath}/apply" theme="simple" method="post">
        <input type="hidden" name="jobName" value="请假单"/>
        <input type="hidden" name="userId" value="<%=use.getEmpId()%>"/>
        <input type="hidden" name="dept" value="<%=use.getEmpDeptId()%>"/>
        <input type="hidden" name="jobType" value="empact"/>
        <table style="width:100%;height: 100%" cellspacing="1" bgcolor="#6495ED">
            <tr bgcolor="#D0E5F5">
                <th colspan="2"><h2 style="margin: 10px" color="black">申请假期</h2></th>
            </tr>
            <tr bgcolor="white">
                <td align="right">开始时间：</td>
                <td><input id="godate" name="godate" type="date"/>
                    <input id="gotime" name="gotime" value="00:00" type="time"/></td>
            </tr>
            <tr style="padding: 8px" bgcolor="white">
                <td align="right">请假天数：</td>
                <td style="position: relative;">
                    <input type="text" id="dayr" oninput="shusuzi()" name="day"/>
                    <select id="select" onchange="fuzhis()">
                        <option value="">取消</option>
                        <option value="0">4小时带薪假</option>
                        <option value="3">3天婚假</option>
                        <option value="7">丧假</option>
                        <option value="90">产假</option>
                    </select>
                    <span id="tishi" class="tishis"></span>
                </td>
            </tr>
            <tr bgcolor="white">
                <td align="right">结束时间：</td>
                <td><input id="enddate" name="enddate" type="date"/>
                    <input id="endtime" name="endtime" type="time"/> </td>
            </tr>
            <tr style="padding: 8px" bgcolor="white">
                <td align="right">请假事由：</td>
                <td><input type="text" id="qjsy" name="remark"/></td>
            </tr>
            <tr style="padding: 8px" bgcolor="white">
                <td colspan="2" align="center">
                    <input style="width: 100px;height: 25px" type="submit" value="提交">
                </td>
            </tr>
        </table>
    </form>
</div>
<script>
    var zt = 0;
    document.getElementById("abt2").onmouseenter=function(){
        if(zt == 0){
            document.getElementById("abt").innerText =">申请假期<";
        }else {
            document.getElementById("abt").innerText =">取消申请<";
        }

    };
    document.getElementById("abt2").onmouseleave=function(){
        if(zt == 0){
            document.getElementById("abt").innerText =">  申请假期  <";
        }else {
            document.getElementById("abt").innerText =">  取消申请  <";
        }
    };
    function shangHua() {
        var table =document.getElementById("tab1");
        var rows = table.rows.length;
        if(zt == 0){
            $("#qinjia").css("margin-top","50px");
            if(rows == 4){
                var toph = 100;
            }else if(rows <= 9){
                var toph = 100+(rows - 4)*30;
            }else {
                var toph = 250;
            }
            $("#sqd").css("margin-top","-"+toph+"px");
            $("#qinjia").css("display","block");
            document.getElementById("abt").innerText =">  取消申请  <";
            zt = 1;
        }else {
            $("#qinjia").css("margin-top","150");
            $("#sqd").css("margin-top","0");
            setTimeout("guanbi()","300");
            document.getElementById("abt").innerText =">  申请假期  <";
            zt = 0;
        }
    }
    function guanbi() {
        $("#qinjia").css("display","none");
    }
    function gel(id) {return document.getElementById(id);}
    function shusuzi() {
        var time = gel("dayr").value;
        for (var i = 0; i < time.length; i++) {
            var t = time.charCodeAt(i);
            if (!(t >= 48 && t <= 57)) {
                gel("dayr").value=time.substr(0,time.length-1);
                gel("tishi").style.left="150px";
                gel("tishi").innerText = "只能输入数字";
            }else {
                gel("tishi").style.left="150px";
                gel("tishi").innerText = "";

                var gd = gel("godate").value;
                var gt = gel("gotime").value;
                var godt = gd+" "+gt+":00";
                var cha = (new Date(godt)).getTime() + time*24*60*60*1000;//时间差
                var d = new Date(cha);//新时间
                var enddate = d.getFullYear()+"-";
                if((d.getMonth()+1) < 10){
                    enddate = enddate+"0"+(d.getMonth()+1)+'-';
                }else {
                    enddate = enddate+(d.getMonth()+1)+'-';
                }
                if(d.getDate() < 10){
                    enddate = enddate+"0"+d.getDate();
                }else {
                    enddate = enddate+d.getDate();
                }
                gel("enddate").value = enddate;
                gel("endtime").value = gt;
            }
        }
    }
    function fuzhis() {
        var val = document.getElementById("select").value;
        document.getElementById("dayr").value=val;
        if(val != ""){
            var obj = gel("select"); //定位id
            var index = obj.selectedIndex; // 选中索引
            var text = obj.options[index].text; // 选中文本readonly
            gel("dayr").style.width="50px";
            gel("dayr").readOnly=true;
            gel("select").style.width="55px";
            gel("tishi").style.left="100px";
            gel("tishi").innerText = "已选择："+text;
            gel("qjsy").value = text;
            gel("qjsy").readOnly=true;

            var gd = gel("godate").value;
            var gt = gel("gotime").value;
            var godt = gd+" "+gt+":00";

            var zhi = 1;
            if(index == 1){
                zhi = 4;
            }else if(index == 2){
                zhi = 3*24;//时间差
            }else if(index == 3){
                zhi = 7*24;
            }else if(index == 4){
                zhi = 90*24;
            }
            var cha = (new Date(godt)).getTime() + zhi*60*60*1000;//时间差
            var d = new Date(cha);//新时间
            if(index == 1){
                var endtime = "";
                if(d.getHours() < 10){
                    endtime = "0"+d.getHours();
                }else {
                    endtime = d.getHours();
                }
                if(d.getMinutes() == 0){
                    endtime = endtime+':'+"00";
                }else {
                    endtime = endtime+':'+d.getMinutes();
                }
                gel("enddate").value = gd;
                gel("endtime").value = endtime;
            }else {
                var enddate = d.getFullYear()+"-";
                if((d.getMonth()+1) < 10){
                    enddate = enddate+"0"+(d.getMonth()+1)+'-';
                }else {
                    enddate = enddate+(d.getMonth()+1)+'-';
                }
                if(d.getDate() < 10){
                    enddate = enddate+"0"+d.getDate();
                }else {
                    enddate = enddate+d.getDate();
                }
                gel("enddate").value = enddate;
                gel("endtime").value = gt;
            }
        }else {
            gel("dayr").style.width="100px";
            gel("select").style.width="105px";
            gel("tishi").style.left=150+"px";
            gel("qjsy").value = "";
            gel("qjsy").readOnly=false;
            setTimeout("yanchioff()","300");
        }
    }
    function yanchioff() {
        gel("tishi").innerText = "";
        gel("dayr").readOnly=false;
    }
</script>
</body>
</html>
