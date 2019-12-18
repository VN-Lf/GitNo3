<%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/12/4
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
    <meta charset="utf-8">
    <title>table模块快速使用/</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/layui/laydate/laydate.js"></script> <!-- 改成你的路径 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/laydate/theme/default/laydate.css">
    <script src="${pageContext.request.contextPath}/jquery.js"></script>
</head>
<body>


<h1></h1>
<div class="layui-row">
    </div>
    <table id="demo" lay-filter="test">

    </table>
</div>
<div class="layui-row" style="height:45%">
    下面部分的
    <div class="layui-tab">
        <ul class="layui-tab-title">
            <li>家庭情况</li>
            <li>教育经历</li>
            <li>事故记录</li>
            <li>答辩成绩</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <table id="fal" lay-filter="test2" lay-filter="fal1"></table>
            </div>
            <div class="layui-tab-item">
                <table id="edu" lay-filter="test2"></table>
            </div>
            <div class="layui-tab-item">
                <table id="stuHap" lay-filter="test2"></table>
            </div>
            <div class="layui-tab-item">
                <table id="stuReply" lay-filter="test2"></table>
            </div>
        </div>
    </div>
</div>
<!--附表表单-->
<!--附表家庭-->
<form  class="layui-form" id="addFalForm" style="display:none;height: auto;width: 600px" method="post">
    <input id="stuFamilyid" type="hidden" name="stuFamilyid">
    <div class="layui-form-item">
        <label class="layui-form-label">姓名</label>
        <div class="layui-input-block">
            <input id="stuFamilyName" type="text" name="stuFamilyName" required  lay-verify="required" placeholder="家长姓名" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">关系</label>
        <div class="layui-input-block">
            <input id="relation" type="text" name="relation" required  lay-verify="required" placeholder="与学生关系" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">联系方式</label>
        <div class="layui-input-block">
            <input id="familyPhone" type="text" name="familyPhone" required  lay-verify="phone" placeholder="家长电话" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemoFal">确定</button>
        </div>
    </div>
</form>
<!--附表教育-->
<form  class="layui-form" id="addEduForm" style="display:none;height: auto;width: 600px" method="post">

    <input type="hidden"name="EduId" id="EduId">

    <div class="layui-form-item">
        <label class="layui-form-label">学校</label>
        <div class="layui-input-block">
            <input id="hisSchool" type="text" name="hisSchool" required  lay-verify="required" placeholder="学校名称" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">入学时间</label>
        <div class="layui-input-block">
            <input type="text" name="beginDH" id="beginDH" required  lay-verify="required" placeholder="单击此处选择日期"  autocomplete="off" class="layui-input">
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label">毕业时间</label>
        <div class="layui-input-block">
            <input type="text" name="endDH" id="endDH" required  lay-verify="required" placeholder="单击此处选择日期" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemoEdu">确定</button>
        </div>
    </div>
</form>
<!--附表事故-->
<form  class="layui-form" id="addHapForm" style="display:none;height: auto;width: 600px" method="post">

    <input type="hidden" name="stuHappenId" id="stuHappenId">
    <input type="hidden" name="hapEmpID" id="hapEmpID">

    <div class="layui-form-item">
        <label class="layui-form-label">事件</label>
        <div class="layui-input-block">
            <input id="happening" type="text" name="happening" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">发生时间</label>
        <div class="layui-input-block">
            <input id="opTime" type="text" name="opTime" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">记录老师</label>
        <div class="layui-input-block">
            <input id="hapEmpName" type="text" name="hapEmpName" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input" disabled>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemoHap">确定</button>
        </div>
    </div>
</form>

<script src="${pageContext.request.contextPath}/layui/layui.js">

