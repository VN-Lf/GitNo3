<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/9
  Time: 9:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>公告列表</title>
    <%String yangshi = (String) session.getAttribute("color");%>
    <script src="${pageContext.request.contextPath}/jquery.js"></script>
    <style>
        body{
            font-size: 14px;
        }
        #list{
            width: 80%;
            height: auto;
            margin: 0 auto;
        }
        .kuai{
            height: 65px;
            width: 95%;
            margin: 10px 0;
            padding:10px 0 10px 15px;
        <%if("dark-hive".equals(yangshi)){%>
            background-color: #9F9F9F;
        <%}else {%>
            background-color: #f1f1f1;
        <%}%>
            border-radius: 8px;
            transition: 0.5s;
        }
        .biti{
            margin:0;
            font-size: 10px;
        }
        .qihuan{
            width: 50px;
            height: 140px;
            padding-top: 10px;
            float: right;
            border-radius: 8px;
            cursor:pointer;
            background-color: #f1f1f1;
        }
        .textcss{
            height: 90%;
            width: 100%;
            resize:none;
            outline: none;
            border: 0;
            background-color: transparent;
            overflow:hidden;
        }
    </style>
    <script language="JavaScript">
        function czNotice(type) {
            $.ajax({
                url:'${pageContext.request.contextPath}/emp/notlist?type='+type,
                type:'post',
                dataType:'json',
                success:function (data){
                    var json = data.data;
                    if(json == ''){
                        tishi('暂无数据');
                    }else {
                        $.each(json, function (index,item) {
                            var noticeId = item.noticeId;
                            var content = item.content;
                            var deptIds = item.deptIds;
                            var empName = item.empName;
                            var noticeTime = new Date(item.noticeTime).format("yyyy-MM-dd");
                            var noticeType = item.noticeType;
                            var title = item.title;
                            var tishi = "";
                            if(content.length > 100){
                                tishi = "<p text-align:center style='margin: 0 0 0 40%;color: #f1f1f1'>单击显示更多</p>\n";
                            }
                            deptIds = noticeType;
                            switch (noticeType){
                                case 1:noticeType="所有人";break;
                                case 2:noticeType="员工";break;
                                case 3:noticeType="学生";break;
                                case 4:noticeType="班级";break;
                                default:noticeType="---";
                            }

                            addMovk(noticeId,tishi,content,deptIds,empName,noticeTime,noticeType,title);
                        });
                        tishi('已加载完毕');
                    }
                },
                error:function () {
                    alert("后台数据错误，请稍后再试")
                }
            });
        }
        czNotice('desc');

        Date.prototype.format = function (fmt) { //author: meizz 
            var o = {
                "M+": this.getMonth() + 1, //月份 
                "d+": this.getDate(), //日 
            };
            if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
            for (var k in o)
                if (new RegExp("("+k+")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            return fmt;
        };
    </script>
</head>
<body style="position: relative;">
<div id="zhanshi" style="width: 90%;height: auto;position: absolute;left:0;top: 0;transition: 0.5s;">
    <button onclick="qinKon()">清空</button>
    <div style="width: 80%;height: auto;margin: 0 auto;">
        <div class="kuai" style="height: 30px;padding:10px 0 0 15px">
            <p style="float: left;width:10%;margin-top: 0">
                <select id="timexz" onchange="timeList();">
                    <option value="desc">距我最近</option>
                    <option value="asc">距我最远</option>
                </select>
            </p>
            <p style="float: left;width:15%;margin-top: 0">标题</p>
            <p style="float: left;width:60%;margin:0 2.5%">内容（单击可显示更多）</p>
            <p style="float: left;width:10%;margin:0">操作</p>
        </div>
    </div>
    <div id="list"></div>
</div>
<div id="tianjia" style="width: 10%;height: 500px;transition: 0.5s;position:absolute;left: 90%;top: 0;">
    <div id="dkai" style="width: 100%;height: 150px;padding-top: 30px;display: block">
        <div class="qihuan" onclick="tianJia(1)">
            <h1 align="center">添</h1>
            <h1 align="center">加</h1>
        </div>
    </div>
    <div id="nei" style="width: 75%;height: 500px;padding-top: 30px;margin-top:30px;display: none;background-color:#f1f1f1;float: left">
        <form action="${pageContext.request.contextPath}/emp/notadd" method="post">
            <input type="hidden" name="empName" value="<%=session.getAttribute("empId")%>">
            <div style="width: 50%;margin: 0 25%">
                <div style="width: 100%;height: 50px">
                    <div>
                        标题:
                        <input type="text" name="title"placeholder="请输入公告标题" autocomplete="off" style="width: 250px;height: 25px">
                    </div>
                </div>
                <div style="width: 100%;height: 50px">
                    <div style="width: 50%;height: 100%;float: left">
                        <span>谁能看到:</span>
                        <select name="noticeType" style="height: 25px;width: 90px;">
                            <option value="">请选择</option>
                            <option value="1">所有人</option>
                            <option value="2">员工</option>
                            <option value="3">学生</option>
                        </select>
                    </div>
                    <div style="width: 50%;height: 100%;float: left">
                        <span>发布时间:</span>
                        <input name="time" id="notTime" style="height: 25px;width: 90px" value=""/>
                    </div>
                </div>
                <div style="width: 100%;height: 350px">
                    <label>公告内容:</label>
                    <div id="neiro">
                        <textarea name="content" placeholder="请输入内容" style="height: 310px;width: 510px;resize:none"></textarea>
                    </div>
                </div>
                <div style="width: 100%;height: 50px">
                    <div style="width: 90px;height: 100%;margin: 0 auto">
                        <input type="submit" value="发布" style="height: 25px;width: 90px;"/>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div id="off" style="width: 15%;height: 150px;padding-top: 30px;display: none;float: left">
        <div class="qihuan" onclick="tianJia(0)">
            <h1 align="center">收</h1>
            <h1 align="center">回</h1>
        </div>
    </div>
</div>
<script>
    //重新加载
    function timeList() {
        var type = document.getElementById("timexz").value;
        var div = document.getElementById("list");
        while(div.hasChildNodes()){
            div.removeChild(div.firstChild);
        }
        czNotice(type);
    }
    //点击添加按钮
    function tianJia(ty) {
        if(ty == 1){
            $("#zhanshi").css("left","-70%");
            $("#tianjia").css("left","20%");
            $("#tianjia").css("width","80%");

            $("#dkai").css("display","none");
            $("#nei").css("display","block");
            $("#off").css("display","block");
            $("#neiro").css("display","block");
            getDangqian();
        }else if(ty == 0){
            $("#neiro").css("display","none");
            $("#tianjia").css("width","10%");
            $("#zhanshi").css("left","0");
            $("#tianjia").css("left","90%");

            setTimeout("guanbi()","300");
        }
    }
    //获取当前时间
    function getDangqian(){
        var date = new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var hour = date.getHours();
        var tiem = year+"-"+month+"-"+day;
        document.getElementById("notTime").value=tiem;
    }
    //将添加模块隐藏
    function guanbi() {
        $("#dkai").css("display","block");
        $("#nei").css("display","none");
        $("#off").css("display","none");
    }
    var jinzhi = 1;//移入列表区
    function baoyiru(id) {
        if(jinzhi == 1){
            <%if("dark-hive".equals(yangshi)){%>
            $(id).css("background-color","#f1f1f1");
            <%}else {%>
            $(id).css("background-color","#9F9F9F");
            <%}%>
            $(id).css("height","75px");
            $(id).css("margin","5px 0");
        }
    }//移除列表区
    function baoyichu(id) {
        if(jinzhi == 1){
            <%if("dark-hive".equals(yangshi)){%>
            $(id).css("background-color","#9F9F9F");
            <%}else {%>
            $(id).css("background-color","#f1f1f1");
            <%}%>
            $(id).css("height","65px");
            $(".wenben").css("height","65px");
            $(id).css("margin","10px 0");
        }
    }//展开一个公告
    function zanKai(id) {
        if(jinzhi == 1){
            var div = $(id).parent();
            div.css("height","300px");
            $(id).css("height","300px");
        }
    }//添加一个公告
    function addMovk(nid,tishi,con,dep,name,ntime,ntype,title) {
        var html = "<div class=\"kuai\" onmouseenter=\"baoyiru(this)\" onmouseleave=\"baoyichu(this)\">\n" +
            "            <div style=\"float: left;width: 10%;height: 100%\">\n" +
            "                <p style=\"margin: 0;color: #f1f1f1\">编号："+nid+"</p>\n" +
            "                <p style=\"margin: 0\">发布："+name+"</p>\n" +
            "                <p style=\"margin: 0\">类型："+ntype+"</p>\n" +
            "            </div>\n" +
            "            <div style=\"float: left;width: 15%;height: 100%\">\n" +
            "                <p class=\"biti\" id='ti"+nid+"'>"+title+"</p>\n" +
            "                <input type='text' id='ti"+nid+"b' value='"+title+"' style='display: none'/>"+
            "                <p class='biti' style='color: #f1f1f1'>"+ntime+"</p>\n" +
            "            </div>\n" +
            "            <div class=\"wenben\" onclick='zanKai(this)' style=\"float: left;width: 60%;height: 100%;margin: 0 2.5%;transition: 0.5s;\">\n" +
            "                 <textarea id='text"+nid+"' readonly class='textcss'>"+con+"</textarea>\n"+tishi+
            "            </div>\n" +
            "            <div style=\"float: left;width: 10%;height: 100%;\">\n" +
            "                <p style=\"margin:15px 5px 5px 5px;\">" +
            "                       <input type=\"button\" id='bj"+nid+"' style='width: 80px;display: block' onclick='xiuGaiShu("+nid+",1)' value=\"编辑\"/>" +
            "                       <input type=\"button\" id='qx"+nid+"' style='width: 80px;display: none' onclick='xiuGaiShu("+nid+",0)' value=\"取消\"/>" +
            "                </p>\n" +
            "                <p style=\"margin: 5px\">" +
            "                       <input type=\"button\" style='width: 80px;display: block' id='sc"+nid+"' onclick='delShuju("+nid+")' value=\"删除\"/>" +
            "                       <input type=\"button\" style='width: 80px;display: none' id='tj"+nid+"' onclick='xiuGaiShu("+nid+",2)' value=\"确认\"/>" +
            "                </p>\n" +
            "            </div>\n" +
            "        </div>";
        $("#list").append(html);
    }

    function qinKon() {//清空列表
        var div = document.getElementById("list");
        while(div.hasChildNodes()){
            div.removeChild(div.firstChild);
        }
        tishi('暂无数据');
    }

    function tishi(type) {//提示信息生成
        var html = "<div class=\"kuai\" style=\"height: 50px;padding:0;width:96.3%\">\n" +
            "           <h2 align=\"center\" style=\"padding-top: 10px\">"+type+"</h2>\n" +
            "       </div>";
        $("#list").append(html);
    }

    function delShuju(id) {
        if (confirm("确定删除吗？")) {
            $.post('${pageContext.request.contextPath}/emp/notdel?id='+id,{
            },function(data){
                alert(data);
                location.reload();
            });
        }
    }

    var textnei = "";
    var dianId = "";//修改信息
    function xiuGaiShu(id,typ) {
        var text = document.getElementById("text"+id);
        if(typ == 1){//点击修改 禁用移入移出和其它修改按钮
            if(dianId == "" || dianId == id){
                dianId = id;
                zanKai($("#text"+id).parent());
                jinzhi = 0;
                document.getElementById("bj"+id).style.display="none";
                document.getElementById("sc"+id).style.display="none";
                document.getElementById("tj"+id).style.display="block";
                document.getElementById("qx"+id).style.display="block";
                document.getElementById("ti"+id).style.display="none";
                document.getElementById("ti"+id+"b").style.display="block";
                textnei = text.value;
                text.style.backgroundColor="white";
                text.readOnly =false;
            }
        }else if(typ == 0) {//点击取消 同时把值返回
            jinzhi = 1;
            dianId = "";
            document.getElementById("bj"+id).style.display="block";
            document.getElementById("sc"+id).style.display="block";
            document.getElementById("tj"+id).style.display="none";
            document.getElementById("qx"+id).style.display="none";
            document.getElementById("ti"+id).style.display="block";
            document.getElementById("ti"+id+"b").style.display="none";
            text.value = textnei;
            text.style.backgroundColor="transparent";
            text.readOnly =true;
        }else if(typ == 2){//提交修改
            var ti = document.getElementById("ti"+id+"b").value;
            var con = document.getElementById("text"+id).value;
            if(ti == "" || con == ""){
                alert("标题和内容不能有空值")
            }else {
                $.post('${pageContext.request.contextPath}/emp/notupdate?id='+id,{
                    ti: ti,
                    con:con
                },function(data){
                    alert(data);
                    location.reload();
                });
            }
        }
    }
</script>
</body>
</html>
