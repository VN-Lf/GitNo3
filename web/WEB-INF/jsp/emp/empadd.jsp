<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/4
  Time: 14:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增员工</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
</head>
<body>
<form class="layui-form" action="${pageContext.request.contextPath}/emp/empadd" method="post">
    <input type="button" value="赋值" onclick="fuzhi()">
    <div style="width: 56%;height: 69%;margin-top: 1%">
        <div style="width:50%;height:100%;float: left">
            <div class="layui-form-item">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-block">
                    <input id="xm" type="text" name="empName" required  lay-verify="required" placeholder="请输入教师姓名" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">职务</label>
                <div class="layui-input-block">
                    <input id="zw" type="text" name="postName" required  lay-verify="required" placeholder="请输入所在部门的职务" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">性别</label>
                <div class="layui-input-block">
                    <input type="radio" name="empSex" value="男" title="男">
                    <input type="radio" name="empSex" value="女" title="女" checked>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">出生日期</label>
                <div class="layui-input-block">
                    <input type="text" name="birthday" required  lay-verify="required" placeholder="单击此处选择日期" id="srtime" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">手机号码</label>
                <div class="layui-input-block">
                    <input id="sjhm" type="text" name="empPhone" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">微信号码</label>
                <div class="layui-input-block">
                    <input id="wxhm" type="text" name="empWeixin" required  lay-verify="required" placeholder="可手机号可微信号" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">入职时间</label>
                <div class="layui-input-block">
                    <input type="text" name="ruzhitime" required  lay-verify="required" placeholder="单击此处选择日期" id="rutime" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">婚姻状况</label>
                <div class="layui-input-block">
                    <select name="empMarried" lay-verify="required">
                        <option value="">请选择</option>
                        <option value="已婚">已婚</option>
                        <option value="单身">单身</option>
                        <option value="离异">离异</option>
                        <option value="丧偶">丧偶</option>
                        <option value="恋爱">恋爱</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">账户名称</label>
                <div class="layui-input-block">
                    <input id="zhmc" type="text" name="empBankaccountName" required  lay-verify="required" placeholder="银行账号名" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">开户银行</label>
                <div class="layui-input-block">
                    <input id="khyh" type="text" name="empBankNumber" required  lay-verify="required" placeholder="银行名称" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">银行账号</label>
                <div class="layui-input-block">
                    <input id="yhzh" type="text" name="empBank" required  lay-verify="required" placeholder="银行卡号码" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>

        <div style="width: 50%;height: 100%;float: left">
            <div class="layui-form-item">
                <label class="layui-form-label">所在部门</label>
                <div class="layui-input-block">
                    <select name="empDeptId" lay-verify="required">
                        <option value="0">宏图软件</option>
                        <option value="1">教研部</option>
                        <option value="2">行政部</option>
                        <option value="3">后勤部</option>
                        <option value="4">学工部</option>
                        <option value="5">招生部</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">家庭地址</label>
                <div class="layui-input-block">
                    <input id="jtdz" type="text" name="empAddress" required  lay-verify="required" placeholder="准确到乡镇即可" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">身份证号</label>
                <div class="layui-input-block">
                    <input id="sfzh" type="text" name="empCardno" required  lay-verify="required" placeholder="请输入11位完整的号码" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">籍贯</label>
                <div class="layui-input-block">
                    <input id="jg" type="text" name="empNation" required  lay-verify="required" placeholder="准确到镇即可" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">QQ号码</label>
                <div class="layui-input-block">
                    <input id="qq" type="text" name="empQQ" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">邮件地址</label>
                <div class="layui-input-block">
                    <input id="yjdz" type="text" name="empEmail" required  lay-verify="required" placeholder="用于找回密码" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">毕业学校</label>
                <div class="layui-input-block">
                    <input id="byxx" type="text" name="empUniversity" required  lay-verify="required" placeholder="填写学历最高的学校" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">最高学历</label>
                <div class="layui-input-block">
                    <select name="empDegree" lay-verify="required">
                        <option value="">请选择</option>
                        <option value="高中及以下">高中及以下</option>
                        <option value="大专">大专</option>
                        <option value="本科">本科</option>
                        <option value="本科以上">本科以上</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">专业</label>
                <div class="layui-input-block">
                    <input id="zy" type="text" name="EmpEduMajor" required  lay-verify="required" placeholder="在校所学专业" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">支付宝</label>
                <div class="layui-input-block">
                    <input id="zfb" type="text" name="empAlipay" required  lay-verify="required" placeholder="输入支付宝账号" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">登录密码</label>
                <div class="layui-input-block">
                    <input type="password" name="empLogPsw" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
    </div>
    <div style="width: 56%;height: 20%;margin-top:3%;float: left">
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">说明</label>
            <div class="layui-input-block">
                <textarea name="empRemark" placeholder="请输入内容" class="layui-textarea"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </div>
    <div style="width: 56%;height: auto;margin-top:3%;float: left">


    </div>
</form>

<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
    function fuzhi() {
        document.getElementById("xm").value="姓名";
        document.getElementById("zw").value="副主任";
        document.getElementById("sjhm").value="186461651156";
        document.getElementById("wxhm").value="1231313";
        document.getElementById("zhmc").value="abc123";
        document.getElementById("zhmc").value="1123312";
        document.getElementById("khyh").value="农业银行";
        document.getElementById("jtdz").value="家庭地址";
        document.getElementById("sfzh").value="36073215112312";
        document.getElementById("jg").value="江西省赣州市";
        document.getElementById("qq").value="222908562";
        document.getElementById("yjdz").value="222908562@qq.com";
        document.getElementById("byxx").value="宏图学院";
        document.getElementById("zy").value="汽修";
        document.getElementById("zfb").value="186461651156";
    }
    layui.use('form', function(){
        var form = layui.form;

        //监听提交
        form.on('submit(formDemo)', function(data){
            layer.msg(JSON.stringify(data.field));
            return true;
        });
    });
    //Demo
    layui.use('laydate', function(){
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#rutime' //指定元素
        });
    });

    layui.use('laydate', function(){
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#srtime' //指定元素
        });
    });
</script>
</body>
</html>
