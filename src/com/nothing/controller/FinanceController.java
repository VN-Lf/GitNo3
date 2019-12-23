package com.nothing.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.nothing.service.FinanceService;
import com.nothing.vo.tuition.financeshouldTuitionRecord;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("finance")
public class FinanceController {
    @Resource
    private FinanceService fs;
    //前往学费列表
    @RequestMapping("/toTuitionList")
    public String toTuitionList(){
        return "TuitionManagement/tuitionList";
    }
    @RequestMapping("/toTuitionAdd")
    public String toTuitionAdd(){
        return "TuitionManagement/tuitionAdd";
    }

    @RequestMapping("/tuitionAdd")
    @ResponseBody
    public void tuitionAdd(financeshouldTuitionRecord ft,String money){
        ft.setFactMoney(Float.valueOf(money));
        System.out.println(Float.valueOf(money));
        SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
        String date = sdf.format(new Date());
        ft.setFinancedate(date);
        ft.setInvalid(1);
        fs.tiotionAdd(ft);
    }
    @RequestMapping("/cencal")
    @ResponseBody
    public void tuitionCencal(String id){
        financeshouldTuitionRecord f = fs.getf(Integer.parseInt(id));
        f.setInvalid(2);
        fs.tuitionUp(f);
    }
    @RequestMapping("/back")
    @ResponseBody
    public void tuitionBack(String id){
        financeshouldTuitionRecord f = fs.getf(Integer.parseInt(id));
        f.setInvalid(2);
        fs.tuitionUp(f);
        f.setInvalid(1);
        f.setFactMoney(f.getFactMoney()-2*f.getFactMoney());
        fs.tiotionAdd(f);
    }
    @RequestMapping("/tuitionList")
    @ResponseBody
    public JSONObject tuitionList(){
        List tList = fs.tuitionList();
        int con = fs.getTuitionCount();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count",con);
        jsonObject.put("data", tList);
        System.out.println(jsonObject.toJSONString());
        return jsonObject;
    }


    @RequestMapping("/getClass")
    @ResponseBody
    public List getC(){
        return fs.getC();
    }
}
