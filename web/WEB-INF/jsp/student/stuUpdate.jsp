<%@ page import="com.nothing.vo.Sdudent.Student" %><%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/4
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>修改学生资料</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/layui/laydate/laydate.js"></script> <!-- 改成你的路径 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/laydate/theme/default/laydate.css">
    <script src="${pageContext.request.contextPath}/jquery.js"></script>
</head>
<body>
<button type="button" class="layui-btn layui-btn-primary" onclick="openMain()">返回</button>
<form class="layui-form" action="${pageContext.request.contextPath}/stu/update/up" method="post" lay-filter="gg" target="_self">
    <input id="stuId" type="hidden" name="studId" lay-verify="required" autocomplete="off" class="layui-input" value="${stu.studId}">
    <div style="width: 100%;height: 69%;margin-top: 1%">
        <div style="width:33%;height:100%;float: left">


            <div class="layui-form-item">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-block">
                    <input id="stuName" type="text" name="stuName" required  lay-verify="required" placeholder="请输入学生姓名" autocomplete="off" class="layui-input" value="${stu.stuName}">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">登录密码</label>
                <div class="layui-input-block">
                    <input id="stuPsw" type="text" name="stuPsw" required  lay-verify="required"  autocomplete="off" class="layui-input" title="默认123456" value="${stu.stuPsw}">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">性别</label>
                <div class="layui-input-block">
                    <input type="radio" name="stuSex" value="男" title="男">
                    <input type="radio" name="stuSex" value="女" title="女" >
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">年龄</label>
                <div class="layui-input-block">
                    <input id="stuAge" type="text" name="stuAge" required  lay-verify="number" placeholder="学生年纪" autocomplete="off" class="layui-input" value="${stu.stuAge}">
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label">出生日期</label>
                <div class="layui-input-block">
                    <input type="text" name="birthday" required  lay-verify="" placeholder="单击此处选择日期" id="birthday" autocomplete="off" class="layui-input" value=${requestScope.stu.stuBirthday}>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">毕业院校</label>
                <div class="layui-input-block">
                    <input id="stuHisSchool" type="text" name="stuHisSchool"   placeholder="毕业院校" autocomplete="off" class="layui-input" value="${stu.stuHisSchool}">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">手机号码</label>
                <div class="layui-input-block">
                    <input id="stuPhone" type="text" name="stuPhone" required  lay-verify="phone" placeholder="11位电话" autocomplete="off" class="layui-input" value="${stu.stuPhone}">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">介绍老师</label>
                <div class="layui-input-block">
                    <input id="interTecher" type="text" name="interTecher" required  lay-verify="required" placeholder="介绍人" autocomplete="off" class="layui-input" value="${stu.interTecher}">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">入学时间</label>
                <div class="layui-input-block">
                    <input type="text" id="enterDate" name="enterDate" required  lay-verify="" placeholder="单击此处选择日期" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">学生状态</label>
                <div class="layui-input-block">
                    <input type="radio" name="stuStu" value="4" title="在读">
                    <input type="radio" name="stuStu" value="5" title="毕业">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">民族</label>
                <div class="layui-input-block">
                    <input id="stuNation" type="text" name="stuNation" required lay-verify="required" autocomplete="off" class="layui-input"  value="${stu.stuNation}">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">籍贯</label>
                <div class="layui-input-block">
                    <input id="stuNatives" type="text" name="stuNatives" required  placeholder="籍贯" lay-verify="required"  autocomplete="off" class="layui-input" value="${stu.stuNatives}">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">低保</label>
                <div class="layui-input-block">
                    <input type="text" id="dibao" name="dibao" placeholder="低保类型"  autocomplete="off" class="layui-input" value="${stu.dibao}">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">户籍性质</label>
                <div class="layui-input-block">
                    <input type="radio" name="residence" value="1" title="城镇">
                    <input type="radio" name="residence" value="2" title="农村">
                </div>
            </div>

        </div>

        <div style="width: 33%;height: 100%;float: left">
            <div class="layui-form-item">
                <label class="layui-form-label">所在班级</label>
                <div class="layui-input-block">
                    <select name="classId" placeholder=" ">
                        <c:forEach items="${classList}" var="stuClass">
                            <option value="${stuClass.classId}">${stuClass.className}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">所在楼栋</label>
                <div class="layui-input-block">
                    <select name="floorId"  placeholder=" ">
                        <c:forEach items="${foolList}" var="fool">
                            <option value="${fool.floorId}">${fool.floorName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">所在寝室</label>
                <div class="layui-input-block">
                    <select name="stuHours"   placeholder=" ">
                        <option value=" "> </option>
                        <c:forEach items="${hoursList}" var="hours">
                            <option value="${hours.stuHours}">${hours.hourName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">家庭地址</label>
                <div class="layui-input-block">
                    <input id="stuAddr" type="text" name="stuAddr" required  lay-verify="required" placeholder="准确到乡镇即可" autocomplete="off" class="layui-input" value="${stu.stuAddr}">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">身份证号</label>
                <div class="layui-input-block">
                    <input id="cardId" type="text" name="cardId" required  lay-verify="identity" placeholder="请输入11位完整的号码" autocomplete="off" class="layui-input" value="${stu.cardId}">
                </div>
            </div>




            <div class="layui-form-item">
                <label class="layui-form-label">中专</label>
                <div class="layui-input-block">
                    <input type="radio" name="isvocational" value="1" title="是" checked>
                    <input type="radio" name="isvocational" value="2" title="否">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">中专学校</label>
                <div class="layui-input-block">
                    <input id="vocationalsch" type="text" name="vocationalsch"  placeholder="毕业中专名" autocomplete="off" class="layui-input" value="${stu.vocationalsch}">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">中专学籍</label>
                <div class="layui-input-block">
                    <input id="vocationalflag" type="text" name="vocationalflag"  autocomplete="off" class="layui-input" value="${stu.vocationalflag}">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">学号</label>
                <div class="layui-input-block">
                    <input type="text" id="stuno" name="stuno"  lay-verify="number" placeholder="在校学号" autocomplete="off" class="layui-input" value="${stu.stuno}">
                </div>
            </div>

            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">说明</label>
                <div class="layui-input-block">
                    <textarea name="StuRemark" id="StuRemark" placeholder="请输入内容" class="layui-textarea" value=""></textarea>
                </div>
            </div>
        </div>

        <div style="width: 33%;height: 100%;float: left">
            <div class="layui-form-item">
                <label class="layui-form-label">省录取号</label>
                <div class="layui-input-block">
                    <input type="text" id="enrollno" name="enrollno"  lay-verify="number" autocomplete="off" class="layui-input" value="${stu.enrollno}">
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label">欠款金额</label>
                <div class="layui-input-block">
                    <input type="text" id="qkMoney" name="qkMoney"  lay-verify="" autocomplete="off" class="layui-input" value="${stu.qkMoney}">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">入学成绩</label>
                <div class="layui-input-block">
                    <input type="text" id="score" name="score"  lay-verify="" autocomplete="off" class="layui-input" value="${stu.score}">
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label">生源类型</label>
                <div class="layui-input-block">
                    <input type="text" id="sourceType" name="sourceType" required lay-verify="required" autocomplete="off" class="layui-input" value="${stu.sourceType}">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">担保人</label>
                <div class="layui-input-block">
                    <input type="text" id="danbaoren" name="danbaoren" required lay-verify="required"  autocomplete="off" class="layui-input" value="${stu.danbaoren}">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">报名号</label>
                <div class="layui-input-block">
                    <input type="text" id="baominghao" name="baominghao"  lay-verify="number"  autocomplete="off" class="layui-input" value="${stu.baominghao}">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">助学金</label>
                <div class="layui-input-block">
                    <input type="text" id="zhuxuejin" name="zhuxuejin"  lay-verify="number"  autocomplete="off" class="layui-input" value="${stu.zhuxuejin}">
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label">面试人</label>
                <div class="layui-input-block">
                    <input type="text" id="audition" name="audition"  autocomplete="off" class="layui-input" value="${stu.audition}">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">兵役</label>
                <div class="layui-input-block">
                    <input type="radio" name="soldier" value="是" title="是">
                    <input type="radio" name="soldier" value="否" title="否">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">住校</label>
                <div class="layui-input-block">
                    <input type="radio" name="zhuxiao" value="是" title="是">
                    <input type="radio" name="zhuxiao" value="否" title="否">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">退学</label>
                <div class="layui-input-block">
                    <input type="radio" name="tuixue" value="是" title="是">
                    <input type="radio" name="tuixue" value="否" title="否">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">休学</label>
                <div class="layui-input-block">
                    <input type="radio" name="xiuxue" value="是" title="是">
                    <input type="radio" name="xiuxue" value="否" title="否">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">发放电脑</label>
                <div class="layui-input-block">
                    <input type="radio" name="isComputer" value="是" title="是" >
                    <input type="radio" name="isComputer" value="否" title="否" >
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">领用电脑</label>
                <div class="layui-input-block">
                    <input type="radio" name="collar" value="是" title="是">
                    <input type="radio" name="collar" value="否" title="否" >
                </div>
            </div>
        </div>
    </div>

    <div style="width: 100%;height: 20%;margin-top:3%;float: left">
        <div class="layui-form-item">
            <div class="layui-input-block" style="top: 85px;left: 800px">
                <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </div>
</form>

<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
    var b = "${requestScope.stu.stuBirthday}";
    var e = "${requestScope.stu.stuEnterTime}";
    $("#birthday").val(createTime(b));
    $("#enterDate").val(createTime(e));

    function openMain() {
        window.open("<%=request.getContextPath()%>/stu/home","_self");
    }
    function createTime(v){
        var date = new Date(v);
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        m = m<10?'0'+m:m;
        var d = date.getDate();
        d = d<10?("0"+d):d;
        var str = y+"-"+m+"-"+d;
        return str;
    }


    layui.use(['form','laydate'], function(){

        laydate.render({
            elem: '#birthday'

        });

        laydate.render({
            elem: '#enterDate'
        });

        var form = layui.form;
        form.val("gg",{
            "stuSex":"${requestScope.stu.stuSex}"
             ,"stuHours":"${requestScope.stu.stuHours}"
            ,"classId" :${requestScope.stu.classId}
            ,"floorId":${requestScope.stu.floorId}
            ,"stuStu":"${requestScope.stu.stuStu}"
            ,"residence":"${requestScope.stu.residence}"
            ,"studyType":"${requestScope.stu.studyType}"
            ,"isvocational":"${requestScope.stu.isvocational}"
            ,"soldier":"${requestScope.stu.soldier}"
            ,"zhuxiao":"${requestScope.stu.zhuxiao}"
            ,"tuixue":"${requestScope.stu.tuixue}"
            ,"collar":"${requestScope.stu.collar}"
            ,"isComputer":"${requestScope.stu.isComputer}"
            ,"xiuxue":"${requestScope.stu.xiuxue}"
        })

        //监听提交
        form.on('submit(formDemo)', function(data){
            return true;
        });



    });
    //Demo

</script>
</body>
</html>
