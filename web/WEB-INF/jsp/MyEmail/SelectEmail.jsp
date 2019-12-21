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
    <jsp:include page="../../../index.jsp"></jsp:include>
</head>
<body>
<div class="easyui-layout" data-options="fit:true" >
    <div data-options="region:'center',title:'信息管理'" style="background:#eee;" >
        <div style="text-align: center">
            <h1>标题:${emalilist.topic}</h1>
            <div>
                <h2>内容：<%=email.getContent()%></h2>
            </div><br>
            <c:if test='${emalilist.topic=="考核"}'>
                <form style="height: 400px;width: 400px;margin:0 auto;" action="${pageContext.request.contextPath}/email/examscore" method="post" >
                    <c:if test='${examtype=="授课老师"}'>
                        <input type="hidden" name="empkaohuid" value="${emalilist.image}">
                        <table border="1px" style="width: 400px;height: 400px;text-align: center">
                            <tr>
                                <td><input type="text" name="exam1" style="border:0px;background-color: rgba(216,216,216,0.11);color: black" value="老师是否准备充分"></td>
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
                                <td><input type="text" name="exam2" style="border:0px;background-color: rgba(216,216,216,0.11);color: black" value="案列是否丰富"></td>
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
                                <td><input type="text" name="exam3" style="border:0px;background-color: rgba(216,216,216,0.11);color: black" value="课堂气氛是否活跃"></td>
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
                                <td><input type="text" name="exam4" style="border:0px;background-color: rgba(216,216,216,0.11);color: black" value="技术实力如何"></td>
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
                                <td><input type="text" name="exam5" style="border:0px;background-color: rgba(216,216,216,0.11);color: black" value="课堂纪律是否严格"></td>
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
                                <td colspan="2"><div class="layui-btn-container">
                                    <input class="layui-btn layui-btn-lg  layui-btn-normal" type="submit"  value="提交"  />
                                    <a class="layui-btn layui-btn layui-btn-lg layui-btn-primary" href="${pageContext.request.contextPath}/email/toemail"  >返回</a>
                                </div></td>

                            </tr>
                        </table>

                    </c:if>
                    <c:if test='${examtype=="班主任"}'>
                        <table border="1px" style="width: 400px;height: 400px;text-align: center">
                            <tr>
                                <td><input type="text" name="exam1" style="border:0px;background-color: rgba(216,216,216,0.11);color: black" value="沟通能力"></td>
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
                                <td><input type="text" name="exam2" style="border:0px;background-color: rgba(216,216,216,0.11);color: black" value="晨练执行能力"></td>
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
                                <td><input type="text" name="exam3" style="border:0px;background-color: rgba(216,216,216,0.11);color: black" value="语言表单能力"></td>
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
                                <td><input type="text" name="exam4" style="border:0px;background-color: rgba(216,216,216,0.11);color: black" value="责任心"></td>
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
                                <td><input type="text" name="exam5" style="border:0px;background-color: rgba(216,216,216,0.11);color: black" value="管理能力"></td>
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
                                <td colspan="2"><div class="layui-btn-container">
                                    <input class="layui-btn layui-btn-lg  layui-btn-normal" type="submit"  value="提交"  />
                                    <a class="layui-btn layui-btn layui-btn-lg layui-btn-primary" href="${pageContext.request.contextPath}/email/toemail"  >返回</a>
                                </div></td>

                            </tr>
                        </table>
                    </c:if>
                    <c:if test='${examtype=="你已经考核过了"}'>
                        <h1>你已经考核过了。。。。。。</h1>
                    </c:if>
                    <c:if test='${examtype=="考核已结束"}'>
                        <h1>同学考核结束了。。。。。。</h1>
                    </c:if>
                </form>
            </c:if>
        </div>

    </div>
</div>
</body>
</html>