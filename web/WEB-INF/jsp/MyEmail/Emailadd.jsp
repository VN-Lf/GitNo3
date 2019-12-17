<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/14
  Time: 9:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加Email</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <%
        HttpSession sess = request.getSession();
        String message = (String)sess.getAttribute("Repeat");
        if(message == "" ){
        }else{
    %>
    <script type="text/javascript">
        var a = "<%=message%>"
        if(a !="null" ){
            alert(a);
        }
    </script>
    <%
            sess.setAttribute("Repeat", "");
        }
    %>
    <style type="text/css">
        .layui-table-tool {
            z-index: 0;
        }
    </style>
    <jsp:include page="../../../index.jsp"></jsp:include>
</head>
<body>
<div class="easyui-layout" data-options="fit:true" >
    <div data-options="region:'center',title:'信息管理'" style="background:#eee;" >
        <form action="<%=request.getContextPath()%>/email/sendEmail"  enctype="multipart/form-data" id="addDor" method="post" style="width: 1205px;margin: 20px 0px 0px 10px">

            <div style="width: 400px; left:250px; top:15px;height: 100px;position: relative">
                <div>
                    标题 : <input type="text" name="topic"  required lay-verify="required" placeholder="请输人标题"  class="layui-input" style="width:180px;display:inline-block" />
                </div>
                <div>
                    接收人：
                    <input type="text" name="receId" id="receId" autocomplete="off" required lay-verify="required"   class="layui-input" style="width:180px;display:inline-block" />

                    <br>
                    部门：<select id="deptId" style="width: 80px;height: 35px">
                            <c:forEach items="${Edeptlist}" var="li">
                                <option value=${li.get("deptId")}>${li.get("deptName")}</option>
                            </c:forEach>
                        </select>
                        <div id="test2" class="demo-transfer"></div>
                    员工：<select id="empnames" style="width: 80px;height: 35px"></select>
                        <%--<input id="cc" value="001">--%>


                        <a id="adddept" name="adddept">添加</a>
                        <a id="deldept" name="deldept" style="left: 225px">重置</a>
                </div>
                    <br>
                <div>
                    附件：<input type="file" name="face" id="file" >
                </div>
                    <br>
                <div>
                    <h3> 邮件内容</h3>
                    <textarea name="content" id="content" style=" left: 400px;width: 500px; height: 200px"></textarea>
                </div>
                <div>
                    <button type="button" class="layui-btn layui-btn-primary" onclick="add();">发送</button>
                    <button type="button" class="layui-btn layui-btn-primary" onclick="close1()">退出</button>
                </div>
            </div>


        </form>
        <%--信息显示表--%>
        <table id="demo" lay-filter="test"  ></table>
        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        </script>
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container" style="left: 300px">
                <button class="layui-btn layui-btn-sm" lay-event="isDele">批量删除</button>
            </div>
        </script>

    </div>
</div>

<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
    //解决jquery包冲突
    jQuery.noConflict();

    function close1 () {
        window.location.href="<%=request.getContextPath()%>/email/toemail";
    }
    function add() {
        $("#addDor").form("submit",{
            success : function () {
                $("#addDor").form("clear");
                window.location.href="<%=request.getContextPath()%>/email/toemail";
            }
        })
    }
    $(function () {
       /* $('#cc').combo({
            required:true,
            multiple:true
        });*/
        var data2;
        $("#deptId").change(function () {
            $("#empnames").empty();
            /* var myselect = document.getElementById("#deptId");
             alert(myselect)*/
            var options = $("#deptId option:selected");　　　　//获取选中项
            var deptId = options.val();　　　　　　　　　　　　　　//获取选中项的值
            /*alert(deptname)　　　　*/　　　　　　　　　　　　　　                  //检验是否获取到值
            $.ajax({
                url : "<%=request.getContextPath()%>/email/selsendEmail",
                type: "post",
                data :{
                    deptname :deptId
                },
                dataType : "json",
                success : function (data) {
                    var List = data.data;

                    $.each(List,function(index,obj){
                        /*alert(this.empName);*/
                        var html = "<option value=\"" +this.empName + "\"> " + this.empName + "</option>";
                        //给省下拉框加上拼接的option
                        sesslist =this.empName;
                        /*data2= {"value": this.empName, "title": this.empName}*/
                        $("#empnames").append(html);
                    });
                }
            })
        })

        layui.use(['transfer', 'layer', 'util'], function(){
            var $ = layui.$
                ,transfer = layui.transfer
                ,layer = layui.layer
                ,util = layui.util;


            //模拟数据
            var data1 = [
                {"value": "1", "title": "李白"}
                ,{"value": "2", "title": "杜甫"}
                ,{"value": "3", "title": "苏轼"}
                ,{"value": "4", "title": "李清照"}
                ,{"value": "5", "title": "鲁迅", "disabled": true}
                ,{"value": "6", "title": "巴金"}
                ,{"value": "7", "title": "冰心"}
                ,{"value": "8", "title": "矛盾"}
                ,{"value": "9", "title": "贤心"}
            ]
            /*var List;
            $.ajax({
                url : "<%=request.getContextPath()%>/email/selsendEmail",
                type: "post",
                data :{
                    deptname :deptId
                },
                dataType : "json",
                success : function (data) {
                   List  = data.data;

                }
            })*/
            //定义标题及数据源
            transfer.render({
                elem: '#test2'
                ,title: ['筛选', '接收人']  //自定义标题
                ,data: List
                ,width: 150 //定义宽度
                ,height: 410 //定义高度
            })


            //数据格式解析
            transfer.render({
                elem: '#test5'
                ,parseData: function(res){
                    return {
                        "value": res.id //数据值
                        ,"title": res.name //数据标题
                        ,"disabled": res.disabled  //是否禁用
                        ,"checked": res.checked //是否选中
                    }
                }
                ,data: [
                    {"id": "1", "name": "李白"}
                    ,{"id": "2", "name": "杜甫"}
                    ,{"id": "3", "name": "贤心"}
                ]
                ,height: 150
            })
        });

    })



</script>
<script>
    var seleVal='';
    $("#adddept").on("click",function(){

         var  s = $("#empnames>option:selected").val()+',';
         if(s == seleVal){
             alert("不能添加相同的用户");
             return;
         }
        seleVal+=s;
        $("#receId").val(seleVal);
    })
    $("#deldept").on("click",function(){
        seleVal = '';
        $("#receId").val(" ");
    })
</script>
</body>
</html>
