package com.nothing.controller;

import com.alibaba.fastjson.JSONObject;
import com.nothing.service.BuildingService;
import com.nothing.service.DormitoryService;
import com.nothing.vo.charge.charModule;
import com.nothing.vo.sushe.studentFloor;
import com.nothing.vo.sushe.studentHour;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("Building")
//楼栋管理
public class BuildingController {
    @Resource
    BuildingService service;

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
    public String Buildingadd(studentFloor studentFloor , HttpServletRequest request) {
        /*List<studentFloor> list =  service.selectBuildinglists("select floorName from studentfloor where floorName = "+studentFloor.getFloorName());
        for(int i=0;i<list.size();i++){
            if(studentFloor.equals(list.get(i))){
                System.out.println("数据重复 : "+list.get(i));
                request.setAttribute("num","1");
                return "BuildingManagement/Building";
            }
        }*/

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
    public JSONObject EmpList() {
        List examlist = service.selectBuildinglists("select * from charmodule");
        int con = service.SelcctBuildingcount("select count(empId) from charmodule");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("data", examlist);
        jsonObject.put("count", con);
        return jsonObject;
    }

    @RequestMapping("/updateboss")
    public String upDateBoss(String boss,String id){
        if("校长".equals(boss)){
            service.upDateObj("UPDATE charmodule SET boss=0 where charId ="+id);
        }else if("上级".equals(boss)){
            service.upDateObj("UPDATE charmodule SET boss=1 where charId ="+id);
        }else {
            service.upDateObj("UPDATE charmodule SET boss=3 where charId ="+id);
        }
        return "";
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
