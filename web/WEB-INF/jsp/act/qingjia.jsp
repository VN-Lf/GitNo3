<%@ page import="com.nothing.vo.emp.Emp" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/19
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
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
<% Emp use = (Emp) session.getAttribute("empId");%>
<form action="${pageContext.request.contextPath}/apply" theme="simple" method="post">
    <input type="hidden" name="jobName" value="请假单"/>
    <input type="hidden" name="userId" value="<%=use.getEmpId()%>"/>
    <input type="hidden" name="dept" value="<%=use.getEmpDeptId()%>"/>
    <input type="hidden" name="jobType" value="empact"/>
    <table style="width:30%;margin: 0 auto" cellspacing="1" bgcolor="#6495ED">
        <tr bgcolor="#D0E5F5">
            <th colspan="2"><h2 style="margin: 10px" color="black">申请假期</h2></th>
        </tr>
        <tr bgcolor="white">
            <td align="right">开始时间：</td>
            <td><input name="godate" type="date"/><input name="gotime" type="time"/> </td>
        </tr>
        <tr style="padding: 8px" bgcolor="white">
            <td align="right">请假天数：</td>
            <td style="position: relative;">
                <input type="text" id="dayr" oninput="shusuzi()" name="day"/>
                <select id="select" onchange="fuzhis()">
                    <option value="">取消</option>
                    <option value="0">4小时带薪假</option>
                    <option value="3">3天婚假</option>
                    <option value="90">产假</option>
                    <option value="7">丧假</option>
                </select>
                <span id="tishi" class="tishis"></span>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="right">结束时间：</td>
            <td><input name="enddate" type="date"/><input name="endtime" type="time"/> </td>
        </tr>
        <tr style="padding: 8px" bgcolor="white">
            <td align="right">请假事由：</td>
            <td><input type="text" name="remark"/></td>
        </tr>
        <tr style="padding: 8px" bgcolor="white">
            <td colspan="2" align="center">
                <input style="width: 100px;height: 25px" type="submit" value="提交">
            </td>
        </tr>
    </table>
</form>
<script>
    function gel(id) {return document.getElementById(id);}
    function shusuzi() {
        var time = gel("dayr").value;
        for (var i = 0; i < time.length; i++) {
            var t = time.charCodeAt(i);
            if (!(t >= 48 && t <= 57)) {
                gel("dayr").value=time.substr(0,time.length-1);
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
        }else {
            gel("dayr").style.width="100px";
            gel("select").style.width="105px";
            gel("tishi").style.left=150+"px";
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
