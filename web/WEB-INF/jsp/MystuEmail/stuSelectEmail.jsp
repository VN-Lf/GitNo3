<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.nothing.vo.Email.Email" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/15
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include  file="index.jsp"%>
<html>
<head>
    <title>查看Email界面</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <style type="text/css">
        .layui-table-tool {
            z-index: 0;
        }
    </style>
    <%Email email = (Email) request.getAttribute("emalilist");%>
    <%String type = (String) request.getAttribute("examtype");%>
    <jsp:include page="../../../index.jsp"></jsp:include>
</head>
<body>
<div>
    <div>
        <div style="width: 600px;margin: 0 auto;text-align: center">
            <h1>标题:${emalilist.topic}</h1>
            <%if("考核".equals(email.getTopic())){%>
            <div>
                <h2>内容：<%=email.getContent()%></h2>
                <h3 id="sysj">正在查询</h3>
            </div>
            <form style="height: 400px;width: 400px;margin:50px auto;" action="${pageContext.request.contextPath}/email/examscore" method="post" >
                <input type="hidden" name="empkaohuid" value="${emalilist.image}">
                <%if("老师".equals(type)){%>
                <table border="1px" style="width: 400px;height: 400px;text-align: center">
                    <tr>
                        <td>
                            <input type="hidden" name="exam1" value="老师是否准备充分">
                            <p>老师是否准备充分</p>
                        </td>
                        <td> <select name="examscore1">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                        </select></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="hidden" name="exam2" value="案列是否丰富">
                            <p>案列是否丰富</p>
                        </td>
                        <td><select name="examscore2">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                        </select></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="hidden" name="exam3" value="课堂气氛活跃程度">
                            <p>课堂气氛活跃程度</p>
                        </td>
                        <td><select name="examscore3">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                        </select></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="hidden" name="exam4" value="技术实力如何">
                            <p>技术实力如何</p>
                        </td>
                        <td> <select name="examscore4">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                        </select></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="hidden" name="exam5" value="课堂纪律">
                            <p>课堂纪律</p>
                        </td>
                        <td><select name="examscore5">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                        </select></td>
                    </tr>
                    <tr class="tijiao">
                        <td colspan="2"><div class="layui-btn-container">
                            <input class="layui-btn layui-btn-lg  layui-btn-normal" type="submit"  value="提交"  />
                            <a class="layui-btn layui-btn layui-btn-lg layui-btn-primary" href="${pageContext.request.contextPath}/email/toemail"  >返回</a>
                        </div></td>
                    </tr>
                </table>
                <%}else if("班主任".equals(type)){%>
                <table border="1px" style="width: 400px;height: 400px;text-align: center">
                    <tr>
                        <td>
                            <input type="hidden" name="exam1" value="沟通能力">
                            <p>沟通能力</p>
                        </td>
                        <td> <select name="examscore1">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                        </select></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="hidden" name="exam2" value="晨练执行能力">
                            <p>晨练执行能力</p>
                        </td>
                        <td> <select name="examscore2">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                        </select></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="hidden" name="exam3" value="语言表达能力">
                            <p>语言表达能力</p>
                        </td>
                        <td> <select name="examscore3">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                        </select></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="hidden" name="exam4" value="责任程度">
                            <p>责任程度</p>
                        </td>
                        <td> <select name="examscore4">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                        </select></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="hidden" name="exam5" value="管理能力">
                            <p>管理能力</p>
                        </td>
                        <td> <select name="examscore5">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                        </select></td>
                    </tr>
                    <tr>
                        <td  class="tijiao" colspan="2"><div class="layui-btn-container">
                            <input class="layui-btn layui-btn-lg  layui-btn-normal" type="submit"  value="提交"  />
                            <a class="layui-btn layui-btn layui-btn-lg layui-btn-primary" href="${pageContext.request.contextPath}/email/toemail"  >返回</a>
                        </div></td>
                    </tr>
                </table>
                <%}else if("你已经考核过了".equals(type)){%>
                <h1>你已经考核过了。。。。。。</h1>
                <%}else if("考核已结束".equals(type)){%>
                <h1>同学考核结束了。。。。。。</h1>
                <%}else if("该考核已删除".equals(type)){%>
                <h1>该考核已删除。。。。。。</h1>
                <%}%>
            </form>
            <%}else {%>
            <h3 style="text-align: right;">发送人：${emalilist.empName}</h3>
            <textarea readonly style="width: 100%;height: 500px;margin-top:30px;background-color: transparent;overflow:hidden;resize:none;outline: none;">
                ${emalilist.content}
            </textarea>
            <h3 style="text-align: right;margin-top: 30px">发送时间：${emalilist.sendtime}</h3>
            <%}%>
        </div>
    </div>
    <script type="text/javascript">
        var jieshu = 1;
        function huoquEndDate() {
            var end = "<%=email.getEndTime()%>";
            var Today = new Date();
            var endDate = new Date(end);
            var leftTime = endDate.getTime() - Today.getTime();
            var leftSecond = parseInt(leftTime / 1000);
            var Day = Math.floor(leftSecond / (60 * 60 * 24));
            var Hour = Math.floor((leftSecond - Day * 24 * 60 * 60) / 3600);
            var Minute = Math.floor((leftSecond - Day * 24 * 60 * 60 - Hour * 3600) / 60);
            var Second = Math.floor(leftSecond - Day * 24 * 60 * 60 - Hour * 3600 - Minute * 60);
            if(Day === 0){
                var tishi = Hour+"时 "+Minute+"分 "+Second+"秒";
            }else {
                var tishi = Day+"日 "+Hour+"时 "+Minute+"分 "+Second+"秒";
            }
            if(Day+Hour+Minute+Second+Second === 0 || Day < 0){
                jieshu = 0;
                $(".tijiao").css("display","none");
            }
            if(jieshu === 1){
                document.getElementById("sysj").innerText = "剩余 "+tishi;
            }else {
                document.getElementById("sysj").innerText = "考核时间已结束 无法再提交";
                document.getElementById("sysj").style.color="red";
            }
        }
        huoquEndDate();
        setInterval("huoquEndDate()","1000");
    </script>
</div>
</body>
</html>