<%--
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
<head><!---->
    <title>新增学生资料</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/layui/laydate/laydate.js"></script> <!-- 改成你的路径 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/laydate/theme/default/laydate.css">
</head>
<body>
<form class="layui-form" action="${pageContext.request.contextPath}/stu/update/add" method="post">
    <div style="width: 100%;height: 69%;margin-top: 1%">
        <div style="width:33%;height:100%;float: left">
        <input type="hidden" value="0">
            <div class="layui-form-item">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-block">
                    <input id="stuName" type="text" name="stuName"   lay-verify="required" placeholder="请输入学生姓名" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">登录密码</label>
                <div class="layui-input-block">
                    <input id="stuPsw" type="text" name="stuPsw" required  lay-verify="required"  autocomplete="off" class="layui-input" title="默认123456" value="123456">
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label">性别</label>
                <div class="layui-input-block">
                    <input type="radio" name="stuSex" value="男" title="男">
                    <input type="radio" name="stuSex" value="女" title="女" checked>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">年龄</label>
                <div class="layui-input-block">
                    <input id="stuAge" type="text" name="stuAge" required  lay-verify="number" placeholder="学生年纪" autocomplete="off" class="layui-input">
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label">出生日期</label>
                <div class="layui-input-block">
                    <input type="text" name="birthday" required  lay-verify="required" placeholder="单击此处选择日期" id="birthday" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">毕业院校</label>
                <div class="layui-input-block">
                    <input id="stuHisSchool" type="text" name="stuHisSchool" required  lay-verify="required" placeholder="毕业院校" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">手机号码</label>
                <div class="layui-input-block">
                    <input id="stuPhone" type="text" name="stuPhone" required  lay-verify="phone" placeholder="11位电话" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">介绍老师</label>
                <div class="layui-input-block">
                    <input id="interTecher" type="text" name="interTecher" required  lay-verify="required" placeholder="介绍人" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">入学时间</label>
                <div class="layui-input-block">
                    <input type="text" id="enterDate" name="enterDate" required  lay-verify="required" placeholder="单击此处选择日期" id="rutime" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">学生状态</label>
                <div class="layui-input-block">
                    <input type="radio" name="stuStu" value="1" title="状态1">
                    <input type="radio" name="stuStu" value="2" title="状态2" checked>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">民族</label>
                <div class="layui-input-block">
                    <input id="stuNation" type="text" name="stuNation" required placeholder="民族" lay-verify="required" autocomplete="off" class="layui-input" value="">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">籍贯</label>
                <div class="layui-input-block">
                    <input id="stuNatives" type="text" name="stuNatives" required  placeholder="籍贯" lay-verify="required"  autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">低保</label>
                <div class="layui-input-block">
                    <input type="text" id="dibao" name="dibao" placeholder="低保类型"  autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">户籍性质</label>
                <div class="layui-input-block">
                    <input type="radio" name="residence" value="1" title="城镇">
                    <input type="radio" name="residence" value="2" title="农村" checked>
                </div>
            </div>

        </div>

        <div style="width: 33%;height: 100%;float: left">
            <div class="layui-form-item">
                <label class="layui-form-label">所在班级</label>
                <div class="layui-input-block">
                    <select name="classId" placeholder=" " >
                        <option value=""> </option>
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
                        <option value=" "> </option>
                        <c:forEach items="${foolList}" var="fool">
                            <option value="${fool.floorId}">${fool.floorName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label">所在楼栋</label>
                <div class="layui-input-block">
                    <select name="stuHours"  placeholder="  ">
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
                    <input id="stuAddr" type="text" name="stuAddr" required  lay-verify="required" placeholder="准确到乡镇即可" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">身份证号</label>
                <div class="layui-input-block">
                    <input id="cardId" type="text" name="cardId" required  lay-verify="identity" placeholder="请输入11位完整的号码" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">专业</label>
                <div class="layui-input-block">
                    <input id="stuProfessional" type="text" name="stuProfessional"   placeholder="所学专业"  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">专业类别</label>
                <div class="layui-input-block">
                    <input id="stuProLevel" type="text" name="stuProLevel"   placeholder="专业所属" autocomplete="off" class="layui-input">
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label">学业状态</label>
                <div class="layui-input-block">
                    <input type="radio" name="studyType" value="毕业" title="毕业">
                    <input type="radio" name="studyType" value="在校" title="在校" checked>
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
                    <input id="vocationalsch" type="text" name="vocationalsch"  placeholder="毕业中专名" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">中专学籍</label>
                <div class="layui-input-block">
                    <input id="vocationalflag" type="text" name="vocationalflag"  autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">学号</label>
                <div class="layui-input-block">
                    <input type="text" id="stuno" name="stuno"  lay-verify="number" placeholder="在校学号" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">说明</label>
                <div class="layui-input-block">
                    <textarea name="StuRemark" id="StuRemark" placeholder="请输入内容" class="layui-textarea"></textarea>
                </div>
            </div>
        </div>

        <div style="width: 33%;height: 100%;float: left">
            <div class="layui-form-item">
                <label class="layui-form-label">省录取号</label>
                <div class="layui-input-block">
                    <input type="text" id="enrollno" name="enrollno"  lay-verify="number" autocomplete="off" class="layui-input">
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label">欠款金额</label>
                <div class="layui-input-block">
                    <input type="text" id="qkMoney" name="qkMoney"  lay-verify="number" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">入学成绩</label>
                <div class="layui-input-block">
                    <input type="text" id="score" name="score"  lay-verify="number" autocomplete="off" class="layui-input">
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label">生源类型</label>
                <div class="layui-input-block">
                    <input type="text" id="sourceType" name="sourceType"  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">担保人</label>
                <div class="layui-input-block">
                    <input type="text" id="danbaoren" name="danbaoren" required lay-verify="required"  autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">报名号</label>
                <div class="layui-input-block">
                    <input type="text" id="baominghao" name="baominghao"  lay-verify="number"  autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">助学金</label>
                <div class="layui-input-block">
                    <input type="text" id="zhuxuejin" name="zhuxuejin"  lay-verify="number"  autocomplete="off" class="layui-input">
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label">面试人</label>
                <div class="layui-input-block">
                    <input type="text" id="audition" name="audition"  autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">兵役</label>
                <div class="layui-input-block">
                    <input type="radio" name="soldier" value="是" title="是">
                    <input type="radio" name="soldier" value="否" title="否" checked>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">住校</label>
                <div class="layui-input-block">
                    <input type="radio" name="zhuxiao" value="是" title="是" checked>
                    <input type="radio" name="zhuxiao" value="否" title="否">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">退学</label>
                <div class="layui-input-block">
                    <input type="radio" name="tuixue" value="是" title="是">
                    <input type="radio" name="tuixue" value="否" title="否" checked>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">休学</label>
                <div class="layui-input-block">
                    <input type="radio" name="xiuxue" value="是" title="是">
                    <input type="radio" name="xiuxue" value="否" title="否" checked>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">发放电脑</label>
                <div class="layui-input-block">
                    <input type="radio" name="isComputer" value="是" title="是" checked>
                    <input type="radio" name="isComputer" value="否" title="否" >
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">领用电脑</label>
                <div class="layui-input-block">
                    <input type="radio" name="collar" value="是" title="是">
                    <input type="radio" name="collar" value="否" title="否" checked>
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
    layui.use(['form','laydate'], function(){
        var form = layui.form;

        //监听提交
        form.on('submit(formDemo)', function(data){
            layer.msg(JSON.stringify(data.field));
            return true;
        });


        laydate.render({
            elem: '#birthday' //指定元素
        });

        laydate.render({
            elem: '#enterDate' //指定元素o
        });
    });
    //Demo
</script>
</body>
</html>
