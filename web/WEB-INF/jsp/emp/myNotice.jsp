<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/19
  Time: 20:19
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
        .biti .biti2{
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
                            var empId= item.emps;
                            var noticeId = item.noticeId;
                            var content = item.content;
                            var deptIds = item.deptIds;
                            var empName = item.empName;
                            var noticeTime = new Date(item.noticeTime).format("yyyy-MM-dd");
                            var noticeType = item.noticeType;
                            var title = item.title;
                            var tishi = "";
                            if(content.length > 100){
                                tishi = "<p text-align:center style='margin: 0 0 0 28%;color: #f1f1f1'>单击显示更多</p>\n";
                            }
                            deptIds = noticeType;
                            switch (noticeType){
                                case 1:noticeType="所有人";break;
                                case 2:noticeType="员工";break;
                                case 3:noticeType="学生";break;
                                case 4:noticeType="班级";break;
                                default:noticeType="---";
                            }

                            addMovk(noticeId,tishi,content,deptIds,empName,noticeTime,noticeType,title,empId);
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
        </div>
    </div>
    <div id="list"></div>
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
            jinzhi = 0;
            var div = $(id).parent();
            div.css("height","300px");
            $(id).css("height","300px");
            var nnnnid = $(id).parent().children('div').find(".id").html().slice(3);
            document.getElementById(nnnnid).innerHTML="已读";
            $(id).children().siblings(".tishi2").css("color","#9f9f9f");
            $.post('${pageContext.request.contextPath}/emp/martNotice',{eid:${empId.empId},nid:nnnnid},function (data) {},"json");
        }else {
            $(id).children().siblings(".tishi2").css("color","#f1f1f1");
            jinzhi = 1;
        }
    }//添加一个公告
    function addMovk(nid,tishi,con,dep,name,ntime,ntype,title,emps) {
        var emp = new Array();
        if (emps){
            emp = emps.split(",");
        }
        var a = "<p id='"+nid+"' class=\"biti\">未读</p>";
        var empId = ${empId.empId};
        for(var i=0;i<emp.length;i++){
            if(empId==emp[i]){
                a="<p id='"+nid+"' class=\"biti2\">已读</p>";
            }
        }
        var html = "<div class=\"kuai\" onmouseenter=\"baoyiru(this)\" onmouseleave=\"baoyichu(this)\">\n" +
            "            <div style=\"float: left;width: 10%;height: 100%\">\n" +
            "                <p class='id' style=\"margin: 0;color: #f1f1f1\">编号："+nid+"</p>\n" +
            "                <p style=\"margin: 0\">发布："+name+"</p>\n" +
            "                <p class='biti' style='color: #f1f1f1'>"+ntime+"</p>\n" +
            "            </div>\n" +
            "            <div style=\"float: left;width: 15%;height: 100%\">\n" +
            "                <p class=\"biti\" id='ti"+nid+"'>"+title+"</p>\n" +
            "                <input type='text' id='ti"+nid+"b' value='"+title+"' style='display: none'/>"+
            "            </div>\n" +
            "            <div class=\"wenben\" onclick='zanKai(this)' style=\"float: left;width: 60%;height: 100%;margin: 0 2.5%;transition: 0.5s;\">\n" +
            "                 <textarea id='text"+nid+"' readonly class='textcss'>"+con+"</textarea>\n"+tishi+
            "            </div>\n" +
            "            <div style=\"float: left;width: 10%;height: 100%;\">\n" +a+
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
</script>
</body>
</html>
