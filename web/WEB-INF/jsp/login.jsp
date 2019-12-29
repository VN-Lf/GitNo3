<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/3
  Time: 19:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录</title>
    <script src="${pageContext.request.contextPath}/jquery.js"></script>

    <style>
        input {
            border: 0px;
            outline: none;
        }
        #name,#pwd,#pwdLook {
            background-Color: transparent;
            border: none;
            border-bottom: 1px solid #000;
            width: 100%;
            height: 40px;
            margin-top: 15px;
            padding: 0 20px;
            font-size: 18px;
            transition: 0.5s;
        }
        #login {
            margin-top: 30px;
            margin-left: 5%;
            width: 90%;
            height: 35px;
            border: 0px;
            font-size: 16px;
            background-color: yellow;
            cursor: pointer;
            transition: all .5s;
        }
        .tishis {
            transition: 0.5s;
            position: absolute;
            left: 20px;
            top: 20px;
            font-size: 20px;
            color: rgb(100, 92, 92);
        }
        #stu{
            float: left;width: 18%;height:20px;padding: 10px;background-color:#00FA9A;
            cursor: pointer;
            transition: 0.5s;
        }
        #emp{
            float: left;width: 68%;height:20px;background-color: #ff0;padding: 10px;
            cursor: pointer;
            transition: 0.5s;
        }
    </style>
</head>

<body>
<div id="left" style="width: 30%;height: 100%;float: left;;background-color: rgb(136, 136, 221) ">
    <img id="obj1" class="img1" alt="" src="${pageContext.request.contextPath }/photos/l.jpg" width="100%" height="100%" border="0">
</div>
<div id="conter" style="width:40%;height: 100%;float: left;background-color:#f1f1f1;">
    <div align="center" style="width: 100%;height: 30%;">
        <h1 style="padding-top: 60px;">校园管理系统</h1>
    </div>
    <div style="width: 100%;height: 40%;">
        <div style="width: 350px;height: 100%;margin: 0 auto;">
            <form action="<%=request.getContextPath()%>/to/login" method="post" style="position: relative;">
                <input type="hidden" name="type" value="emp" id="type">
                <div style="width: 100%;height: 40px;margin-bottom: 10px">
                    <div style="width: 315px;margin: 0 auto;height: 40px">
                        <div align="center" id="stu" onclick="qiehuanLog('stu')">学生端</div>
                        <div align="center" id="emp" onclick="qiehuanLog('emp')">教师端</div>
                    </div>
                </div>
                <div style="position: relative;">
                    <input id="name" type="text"  name="zhanghao" oninput="donTai()" />
                    <span id="tishi" class="tishis">手机号</span>
                </div>
                <div style="position: relative;">
                    <input id="pwd" type="password" name="pwd" style="outline: none;" ondblclick="lookNo(1)" oninput="donTai2('pwd')" ;/>
                    <input id="pwdLook" type="text" style="display: none" ondblclick="lookNo(2)" oninput="donTai2('pwdLook')" ;/>
                </div>
                <span id="tishi2" style="top:125px" class="tishis">密码</span>
                <div>
                    <input type="submit" id="login" value="登录" />
                </div>
            </form>
        </div>
    </div>
    <div style="width: 100%;height: 25%;"></div>
</div>
<div id="right" style="width: 30%;height: 100%;float:left;background-color: rgb(136, 136, 221);">
    <img id="obj2" class="img1" alt="" src="${pageContext.request.contextPath }/photos/x.jpg" width="100%" height="100%" border="0">
