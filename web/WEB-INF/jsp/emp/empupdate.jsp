<%@ page import="com.nothing.vo.emp.Emp" %>
<%@ page import="com.nothing.vo.emp.Post" %>
<%@ page import="com.nothing.vo.emp.EmpEducation" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/5
  Time: 20:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改员工信息</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    </head>
<body>
<form class="layui-form" lay-filter="formTest">
    <div style="width: 56%;height: auto;margin-top: 1%">
        <div style="width:50%;height:100%;float: left">
            <div class="layui-form-item">
                <label class="layui-form-label">姓名*</label>
                <div class="layui-input-block">
                    <input id="xm" type="text" name="empName" required  lay-verify="required" placeholder="请输入教师姓名" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">职务*</label>
                <div class="layui-input-block">
                    <input id="zw" type="text" name="postName" required  lay-verify="required" placeholder="请输入所在部门的职务" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">性别</label>
                <div class="layui-input-block">
                    <input type="radio" name="empSex" value="男" title="男" >
                    <input type="radio" name="empSex" value="女" title="女" >
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">出生日期</label>
                <div class="layui-input-block">
                    <input type="text" name="birthday" placeholder="单击此处选择日期" id="srtime" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">手机号码*</label>
                <div class="layui-input-block">
                    <input id="sjhm" type="text" name="empPhone" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">微信号码*</label>
                <div class="layui-input-block">
                    <input id="wxhm" type="text" name="empWeixin" required  lay-verify="required" placeholder="可手机号可微信号" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">入职时间*</label>
                <div class="layui-input-block">
                    <input type="text" name="ruzhitime" required  lay-verify="required" placeholder="单击此处选择日期" id="rutime" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">婚姻状况</label>
                <div class="layui-input-block">
                    <select name="empMarried">
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
                    <input id="zhmc" type="text" name="empBankaccountName" placeholder="银行账号名" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">开户银行*</label>
                <div class="layui-input-block">
                    <input id="khyh" type="text" name="empBankNumber" required  lay-verify="required" placeholder="银行名称" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">银行账号*</label>
                <div class="layui-input-block">
                    <input id="yhzh" type="text" name="empBank" required  lay-verify="required" placeholder="银行卡号码" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </div>

        <div style="width: 50%;height: 100%;float: left">
            <div class="layui-form-item">
                <label class="layui-form-label">所在部门*</label>
                <div class="layui-input-block">
                    <select name="empDeptId" lay-verify="required">
                        <option value="0" >宏图软件</option>
                        <option value="1">教研部</option>
                        <option value="2" >行政部</option>
                        <option value="3" >后勤部</option>
                        <option value="4" >学工部</option>
                        <option value="5" >招生部</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">家庭地址</label>
                <div class="layui-input-block">
                    <input id="jtdz" type="text" name="empAddress" placeholder="准确到乡镇即可" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">身份证号*</label>
                <div class="layui-input-block">
                    <input id="sfzh" type="text" name="empCardno" required  lay-verify="required" placeholder="请输入11位完整的号码" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">籍贯*</label>
                <div class="layui-input-block">
                    <input id="jg" type="text" name="empNation" required  lay-verify="required" placeholder="准确到镇即可" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">QQ号码</label>
                <div class="layui-input-block">
                    <input id="qq" type="text" name="empQQ" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">邮件地址*</label>
                <div class="layui-input-block">
                    <input id="yjdz" type="text" name="empEmail" required  lay-verify="required" placeholder="用于找回密码" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">毕业学校</label>
                <div class="layui-input-block">
                    <input id="byxx" type="text" name="empUniversity" placeholder="填写学历最高的学校" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">最高学历*</label>
                <div class="layui-input-block">
                    <select id="zgxl" name="empDegree" lay-verify="required">
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
                    <input id="zy" type="text" name="EmpEduMajor" placeholder="在校所学专业" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">支付宝*</label>
                <div class="layui-input-block">
                    <input id="zfb" type="text" name="empAlipay" required  lay-verify="required" placeholder="输入支付宝账号" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">说明</label>
                <div class="layui-input-block">
                    <textarea name="empRemark" placeholder="请输入内容" class="layui-textarea"></textarea>
                </div>
            </div>
            <input type="hidden" name="empId">
            <input type="hidden" name="postId">
            <input type="hidden" name="empEduId">
        </div>
    </div>
</form>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
    layui.use(['form','layer'], function(){
        $ = layui.jquery;
        var form = layui.form
            ,layer = layui.layer;

        form.val("formTest",{//formTest 即 class="layui-form" 所在元素属性 lay-filter="" 对应的值
            "empId":${requestScope.emp.empId}
            ,"postId":${requestScope.postvo.postId}
            ,"empEduId":${requestScope.emdutvo.empEduId}
            ,"empName":"${requestScope.emp.empName}"
            ,"postName":"${requestScope.postvo.postName}"
            ,"empSex":"${requestScope.emp.empSex}"
            ,"birthday":"${requestScope.emp.empBirthday}"
            ,"empPhone":"${requestScope.emp.empPhone}"
            ,"empWeixin":${requestScope.emp.empWeixin}
            ,"empFireday":"${requestScope.emp.empFireday}"
            ,"empMarried":"${requestScope.emp.empMarried}"
            ,"empBankaccountName":"${requestScope.emp.empBankaccountName}"
            ,"empBankNumber":"${requestScope.emp.empBankNumber}"
            ,"empBank":"${requestScope.emp.empBank}"
            ,"empDeptId":${requestScope.emp.empDeptId}
            ,"empAddress":"${requestScope.emp.empAddress}"
            ,"empCardno":"${requestScope.emp.empCardno}"
            ,"empNation":"${requestScope.emp.empNation}"
            ,"empQQ":"${requestScope.emp.empQQ}"
            ,"empEmail":"${requestScope.emp.empEmail}"
            ,"empAlipay":"${requestScope.emp.empAlipay}"
            ,"empRemark":"${requestScope.emp.empRemark}"
            ,"empUniversity":"${requestScope.emdutvo.empUniversity}"
            ,"empDegree":"${requestScope.emdutvo.empDegree}"
            ,"empEduMajor":"${requestScope.emdutvo.empEduMajor}"
        });

        //自定义验证规则
        /*form.verify({
            nikename: function(value){
                if(value.length < 5){
                    return '昵称至少得5个字符啊';
                }
            }
            ,pass: [/(.+){6,12}$/, '密码必须6到12位']
            ,repass: function(value){
                if($('#L_pass').val()!=$('#L_repass').val()){
                    return '两次密码不一致';
                }
            }
        });*/

        //监听提交
        form.on('submit(formDemo)', function(data){
            $.ajax({
                url:'${pageContext.request.contextPath}/emp/update',
                type:'post',
                data:data.field,
                dataType:'json',
                success:function (data){
                    layer.alert("修改成功", {icon: 6},function(){
                        // 获得frame索引
                        var index = parent.layer.getFrameIndex(window.name);
                        //关闭当前frame
                        parent.layer.close(index);
                        setTimeout(function () {
                            window.parent.location.reload(); //修改成功后刷新父界面
                        })
                    });
                }
            });
        });
    });

    //fuzhi();
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
