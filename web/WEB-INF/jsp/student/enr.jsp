<%--
  Created by IntelliJ IDEA.
  User: DDD
  Date: 2019/12/24
  Time: 9:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
    <meta charset="utf-8">
    <title>招生模块/</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/layui/laydate/laydate.js"></script> <!-- 改成你的路径 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/laydate/theme/default/laydate.css">
    <script src="${pageContext.request.contextPath}/jquery.js"></script>
</head>
<body>
<table id="demo" lay-filter="test">

</table>

<form  class="layui-form" id="enrollForm" style="display:none;height: 750px;top:30px;width: 600px" method="post">
    <input id="enrollmentid" type="hidden" name="enrollmentid">

        <div class="layui-form-item" style="margin-top: 35px">
            <label class="layui-form-label">姓名</label>
            <div class="layui-input-block">
                <input id="stuName" type="text" name="stuName" required  lay-verify="required" placeholder=" " autocomplete="off" class="layui-input">
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
            <label class="layui-form-label">身份证</label>
            <div class="layui-input-block">
                <input id="cardId" type="text" name="cardId" required  lay-verify="identity" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">联系方式</label>
            <div class="layui-input-block">
                <input id="stuPhone" type="text" name="stuPhone" required  lay-verify="phone" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">QQ</label>
            <div class="layui-input-block">
                <input id="stuQQ" type="text" name="stuQQ" required  lay-verify="number" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">毕业院校</label>
            <div class="layui-input-block">
                <input id="school" type="text" name="school"   placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">招生人</label>
            <div class="layui-input-block">
                <input id="enterEmp" type="text" name="enterEmp"    placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">班级类型</label>
            <div class="layui-input-block">
                <select name="classType" placeholder=" ">
                    <option value="0"> </option>
                    <c:forEach items="${classTypeList}" var="claType">
                        <option value="${claType.classType}">${claType.classTypeName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

    <div class="layui-form-item">
        <label class="layui-form-label">专业</label>
        <div class="layui-input-block">
            <select name="majorId" placeholder=" ">
                <option value="0"> </option>
                <c:forEach items="${majorList}" var="ma">
                    <option value="${ma.majorId}">${ma.majorName}</option>
                </c:forEach>
            </select>
        </div>
    </div>

        <div class="layui-form-item">
            <label class="layui-form-label">班级</label>
            <div class="layui-input-block">
                <select name="classId" placeholder="" >
                    <option value="0"> </option>
                    <c:forEach items="${classList}" var="stuClass">
                        <option value="${stuClass.classId}">${stuClass.className}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">状态</label>
            <div class="layui-input-block">
                <select name="status" placeholder="">
                    <option value="1">意向学生</option>
                    <option value="2">预定报名学生</option>
                    <option value="3">试学学生</option>
                    <option value="4">在读学生</option>
                    <option value="5">已毕业学生</option>
                </select>
            </div>
        </div>


    <div class="layui-form-item">
        <label class="layui-form-label">预定报名费</label>
        <div class="layui-input-block">
            <input id="amount" type="text" name="amount" required  placeholder="" autocomplete="off" class="layui-input">
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label">电脑</label>
        <div class="layui-input-block">
            <input type="radio" name="computer" value="是" title="是" checked>
            <input type="radio" name="computer" value="否" title="否" >
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label">缴预定报名费时间</label>
        <div class="layui-input-block">
            <input id="paymentDH" type="text" name="paymentDH"  placeholder="" autocomplete="off" class="layui-input">
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label">试学时间</label>
        <div class="layui-input-block">
            <input id="testDH" type="text" name="testDH"  placeholder="" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">入学时间</label>
        <div class="layui-input-block">
            <input id="startDH" type="text" name="startDH"  placeholder="" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">入学成绩</label>
        <div class="layui-input-block">
            <input id="score" type="text" name="score"  placeholder="" autocomplete="off" class="layui-input">
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label">说明</label>
        <div class="layui-input-block">
            <input id="remark" type="text" name="remark" name="remark"  placeholder="" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo">确定</button>
        </div>
    </div>

</form>

<form  class="layui-form" id="proMoneyForm" style="display:none;height: 170px;width: 280px" method="post">
    <input type="hidden" name="enId" id="enId">
    <div class="layui-form-item" style="margin-left: 5px; margin-top: 40px">
        <label class="layui-form-label">预约时间</label>
        <div class="layui-input-block">
            <input id="pmDH" type="text"  name="pmDH"  placeholder="" autocomplete="off" class="layui-input" style="width: 200px">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block" style="margin-top: 30px;margin-left: 20%">
            <button class="layui-btn" lay-submit lay-filter="formDemoPm">确定</button>
        </div>
    </div>
</form>

<form  class="layui-form" id="audMoneyForm" style="display:none;height: 170px;width: 280px" method="post">
    <input type="hidden" name="eId" id="eId">

    <div class="layui-form-item" style="margin-left: 5px; margin-top: 40px">
        <label class="layui-form-label">审核人</label>
        <div class="layui-input-block">
            <input id="reviewer" type="text" name="reviewer"  placeholder="" autocomplete="off" class="layui-input" style="width: 200px">
        </div>
    </div>

    <div class="layui-form-item" style="margin-top: 30px;margin-left: 20%">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemoAM">确定</button>
        </div>
    </div>
</form>

<form  class="layui-form" id="addMoneyForm" style="display:none;height: 170px;width: 280px" method="post">
    <input type="hidden" name="eeeId" id="eeeId">

    <div class="layui-form-item" style="margin-left: 5px; margin-top: 40px">
        <label class="layui-form-label">发放金额</label>
        <div class="layui-input-block">
            <input id="enrollMoney" type="text" name="enrollMoney"  placeholder="" autocomplete="off" class="layui-input" style="width: 200px">
        </div>
    </div>

    <div class="layui-form-item" style="margin-top: 30px;margin-left: 20%">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemoM">确定</button>
        </div>
    </div>
</form>


<script src="${pageContext.request.contextPath}/layui/layui.js">

</script>
<script>
    function allStatus(v){
        if(v==1){
            return "意向学生"
        }else if(v==2){
            return "预定报名学生"
        }else if(v==3) {
            return "试学学生";
        }else if(v==4){
            return"在读学生"
        }else if(v==5){
            return"已毕业学生"
        }
        return"";
    }

    function isEx(v) {
        if(v==''||v==null){
            return"未审核";
        }else{
            return"已审核"
        }
        return"";
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

    layui.use(['table','laydate','tree','form'], function(){
        var table = layui.table;
        var tId = layui.table.id;
        var openStuAc;
        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 400
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,url: '${pageContext.request.contextPath}/enrStu/main/toList' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'enrollmentid', title: 'ID', width:100}
                ,{field: 'stuName', title: '名字', width:100}
                ,{field: 'stuSex', title: '性别', width:80}
                ,{field: 'stuQQ', title: 'QQ', width:200}
                ,{field: 'testTime', title: '试学时间', width: 180, templet:function (row){
                    if(row.testTime==undefined){
                        return"";
                    }
                        return createTime(row.testTime);
                    }
                }
                ,{field: 'startTime', title: '入学时间', width: 180, templet:function (row){
                    if(row.startTime==undefined){
                        return"";
                    }
                        return createTime(row.testTime);
                    }
                }
                ,{field: 'signdate', title: '录入时间', width: 180, templet:function (row){
                    if(row.signdate==undefined){
                        return"";
                    }
                        return createTime(row.signdate);
                    }
                }
                ,{field: 'stuPhone', title:'电话', width:270}
                ,{field: 'school', title: '毕业院校', width:120}
                ,{field: 'className', title: '班级', width: 180}
                ,{field: 'amount', title: '预定报名费金额', width:200}
                ,{field: 'entryTime', title: '报名费审核', width:200,
                    templet:function (row){
                        return isEx(row.entryTime);
                    }
                }
                ,{field: 'entryTime', title: '报名费审核时间', width:200}
                ,{field: 'reviewer', title: '报名费审核人', width:200}
                ,{field: 'computer', title: '是否电脑', width:100}
                ,{field: 'cardId', title: '身份证', width: 177}
                ,{field: 'empName', title:'录入教师', width:100}
                ,{field: 'status', title: '学生状态', width:100,
                    templet:function (row){
                        return allStatus(row.status);
                    }
                }
                ,{field: 'remark', title: '备注', width:80}
                ,{field: 'enterEmp', title: '招生老师', width: 177}
                ,{field: 'classTypeName', title: '班级类别', width:80,}
                ,{field: 'MajorName', title: '专业类别', width:80}
                ,{field: 'score', title: '入学成绩', width: 177}
                ,{field: 'paymentTime', title: '缴预定报名费时间', width:80,}
                ,{field: 'enrollMoney', title: '发放金额', width:80}
                ,{field: 'enrollMoneyTime', title: '发放时间', width: 177,
                    templet:function (row){
                    if(row.enrollMoneyTime==undefined){
                        return"";
                    }
                        return createTime(row.enrollMoneyTime);
                    }
                }
                ,{field: 'reviewStatus', title:'报名费审核通过', width:80}
                ,{width:300, title: '操作',align:'center',fixed: 'right', toolbar: '#barDemo'}
            ]]
        });

        table.on('tool(test)', function(obj){
            var data = obj.data;
            var checkStatus = table.checkStatus('demo');
            var eeeid = data.enrollmentid;
            switch (obj.event){
                case 'money':
                    $.ajax({
                        url:'${pageContext.request.contextPath}/enrStu/toSelect/toMoney',
                        type:'post',
                        data:{
                            id:eeeid
                        },
                        dataType:'text',
                        success:function (data){
                            if(data=='no'){
                                alert("已有预约时间");
                            }else {
                                openStuAc = layer.open({
                                    type: 1,
                                    title:"增加预约时间",
                                    area:['400px','300px'],
                                    content: $("#proMoneyForm"),
                                    closeBtn :1,
                                    success: function(layero, index){
                                        document.getElementById("proMoneyForm").reset();
                                        $("#enId").val(eeeid);
                                    }
                                });
                            }
                        }
                    });
                    break;
                case'audMoney':
                    var  reviewer = data.reviewer
                    if(reviewer!=undefined){
                        alert("已经审核")
                        layer.close(openStuAc);
                    }else if(reviewer==undefined){
                        openStuAc = layer.open({
                            type: 1,
                            title:"审核人",
                            area:['400px','300px'],
                            content: $("#audMoneyForm"),
                            closeBtn :1,
                            success: function(layero, index){
                                document.getElementById("audMoneyForm").reset();
                                $("#eId").val(eeeid);
                            }
                        });
                    }
                    break;
                case'addMoney':
                    var  enrollMoney = data.enrollMoney
                     if(enrollMoney==0){
                        openStuAc = layer.open({
                            type: 1,
                            title:"发放奖金",
                            area:['400px','300px'],
                            content: $("#addMoneyForm"),
                            closeBtn :1,
                            success: function(layero, index){
                                document.getElementById("addMoneyForm").reset();
                                $("#eeeId").val(eeeid);
                            }
                        });
                    }else {
                        alert("已经发放")
                     }
                    break;
                case 'edit':
                    openStuAc = layer.open({
                        type: 1,
                        title: '招生信息修改',
                        skin: 'layui-layer-demo', //样式类名
                        closeBtn: 1, //不显示关闭按钮
                        area: ['700px','700px'],
                        fixed: false, //不固定
                        maxmin: true,
                        shadeClose: true, //开启遮罩关闭
                        content: $('#enrollForm'),
                        success: function (layero, index){
                            $(data).each(function (index, elemnt){
                                $("#enrollmentid").val(elemnt.enrollmentid);
                                $("#cardId").val(elemnt.cardId);
                                $("#stuName").val(elemnt.stuName);
                                $("#stuSex").val(elemnt.stuSex);
                                $("#stuQQ").val(elemnt.stuQQ);
                                $("#testDH").val(createTime(elemnt.testTime));
                                $("#startDH").val(createTime(elemnt.startTime));
                                $("#stuPhone").val(elemnt.stuPhone);
                                $("#school").val(elemnt.school);
                                $("#enterEmp").val(elemnt.enterEmp);
                                $("#classType").val(elemnt.classType);
                                $("#majorId").val(elemnt.majorId);
                                $("#classId").val(elemnt.classId);
                                $("#status").val(elemnt.status);
                                $("#amount").val(elemnt.amount);
                                $("#computer").val(elemnt.computer);
                                $("#paymentDH").val(createTime(elemnt.paymentTime));
                                $("#score").val(elemnt.score);
                            });
                        }
                    });
                    break;
            }
        })

        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'add':
                    openStuAc = layer.open({
                        type: 1,
                        title:"新增招生信息",
                        area:['700px','700px'],
                        content: $("#enrollForm"),
                        closeBtn :1,
                        success: function(layero, index){
                            document.getElementById("enrollForm").reset();
                            $("#enrollmentid").val(0);
                        }
                    });
                    break;
                case 'isSelect':
                    var stuSelectName = $('input[name="stuSelectName"]').val();
                    var selectClassType = $('#selectClassType').val();
                    var stuSelectTeacher = $('input[name="stuSelectTeacher"]').val();
                    var stuSelecStuat  = $('#stuSelecStuat').val();
                    table.reload('demo',{
                        page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        , url: '${pageContext.request.contextPath}/enrStu/con'
                        , method:'POST'
                        ,where:{
                            stuSelectName:    stuSelectName,
                            selectClassType:  selectClassType,
                            stuSelectTeacher: stuSelectTeacher,
                            stuSelecStuat:     stuSelecStuat
                        }
                    });
                    break;
            };
        });

        var form = layui.form;
        form.on('submit(formDemo)', function(data){
            $.ajax({
                url:'${pageContext.request.contextPath}/enrStu/up',
                type:'post',
                data:data.field,
                dataType:'text',
                success:function (data){
                    layer.close(openStuAc);
                    table.reload('demo');
                }
            });
        })

            form.on('submit(formDemoPm)', function(data){
                $.ajax({
                    url:'${pageContext.request.contextPath}/enrStu/addPromTime',
                    type:'post',
                    data:data.field,
                    dataType:'text',
                    success:function (data){
                        layer.close(openStuAc);
                        table.reload('demo');
                    }
                });

             })

        form.on('submit(formDemoAM)', function(data){
            $.ajax({
                url:'${pageContext.request.contextPath}/enrStu/audit',
                type:'post',
                data:data.field,
                dataType:'json',
                success:function (data){
                    layer.close(openStuAc);
                    table.reload('demo');
                }
            })
        })


        form.on('submit(formDemoM)', function(data){
            $.ajax({
                url:'${pageContext.request.contextPath}/enrStu/addMoney',
                type:'post',
                data:data.field,
                dataType:'json',
                success:function (data){
                    layer.close(openStuAc);
                    table.reload('demo');
                }
            })
        })
        laydate.render({
            elem: '#paymentDH'
            ,trigger: 'click'//指定元素
        });

        laydate.render({
            elem: '#testDH'
            ,trigger: 'click'//指定元素o
        });

        laydate.render({
            elem: '#startDH'
            ,trigger: 'click'//指定元素o
        });

        laydate.render({
            elem: '#pmDH'
            ,trigger: 'click'//指定元素o
        });

})
</script>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container" style="float: left">
        <button class="layui-btn  layui-btn-xs" lay-event="add">添加</button>
    </div>

    <div style="float: left;height:28px;width: 1300px;margin-top:-5px">
        <div class="layui-form-item" style="display: inline-block">
            <label class="layui-form-label" style="width:100px">学生姓名</label>
            <div class="layui-input-block">
                <input id="stuSelectName" type="text" name="stuSelectName"   placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item" style="display: inline-block">
            <label class="layui-form-label" style="width:100px">班级类型</label>
            <div class="layui-input-block">
                <select name="selectClassType" placeholder=" ">
                    <option value="0"> </option>
                    <c:forEach items="${classTypeList}" var="claType">
                        <option>${claType.classTypeName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="layui-form-item" style="display: inline-block">
            <label class="layui-form-label" style="width:100px">招生教师</label>
            <div class="layui-input-block">
                <input id="stuSelectTeacher" type="text" name="stuSelectTeacher"  placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item" style="display: inline-block">
            <label class="layui-form-label" style="width:100px">状态</label>
            <div class="layui-input-block">
                <select name="stuSelecStuat"  placeholder=" " id="stuSelecStuat">
                    <option> </option>
                    <option value="1">意向学生</option>
                    <option value="2">预定报名学生</option>
                    <option value="3">试学学生</option>
                    <option value="4">在读学生</option>
                    <option value="5">已毕业学生</option>
                </select>
            </div>
        </div>



        <button class="layui-btn layui-btn-sm" lay-event="isSelect">条件筛选</button>
    </div>

</script>

<script type="text/html" id="barDemo">
    <button type="button" class="layui-btn layui-btn-xs" lay-event="edit">
        <i class="layui-icon">&#xe642;</i>
    </button>
    <button type="button" class="layui-btn layui-btn-xs" lay-event="money">
        <i class="layui-icon">预约缴费</i>
    </button>
    <button type="button" class="layui-btn layui-btn-xs" lay-event="audMoney">
        <i class="layui-icon">审核缴费</i>
    </button>
    <button type="button" class="layui-btn layui-btn-xs" lay-event="addMoney">
        <i class="layui-icon">提成金额</i>
    </button>
</script>
</body>
</html>