</div>
</body>
<script language="JavaScript">

    function qiehuanLog(id) {
        document.getElementById("type").value=id;
        if(id == "stu"){
            $("#stu").css("width","68%");
            $("#emp").css("width","18%");
            $("#login").css("background-color","#00FA9A");
            $("#biaoti").css("color","#00FA9A");
        }else if(id == "emp"){
            $("#emp").css("width","68%");
            $("#stu").css("width","18%");
            $("#login").css("background-color","yellow");
            $("#biaoti").css("color","yellow");
        }
    }
    function donTai() {
        var name = document.getElementById("name").value;
        if (name == null || name == "") {
            $("#tishi").css("top", "20px");
            $("#tishi").css("left", "20px");
            $("#tishi").css("font-size", "20px");
            document.getElementById("tishi").innerText = "手机号";

            $("#name").css("width", "100%");
            $("#name").css("height", "40px");
            $("#name").css("margin-left", "0");
            $("#name").css("margin-bottom", "0");
            $("#name").css("border", "none");
            $("#name").css("border-bottom", "1px solid #000");
        } else {
            $("#tishi").css("top", "22px");
            $("#tishi").css("left", "-35px");
            $("#tishi").css("font-size", "16px");
            document.getElementById("tishi").innerText = "账号";

            $("#name").css("width", "90%");
            $("#name").css("height", "35px");
            $("#name").css("margin-left", "5%");
            $("#name").css("margin-bottom", "5px");
            $("#name").css("border", "1px solid #000");
        }
    }

    function donTai2(id2) {
        var id = document.getElementById(id2);
        var name = id.value;
        if(id2 == 'pwd'){
            document.getElementById("pwdLook").value = name;
        }else {
            document.getElementById("pwd").value = name;
        }
        if (name == null || name == "") {
            $("#tishi2").css("top", "125px");
            $("#tishi2").css("left", "20px");
            $("#tishi2").css("font-size", "20px");

            id.style.width = "100%";
            id.style.height = "40px"
            id.style.marginLeft = "0";
            id.style.marginBottom = "0";
            id.style.border = "none";
            id.style.borderBottom = "1px solid #000";
        } else {
            $("#tishi2").css("top", "127px");
            $("#tishi2").css("left", "-35px");
            $("#tishi2").css("font-size", "16px");

            id.style.width = "90%";
            id.style.height = "35px"
            id.style.marginLeft = "5%";
            id.style.marginBottom = "5px";
            id.style.border = "1px solid #000";
        }
    }

    function lookNo(x) {
        if (x == "1") {
            document.getElementById("pwd").style.display = "none";
            document.getElementById("pwdLook").style.display = "block";
            var pwd = document.getElementById("pwd").value;
            document.getElementById("pwdLook").value = pwd;
            donTai2('pwdLook');
        } else if (x == "2") {
            document.getElementById("pwdLook").style.display = "none";
            document.getElementById("pwdLook").style.outline = "none";
            document.getElementById("pwd").style.display = "block";
            var pwdLook = document.getElementById("pwdLook").value;
            document.getElementById("pwd").value = pwdLook;
            donTai2('pwd');
        }
    }

    //图片轮播
    var leftIndex=0;
    var rightIndex=1;
    //时间间隔(单位毫秒)，每秒钟显示一张，数组共有5张图片放在Photos文件夹下。
    var timeInterval=3000;
    var arr=new Array();
    arr[0]="${pageContext.request.contextPath }/photos/x.jpg";
    arr[1]="${pageContext.request.contextPath }/photos/l.jpg";
    arr[2]="${pageContext.request.contextPath }/photos/m.jpg";
    arr[3]="${pageContext.request.contextPath }/photos/f.jpg";
    arr[4]="${pageContext.request.contextPath }/photos/n.jpg";
    setInterval(changeImg,timeInterval);
    function changeImg()
    {
        var obj1=document.getElementById("obj1");
        var obj2=document.getElementById("obj2");
        if (leftIndex==arr.length-1)
        {
            leftIndex=0;
        }
        else
        {
            leftIndex+=1;
        }
        if (rightIndex==arr.length-1)
        {
            rightIndex=0;
        }
        else
        {
            rightIndex+=1;
        }
        obj2.src=arr[leftIndex];
        obj1.src=arr[rightIndex];
    }

</script>
<%
    HttpSession sess = request.getSession();
    String message = (String)sess.getAttribute("mes");
    String zh = (String)sess.getAttribute("zangh");
    if(message == "" /*|| message.equals("")*/){
    }else{
%>
<script type="text/javascript">
    var a = "<%=message%>"
    var s = "<%=zh%>"
    if(a !="null" ){
        alert(a);
        $("#name").val(s);
        $("#name").attr("value",s);

        donTai();
    }
</script>
<%
        sess.setAttribute("mes", "");
    }
%>
</html>
