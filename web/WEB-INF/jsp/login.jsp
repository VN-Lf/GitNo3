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
    <script src="http://localhost:8888/jquery.js"></script>
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
    </style>
</head>

<body>
<div id="left" style="width: 30%;height: 100%;float: left;;background-color: rgb(136, 136, 221);">
    <h1>左边 推送内容</h1>
</div>
<div id="conter" style="width:40%;height: 100%;float: left;">
    <div style="width: 100%;height: 30%;">校园管理系统</div>
    <div style="width: 100%;height: 40%;">
        <div style="width: 350px;height: 100%;margin: 0 auto;">
            <form action="<%=request.getContextPath()%>/to/login" method="post" style="position: relative;">
                <div style="position: relative;">
                    <input id="name" type="text" name="zhanghao" oninput="donTai()" />
                    <span id="tishi" class="tishis">账号</span>
                </div>
                <div style="position: relative;">
                    <input id="pwd" type="password" name="pwd" style="outline: none;" ondblclick="lookNo(1)" oninput="donTai2('pwd')" ;/>
                    <input id="pwdLook" type="text" name="pwd" style="display: none" ondblclick="lookNo(2)" oninput="donTai2('pwdLook')" ;/>
                </div>
                <span id="tishi2" style="top:75px" class="tishis">密码</span>
                <div>
                    <input type="submit" id="login" value="登录" />
                </div>
            </form>
        </div>
    </div>
    <div style="width: 100%;height: 30%;">下 友情链接或其它</div>
</div>
<div id="right" style="width: 30%;height: 100%;float:left;background-color: rgb(136, 136, 221);">
    <h1>右边</h1>
</div>
</body>
<script language="JavaScript">
    function donTai() {
        var name = document.getElementById("name").value;

        if (name == null || name == "") {
            $("#tishi").css("top", "20px");
            $("#tishi").css("left", "20px");
            $("#tishi").css("font-size", "20px");

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

            $("#name").css("width", "90%");
            $("#name").css("height", "35px");
            $("#name").css("margin-left", "5%");
            $("#name").css("margin-bottom", "5px");
            $("#name").css("border", "1px solid #000");
        }
    }

    function donTai2(id) {
        var name = document.getElementById(id).value;
        var id = document.getElementById(id);
        if (name == null || name == "") {
            $("#tishi2").css("top", "75px");
            $("#tishi2").css("left", "20px");
            $("#tishi2").css("font-size", "20px");

            id.style.width = "100%";
            id.style.height = "40px"
            id.style.marginLeft = "0";
            id.style.marginBottom = "0";
            id.style.border = "none";
            id.style.borderBottom = "1px solid #000";
        } else {
            $("#tishi2").css("top", "77px");
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
</script>
</html>
