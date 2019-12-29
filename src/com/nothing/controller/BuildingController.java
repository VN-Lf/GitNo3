package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.BuildingService;
import com.nothing.service.DormitoryService;
import com.nothing.service.GoPageService;
import com.nothing.vo.charge.charModule;
import com.nothing.vo.sushe.studentFloor;
import com.nothing.vo.sushe.studentHour;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("Building")
//楼栋管理
public class BuildingController {
    @Resource
    BuildingService service;
    @Resource
    GoPageService gservice;

   /* @RequestMapping("todormitory")
    public String todormitory() {
        return "BuildingManagement/Building";
    }*/

    @RequestMapping("toys")
    public String todormitorys() {
        return "BuildingManagement/Building";
    }

    @RequestMapping("toQuan")
    public String toQuan() {
        return "actStu/quan";
    }

    //查看方法
    @ResponseBody
    @RequestMapping("list")
    public JSONObject list() {
        System.out.println("进来了");
        //List list = this.service.selectDormitorylist(page, rows);
        List list = service.selectBuildinglists("select * from studentFloor");
        int count = service.SelcctBuildingcount("select count(*) from studentFloor");

        /*Map map = new HashMap();
        map.put("total", count);
        map.put("rows", list);*/

        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","");
        json.put("data",list);
        json.put("count",count);

        return json;
    }
    //宿舍添加
    @RequestMapping("Buildingadd")
    public String Buildingadd(studentFloor studentFloor) {
        service.addBuilding(studentFloor);
        return "redirect:toys";
    }

    //删除的方法
    @RequestMapping("Buildingdelete")
    public String Buildingdelete(String id ){
        System.out.println("进来了删除：id"+id);
        id = id.substring(0,id.length()-1);
        service.delBuilding(id);
        return "redirect:toys";
    }

    @RequestMapping("/quanlist")
    @ResponseBody
    public JSONObject quanList() {
        List examlist = service.selectBuildinglists("select * from charmodule");
        List wlist = gservice.deptList();
        for(int i = 0;i < examlist.size();i++){
            Map map = (Map)examlist.get(i);
            for(int j = 0;j < wlist.size(); j++){
                Map maps = (Map)wlist.get(j);
                String q1 = ""+map.get("deptId");
                if(q1.equals(""+maps.get("deptId"))){
                    map.put("deptId",maps.get("deptName"));
                    break;
                }
            }
            examlist.set(i,map);
        }
        int con = service.SelcctBuildingcount("select count(empId) from charmodule");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("data", examlist);
        jsonObject.put("count", con);
        return jsonObject;
    }

    @RequestMapping("/quanlists")
    @ResponseBody
    public JSONObject quanLists(String dept) {
        List examlist = service.selectBuildinglists("select * from charmodule where deptId ="+dept);
        List wlist = gservice.deptList();
        for(int i = 0;i < examlist.size();i++){
            Map map = (Map)examlist.get(i);
            for(int j = 0;j < wlist.size(); j++){
                Map maps = (Map)wlist.get(j);
                String q1 = ""+map.get("deptId");
                if(q1.equals(""+maps.get("deptId"))){
                    map.put("deptId",maps.get("deptName"));
                    break;
                }
            }
            examlist.set(i,map);
        }
        int con = service.SelcctBuildingcount("select count(empId) from charmodule where deptId ="+dept);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("data", examlist);
        jsonObject.put("count", con);
        return jsonObject;
    }

    @RequestMapping("/updateboss")
    public String upDateBoss(String boss,String deptId,String id){
        if("0".equals(boss)){
            //更改原来的校长
            service.upDateObj("UPDATE charmodule AS ca INNER JOIN (SELECT charId FROM charmodule WHERE boss=0) AS c SET boss=3 WHERE ca.charId=c.charId");
            service.upDateObj("UPDATE charmodule SET boss=0 where charId ="+id);
        }else if("1".equals(boss)){
            List wlist = gservice.deptList();
            for(int j = 0;j < wlist.size(); j++){
                Map maps = (Map)wlist.get(j);
                if(deptId.equals(""+maps.get("deptName"))){
                    deptId = ""+maps.get("deptId");
                    break;
                }
            }
            //判断同部门是否还有其他人是上级
            List<Map> list = service.selectBuildinglists("select charId from charmodule where boss=1 and deptId ="+deptId);
            if(list.size() != 0){
                service.upDateObj("UPDATE charmodule SET boss=3 where charId ="+list.get(0).get("charId"));
                service.upDateObj("UPDATE charmodule SET boss=1 where charId ="+id);
            }else {
                service.upDateObj("UPDATE charmodule SET boss=1 where charId ="+id);
            }
        }else {
            service.upDateObj("UPDATE charmodule SET boss=3 where charId ="+id);
        }
        return "actStu/quan";
    }
    @RequestMapping("/up")
    public String banEmp(String cid,String lie,String zt) {
        System.out.println(cid+"|"+lie+"|"+zt);
        if("1".equals(zt)){
            zt="0";
        }else zt="1";
        service.upDateObj("UPDATE charmodule SET "+lie+"="+zt+" where charId ="+cid);

        return "actStu/quan";
    }
}
