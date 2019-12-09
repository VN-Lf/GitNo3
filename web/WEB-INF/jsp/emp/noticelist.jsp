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
    <script src="http://localhost:8888/jquery.js"></script>
    <style>
        body{
            font-size: 14px;
        }
        #list{
            width: 80%;height: auto;margin: 0 auto;
        }
        .kuai{
            height: 65px;
            width: 95%;
            margin: 10px 0;
            padding:10px 0 10px 15px;
            background-color: #f1f1f1;
            border-radius: 8px;
            transition: 0.5s;
        }
        .biti{
            margin:0;font-size: 10px;
        }
    </style>
    <script language="JavaScript">
        function czNotice() {
            $.ajax({
                url:'${pageContext.request.contextPath}/emp/notlist',
                type:'post',
                dataType:'json',
                success:function (data){
                    var json = data.data;
                    if(json == ''){
                        nullShuJu();
                    }else {
                        $.each(json, function (index,item) {
                            var noticeId = item.noticeId;
                            var classIds = item.classIds;
                            var content = item.content;
                            var deptIds = item.deptIds;
                            var empName = item.empName;
                            var noticeTime = new Date(item.noticeTime).format("yyyy-MM-dd");
                            var noticeType = item.noticeType;
                            var title = item.title;

                            switch (noticeType){
                                case 1:noticeType="所有人";break;
                                case 2:noticeType="员工";break;
                                case 3:noticeType="学生";break;
                                case 4:noticeType="班级";break;
                                default:noticeType="---";
                            }

                            addMovk(noticeId,classIds,content,deptIds,empName,noticeTime,noticeType,title);
                        })
                        tishi('已加载完毕');
                    }
                },
                error:function () {
                    alert("后台数据错误，请稍后再试")
                }
            });
        }
        czNotice();

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
<body>
    <button onclick="qinKon()">清空</button>
    <div style="width: 80%;height: auto;margin: 0 auto;">
        <div class="kuai" style="height: 30px;padding:10px 0 0 15px">
            <p style="float: left;width:10%;margin:0"><a href="">添加</a></p>
            <p style="float: left;width:15%;margin:0">标题</p>
            <p style="float: left;width:60%;margin:0 2.5%">内容</p>
            <p style="float: left;width:10%;margin:0">操作</p>
        </div>
    </div>
    <div id="list"></div>
<script>
    function baoyiru(id) {
        $(id).css("background-color","#9F9F9F");
        $(id).css("height","75px");
        $(id).css("margin","5px 0");
    }
    function baoyichu(id) {
        $(id).css("background-color","#f1f1f1");
        $(id).css("height","65px");
        $(".wenben").css("height","65px");
        $(id).css("margin","10px 0");
    }
    function zanKai(id) {
        var div = $(id).parent().parent();
        div.css("height","300px");
        $(id).parent().css("height","300px");
    }
    function addMovk(nid,cid,con,dep,name,ntime,ntype,title) {
        var html = "<div class=\"kuai\" onmouseenter=\"baoyiru(this)\" onmouseleave=\"baoyichu(this)\">\n" +
            "            <div style=\"float: left;width: 10%;height: 100%\">\n" +
            "                <p style=\"margin: 0;color: #f1f1f1\">编号："+nid+"</p>\n" +
            "                <p style=\"margin: 0\">发布："+name+"</p>\n" +
            "                <p style=\"margin: 0\">类型："+ntype+"</p>\n" +
            "            </div>\n" +
            "            <div style=\"float: left;width: 15%;height: 100%\">\n" +
            "                <p class=\"biti\">"+title+"</p>\n" +
            "                <input type=\"text\" value='"+ntime+"' style=\"background-color: transparent;border: 0;color: #f1f1f1\">\n" +
            "            </div>\n" +
            "            <div class=\"wenben\" style=\"float: left;width: 60%;height: 100%;margin: 0 2.5%;transition: 0.5s;\">\n" +
            "                <div style=\"float: left;width: 100%;height: 90%;font-size: 14px\" onclick=\"zanKai(this)\">\n" +
            "                    <input type=\"text\" value='"+con+"' style=\"background-color: transparent;border: 0\">\n" +
            "                </div>\n" +
            "            </div>\n" +
            "            <div style=\"float: left;width: 10%;height: 100%;\">\n" +
            "                <p style=\"margin:15px 5px 5px 5px;\">" +
            "<input type=\"button\" style=\"width: 80px\" onclick='xiuGaiShu("+nid+")' value=\"编辑\"/></p>\n" +
            "                <p style=\"margin: 5px\">" +
            "<input type=\"button\" style=\"width: 80px\" onclick='delShuju("+nid+")' value=\"删除\"/></p>\n" +
            "            </div>\n" +
            "        </div>";
        $("#list").append(html);
    }

    function qinKon() {
        var div = document.getElementById("list");
        while(div.hasChildNodes()){
            div.removeChild(div.firstChild);
        }
        tishi('暂无数据');
    }
    function tishi(type) {
        var html = "<div class=\"kuai\" style=\"height: 50px;padding:0;width:96.3%\">\n" +
            "           <h2 align=\"center\" style=\"padding-top: 10px\">"+type+"</h2>\n" +
            "       </div>"
        $("#list").append(html);
    }
    function delShuju(id) {
        alert("删除id"+id);
    }
    function xiuGaiShu(id) {
        alert("修改id"+id);
    }
</script>
</body>
</html>
