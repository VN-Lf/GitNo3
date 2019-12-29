<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/26
  Time: 11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="index.jsp"%>
<html>
<head>
    <title>个人信息表</title>
</head>
<body>
    <div style="width: 700px;height: 600px;margin-left: 400px">
        <table border="1px"  style="width: 700px;height: 600px;text-align: center">
            <tbody>
                <tr>
                    <td colspan="4">员工信息</td>
                </tr>
                <tr>
                    <td>员工姓名</td>
                    <td>${personimf.empName}</td>
                    <td>部门名称</td>
                    <td>${personimf.deptName}</td>
                </tr>
                <tr>
                    <td>出生日期</td>
                    <td>${personimf.empBirthday}</td>
                    <td>身份证号</td>
                    <td>${personimf.empCardno}</td>
                </tr>
                <tr>
                    <td>籍贯</td>
                    <td>${personimf.empNation}</td>
                    <td>手机号码</td>
                    <td>${personimf.empPhone}</td>
                </tr>
                <tr>
                    <td colspan="4">工作经历</td>
                </tr>
                <c:forEach items="${personi}" var="personi">
                    <tr>
                        <td>公司名称</td>
                        <td>${personi.empHisCompany}</td>
                        <td>岗位</td>
                        <td>${personi.empHisDegree}</td>
                    </tr>
                    <tr>
                        <td>入职时间</td>
                        <td>${personi.empHisStartDay}</td>
                        <td>离职时间</td>
                        <td>${personi.empHisEndDay}</td>
                    </tr>
                </c:forEach>
                <tr>
                    <td colspan="4">教育背景</td>
                </tr>
                <c:forEach items="${personim}" var="personim">
                    <tr>
                        <td>毕业学校</td>
                        <td>${personim.empUniversity}</td>
                        <td>学历</td>
                        <td>${personim.empDegree}</td>
                    </tr>
                    <tr>
                        <td>入校时间</td>
                        <td>${personim.empEucStartDay}</td>
                        <td>毕业时间</td>
                        <td>${personim.empEucEndDay}</td>
                    </tr>
                </c:forEach>

                <tr>
                    <td colspan="4">家庭联系信息</td>
                </tr>
                <c:forEach items="${person}" var="person">
                    <tr>
                        <td>联系人名称</td>
                        <td>${person.empContact}</td>
                        <td>与本人关系</td>
                        <td>${person.empRelation}</td>
                    </tr>
                    <tr>
                        <td colspan="2">联系电话</td>
                        <td colspan="2">${person.empContactphone}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
