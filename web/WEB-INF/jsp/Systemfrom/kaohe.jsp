<%--
  Created by IntelliJ IDEA.
  User: freedom
  Date: 2019/11/25
  Time: 14:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="index.jsp"%>
<html>
<head>
    <title>员工考核统计</title>
    <script  type="text/javascript" src="${pageContext.request.contextPath}/echarts.min.js"></script>
</head>
<body id="kaohe">
<div id="pie" style="width: 100%;height:100%;margin-top: 50px">
</div>
<button style="position:absolute;left: 900px;top:50px" onclick="kaohe()" >查看数据详情</button>

</body>
<script type="text/javascript">
    var myEcharts=echarts.init(document.getElementById("pie"),'halloween');
    var str="";
    $.post("${pageContext.request.contextPath}/System/kaohelist",{},function (d) {
        myEcharts.setOption({
            title:{
                text:'员工考核分数统计',
                x:'center',
                y:'top',
                textAlign:'left'
            },
            tooltip:{
                text:'score'
            },
            legend:{
                data:['score']
            },
            xAxis:{
                data:d.name,
                axisLabel:{
                    fontSize:20,
                }
            },
            yAxis:{
                axisLabel:{
                    fontSize:20,
                }
            },
            series:{
                name:'分数',
                type:'bar',
                data:d.value
            }
            }
        )
    },"json");


    function kaohe() {
        document.getElementById("kaohe").innerHTML =
            '<object type="text/html" data="${pageContext.request.contextPath}/System/kaohedata" width="100%" height="100%"></object>';
    }
</script>
</html>