</script>
<script>
    layui.use(['table','laydate','tree'], function(){
        var table = layui.table;
        var tId = layui.table.id;
        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 400
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/stu/student/toList' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {type:'checkbox'}//复选框
                ,{field: 'studId', title: 'ID', width:100, sort: true}
                ,{field: 'stuName', title: '名字', width:100}
                ,{field: 'stuHisSchool', title:'毕业院校', width:80}
                ,{field: 'stuSex', title: '性别', width:80, sort: true}
                ,{field: 'stuAge', title: '年龄', width:80}
                ,{field: 'stuBirthday', title: '生日', width: 177, templet:function (row){
                        return createTime(row.stuBirthday);
                    }
                }
                ,{field: 'stuPhone', title:'电话', width:80}
                ,{field: 'stuAddr', title: '地址', width: 177}
                ,{field: 'classNames', title:'班级名', width:80}
                ,{field: 'hourNames', title: '寝室名', width:80, sort: true}
                ,{field: 'stuHouse', title: '寝室号', width:80}
                ,{field: 'interTecher', title: '介绍老师', width: 177}
                ,{field: 'stuStu', title: '状态', width:80}
                ,{field: 'stuNation', title: '民族', width: 177}
                ,{field: 'stuNatives', title: '籍贯', width:80, sort: true}
                ,{field: 'residence', title: '户籍性质', width:80}
                ,{field: 'cardId', title: '身份证', width: 177}
                ,{field: 'stuProfessional', title:'专业', width:80}
                ,{field: 'stuProLevel', title: '专业类别', width:80, sort: true}
                ,{field: 'studyType', title: '学习类别', width:80}
                ,{field: 'audition', title: '面试人', width: 177}
                ,{field: 'isvocational', title: '是否中专', width:80, sort: true}
                ,{field: 'qkMoney', title: '欠款金额', width:80}
                ,{field: 'score', title: '入学成绩', width: 177}
                ,{field: 'dibao', title: '低保', width:80, sort: true}
                ,{field: 'sourceType', title: '成绩类型', width:80}
                ,{field: 'danbaoren', title: '担保人', width: 177}
                ,{field: 'soldier', title:'兵役', width:80}
                ,{field: 'baominghao', title: '报名号', width:80, sort: true}
                ,{field: 'zhuxiao', title: '是否住校', width:80}
                ,{field: 'StuRemark', title: '说明', width:80}
                ,{field: 'zhuxuejin', title: '助学金', width:80}
                ,{field: 'tuixue', title: '是否退学', width:80}
                ,{field: 'xiuxue', title: '是否休学', width:80}
                ,{field: 'isComputer', title: '是否发放电脑', width:80}
                ,{field: 'collar', title: '是否领走电脑', width:80}
                ,{width:150, title: '操作',align:'center',fixed: 'right', toolbar: '#barDemo'}
            ]]
        });

        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'isDele':
                    var checkStatus = table.checkStatus('demo'),
                        data = checkStatus.data,
                        employeesId = "";
                    if(data.length > 0){
                        for (var i in data){
                            employeesId+=data[i].studId+",";
                        }
                        layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'},function (index){
                            $.post('${pageContext.request.contextPath}/stu/toDel/main',{
                                id:employeesId
                            },function(data){
                                table.reload("demo");
                                layer.close(index);
                            });
                        });
                    }else{
                        layer.msg('请选择需要删除的数据');
                    }
                    break;
                    case 'isAdd':
                        var sid = 0;
                        window.open("${pageContext.request.contextPath}/stu/toAdd?stuId="+sid);
                    break;
                    case 'isSelect':
                        var stuSelectName = $('input[name="stuSelectName"]').val();
                        var stuSelectCla = $('#stuSelectCla').val();
                        var stuSelectPhone = $('input[name="stuSelectPhone"]').val();
                        var stuSelectFloor  = $('#stuSelectFloor').val();
                    table.reload('demo',{
                        page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        , url: '${pageContext.request.contextPath}'
                        , method:'POST'
                        ,where:{
                            stuSelectName:stuSelectName,
                            stuSelectCla:stuSelectCla,
                            stuSelectPhone:stuSelectPhone,
                            stuSelectFloor:stuSelectFloor
                        }
                    });
                    break;
            };
        });

        table.on('tool(test)', function(obj){
            var data = obj.data;
            switch(obj.event){
                case 'edit':
                    var stuId = data.studId;
                    window.open("${pageContext.request.contextPath}/stu/toAdd?stuId="+stuId);
                    break;
            }
        });

        //双击击行事件
        table.on('rowDouble(test)',function(obj){
                var oo = obj.tr //得到当前行元素对象
                var o = obj.data //得到当前行数据
                var studId = o.studId;
                var stuName = o.stuName
                addTable(studId,stuName);
        });

        laydate.render({
            elem: '#beginDH' //指定元素
        });

        laydate.render({
            elem: '#endDH' //指定元素o
        });

    });


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

    //底部的
    function addTable(studId,stuName){
        var openStuAc;
        var table = layui.table;
        layui.use('table', function(){
            //家庭表
            table.render({
                elem: '#fal'
                ,height: 200
                ,toolbar: '#toolbarDemo2' //开启头部工具栏，并为其绑定左侧模板
                ,url: '${pageContext.request.contextPath}/stu/stuFal/select?studId='+studId//数据接口
                ,page: true //开启分页
                ,cols: [[ //表头
                    {type:'checkbox'}//复选框
                    ,{field: 'stuFamilyid', title: 'ID', width:100, sort: true}
                    ,{field: 'familyPhone', title: '电话', width:100, sort: true}
                    ,{field: 'relation', title:'与学生关系', width:80}
                    ,{field: 'stuFamilyName', title: '姓名', width:80, sort: true}
                    ,{field: stuName, title: '学生名字', width:80 ,templet:function (stuName){
                            return stuName+"";
                        }}
                    ,{width:150, title: '操作',align:'center',fixed: 'right', toolbar: '#barDemo2'}
                ]]
            });
            //事件表
           table.render({
                elem: '#stuHap'
                ,height: 200
                ,toolbar: '#toolbarDemo4' //开启头部工具栏，并为其绑定左侧模板
                ,url: '${pageContext.request.contextPath}/stu/stuHap/select?studId='+studId//数据接口
                ,page: true //开启分页
                ,cols: [[ //表头
                    {type:'checkbox'}//复选框
                    ,{field: 'stuHappenId', title: 'ID', width:100, sort: true}
                    ,{field: 'opTime', title: '时间', width:100, sort: true,
                           templet:function (row){
                               return createTime(row.opTime);
                           }}
                    ,{field: 'empNames', title:'教师名称', width:80}
                   ,{field: 'empId', title:'教师ID', width:80}
                    ,{field: 'happening', title: '事件', width:80, sort: true}
                    ,{field: stuName, title: '学生名字', width:80 ,templet:function (stuName){
                            return  stuName+"";
                    }}
                ]]
            });
            //答辩表
            table.render({
                elem: '#stuReply'
                ,height: 200
                ,toolbar: '#toolbarDemo2' //开启头部工具栏，并为其绑定左侧模板
                ,url: '${pageContext.request.contextPath}/stu/stuReply/select?studId='+studId//数据接口
                ,page: true //开启分页
                ,cols: [[ //表头
                    {type:'checkbox'}//复选框
                    ,{field: 'stuReplyId', title: 'ID', width:100, sort: true}
                    ,{field: 'Score1', title: '1', width:100, sort: true}
                    ,{field: 'Score2', title:'2', width:80}
                    ,{field: 'Score3', title: '3', width:80, sort: true}
                    ,{field: 'Score4', title: '4', width:100, sort: true}
                    ,{field: 'Score5', title:'5', width:80}
                    ,{field: 'Score6', title: '6', width:80, sort: true}
                    ,{field: 'Score7', title: '7', width:100, sort: true}
                    ,{field: 'Score8', title:'8', width:80}
                    ,{field: 'Score8', title:'9', width:80}
                    ,{field: 'empNames', title:'教师名字', width:80}
                    ,{field: 'empId', title:'教师ID', width:80}
                    ,{field: stuName, title: '学生名字', width:80 ,templet:function(stuName){
                            return stuName+"";
                        }}
                ]]
            });
            //教育表
            table.render({
                elem: '#edu'
                ,height: 200
                ,toolbar: '#toolbarDemo3' //开启头部工具栏，并为其绑定左侧模板
                ,url: '${pageContext.request.contextPath}/stu/stuEdu/select?studId='+studId//数据接口
                ,page: true //开启分页
                ,cols: [[ //表头
                    {type:'checkbox'}//复选框
                    ,{field: 'EduId', title: 'ID', width:100, sort: true}
                    ,{field: 'beginDate', title: '开始时间', width:100, sort: true,
                        templet:function (row){
                            return createTime(row.beginDate);
                        }}
                    ,{field: 'endDate', title:'结束时间', width:80,
                        templet:function (row){
                            return createTime(row.endDate);
                        }}
                    ,{field: 'hisSchool', title: '毕业院校', width:80, sort: true}
                    ,{field: stuName, title: '学生名字', width:80 ,templet:function (stuName){
                            return stuName+"";
                        }}
                    ,{width:150, title: '操作',align:'center',fixed: 'right', toolbar: '#barDemo3'}
                ]]
            });

            table.on('toolbar(test2)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id);
                switch(obj.event){
                    case 'addFal':
                        openStuAc =layer.open({
                            type: 1,
                            title:"新增",
                            area:['700px','400px'],
                            content: $("#addFalForm"),
                            closeBtn :1,
                            success: function(layero, index){
                                document.getElementById("addFalForm").reset();
                                $("#stuFamilyid").val(0);
                            }
                        });
                        break;
                    case 'addEdu':
                        openStuAc = layer.open({
                            type: 1,
                            title:"新增",
                            area:['700px','400px'],
                            content: $("#addEduForm"),
                            closeBtn :1,
                            success: function(layero, index){
                                document.getElementById("addEduForm").reset();
                                $("#EduId").val(0);
                            }
                        });
                        break;
                    case 'addHap':
                        openStuAc = layer.open({
                            type: 1,
                            title:"新增",
                            area:['700px','400px'],
                            content: $("#addHapForm"),
                            closeBtn :1,
                            success: function(layero, index){
                                document.getElementById("addHapForm").reset();
                                $("#stuHappenId").val(0);
                            }
                        });
                        break;
                    case 'delFal':
                        var checkStatus = table.checkStatus('fal'),
                            data = checkStatus.data,
                            employeesId = "";
                        if(data.length > 0){
                            for (var i in data){
                                employeesId+=data[i].stuFamilyid+",";
                            }
                            layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'},function (index){
                                $.post('${pageContext.request.contextPath}/stu/toDel/fal',{
                                    id:employeesId
                                },function(data){
                                    table.reload("fal");
                                    layer.close(index);
                                });
                            });
                        }else{
                            layer.msg('请选择需要删除的数据');
                        };
                        break;
                    case 'delEdu':
                        var checkStatus = table.checkStatus('edu'),
                            data = checkStatus.data,
                            employeesId = "";
                        if(data.length > 0){
                            for (var i in data){
                                employeesId+=data[i].EduId+",";
                            }
                            layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'},function (index){
                                $.post('${pageContext.request.contextPath}/stu/toDel/edu',{
                                    id:employeesId
                                },function(data){
                                    table.reload("edu");
                                    layer.close(index);
                                });
                            });
                        }else{
                            layer.msg('请选择需要删除的数据');
                        };
                        break;
                    case 'delHap':
                        var checkStatus = table.checkStatus('stuHap'),
                            data = checkStatus.data,
                            employeesId = "";
                        if(data.length > 0){
                            for (var i in data){
                                employeesId+=data[i].stuHappenId+",";
                            }
                            layer.confirm('确定删除选中的数据？', {icon: 3, title: '提示信息'},function (index){
                                $.post('--%>/stu/toDel/hap',{
                                    id:employeesId
                                },function(data){
                                    table.reload("stuHap");
                                    layer.close(index);
                                });
                            });
                        }else{
                            layer.msg('请选择需要删除的数据');
                        };
                        break;

                };
            });

            table.on('tool(test2)', function(obj){
                var data = obj.data;
                switch(obj.event){
                    case 'editFal':
                        openStuAc = layer.open({
                            type: 1,
                            title:'家庭信息修改',
                            skin: 'layui-layer-demo', //样式类名
                            closeBtn: 1, //不显示关闭按钮
                            area: ['700px', '400px'],
                            fixed: false, //不固定
                            maxmin: true,
                            shadeClose: true, //开启遮罩关闭
                            content: $('#addFalForm'),
                            success: function(layero, index){
                                $(data).each(function (index,elemnt){
                                    $("#stuFamilyid").val(elemnt.stuFamilyid);
                                    $("#stuFamilyName").val(elemnt.stuFamilyName);
                                    $("#relation").val(elemnt.relation);
                                    $("#familyPhone").val(elemnt.familyPhone);
                                });
                            }
                        });
                        break;
                    case 'editEdu':
                        openStuAc = layer.open({
                            type: 1,
                            title:'教育信息修改',
                            skin: 'layui-layer-demo', //样式类名
                            closeBtn: 1, //不显示关闭按钮
                            area: ['700px', '400px'],
                            fixed: false, //不固定
                            maxmin: true,
                            shadeClose: true, //开启遮罩关闭
                            content: $('#addEduForm'),
                            success: function(layero, index){
                                $(data).each(function (index,elemnt){
                                    $("#EduId").val(elemnt.EduId);
                                    $("#hisSchool").val(elemnt.hisSchool);
                                    $("#beginDH").val(createTime(elemnt.beginDate));
                                    $("#endDH").val(createTime(elemnt.endDate));
                                });
                            }
                        });
                        break;
                }
            });

        })

        var form = layui.form;
                //监听提交
        form.on('submit(formDemoFal)',function(data){
            $.ajax({
                url:'${pageContext.request.contextPath}/stu/toStuFal?studId='+studId,
                type:'post',
                data:data.field,
                dataType:'json',
                success:function (data){

                }
            });
            document.getElementById("addFalForm").reset();
            layer.close(openStuAc);
            table.reload('fal');
            return false;
        });

        form.on('submit(formDemoEdu)', function(data){
            $.ajax({
                url:'${pageContext.request.contextPath}/stu/toStuEdu?studId='+studId,
                type:'post',
                data:data.field,
                dataType:'json',
                success:function (data){
                }
            });
            document.getElementById("addEduForm").reset();
            layer.close(openStuAc);
            table.reload('edu');
            return false;
        });

        form.on('submit(formDemoHap)', function(data){
            $.ajax({
                url:'/stu/toStuHap/add?studId='+studId,
                type:'post',
                data:data.field,
                dataType:'json',
                success:function (data){
                }
            });
        });
        document.getElementById("addHapForm").reset();
        layer.close(openStuAc);
        table.reload('stuHap');
        return false;



    }
    layui.use(['element','tab'], function(){
        var element = layui.element;
        var tab = layui.tab;
        tab.render({
            elem: '#commodity',
            toolbar: '#toolbarDemo5'

        })
    });


</script>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container" style="float: left">
        <button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="isAdd">新增</button>
        <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
    </div>
    <!--4表的toolbar-->
    <div style="float: left;height: 20px;margin-top:-5px">
        <div class="layui-form-item" style="display: inline-block">
            <label class="layui-form-label" style="width:100px">学生姓名</label>
            <div class="layui-input-block">
                <input id="stuSelectName" type="text" name="stuSelectName" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item" style="display: inline-block">
            <label class="layui-form-label" style="width:100px">学生电话</label>
            <div class="layui-input-block">
                <input id="stuSelectPhone" type="text" name="stuSelectPhone" required  lay-verify="phone" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item" style="display: inline-block">
            <label class="layui-form-label" style="width:100px">所在班级</label>
            <div class="layui-input-block">
                <select name="stuSelectCla" lay-verify="required" placeholder=" " id="stuSelectCla">
                    <option></option>
                    <c:forEach items="${classList}" var="stuClass">
                        <option>${stuClass.className}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="layui-form-item" style="display: inline-block">
            <label class="layui-form-label" style="width:100px">所在寝室</label>
            <div class="layui-input-block">
                <select name="stuSelectFloor" lay-verify="required" placeholder=" " id="stuSelectFloor">
                    <option></option>
                    <c:forEach items="${hoursList}" var="hours">
                        <option>${hours.hourName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <button class="layui-btn layui-btn-sm" lay-event="isSelect">条件筛选</button>
    </div>

</script>

<script type="text/html" id="toolbarDemo2">
    <div class="layui-btn-container">
        <button class="layui-btn  layui-btn-warm" lay-event="addFal">添加</button>
        <button class="layui-btn  layui-btn-warm" lay-event="delFal">批量删除</button>
    </div>
</script>

<script type="text/html" id="toolbarDemo3">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="addEdu">添加</button>
        <button class="layui-btn layui-btn-sm" lay-event="delEdu">批量删除</button>
    </div>
</script>

<script type="text/html" id="toolbarDemo4">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="addHap">添加</button>
        <button class="layui-btn layui-btn-sm" lay-event="delHap">批量删除</button>
    </div>
</script>


<!--4表的尾部toolbar-->
<script type="text/html" id="barDemo">
    <button type="button" class="layui-btn layui-btn-sm" lay-event="edit">
        <i class="layui-icon">&#xe642;</i>
    </button>
</script>

<script type="text/html" id="barDemo2">
    <button type="button" class="layui-btn layui-btn-sm" lay-event="editFal">
        <i class="layui-icon">&#xe642;</i>
    </button>
</script>

<script type="text/html" id="barDemo3">
    <button type="button" class="layui-btn layui-btn-sm" lay-event="editEdu">
        <i class="layui-icon">&#xe642;</i>
    </button>
</script>

<script type="text/html" id="barDemo4">
    <button type="button" class="layui-btn layui-btn-sm" lay-event="editHap">
        <i class="layui-icon">&#xe642;</i>
    </button>
</script>
</body>
</html>
