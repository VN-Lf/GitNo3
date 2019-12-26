package com.nothing.service.impl;

import com.nothing.dao.BaseDao;
import com.nothing.service.ActivitiService;
import com.nothing.service.EmpService;
import com.nothing.vo.emp.Emp;
import com.nothing.vo.emp.JobsVo;
import com.nothing.vo.emp.Post;
import org.activiti.engine.*;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricVariableInstance;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.impl.persistence.entity.CommentEntity;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

@Service//
public class ActivitiServiceImpl extends BaseDao implements ActivitiService{
    @Resource
    private RepositoryService repositoryService;
    @Resource
    private TaskService taskService;
    @Resource
    private RuntimeService runtimeService;
    @Resource
    private HistoryService historyService;
    @Resource
    private EmpService empService;

    @Override
    public void upLiuCheng(MultipartFile pdFile){
        try {
            //创建临时file对象
            File file=File.createTempFile("tmp", null);
            //把MultipartFile对象转换成java.io.FileUI对象
            pdFile.transferTo(file);
            //部署Zip文件  将流程上传到Activiti框架
            Deployment deployment = repositoryService.createDeployment().addZipInputStream(new ZipInputStream(new FileInputStream(file))).deploy();
            System.out.println("ID "+deployment.getId());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void xiaZaiLiu(String id, HttpServletResponse resp){
        try {
            //设置response对象的头参数，attachment就是附件，filename=文件名称
            resp.setHeader("Content-disposition","attachment;filename=" +id+".zip" );
            //下载的文件类型是zip文件
            resp.setContentType("application/x-zip-compressed");

            //----------------------------------------------------------------------------

            //流程定义对象
            ProcessDefinition processDefinition = repositoryService
                    .createProcessDefinitionQuery()
                    .processDefinitionId(id).singleResult();
            //部署id
            String deploymentId = processDefinition.getDeploymentId();

            //bpmn资源文件名称
            String resourceName_bpmn = processDefinition.getResourceName();
            //bpmn资源文件输入流
            InputStream inputStream_bpmn = repositoryService.getResourceAsStream(deploymentId, resourceName_bpmn);
            //png文件名称
            String resourceName_png = processDefinition.getDiagramResourceName();
            //png资源文件输入流
            InputStream inputStream_png = repositoryService.getResourceAsStream(deploymentId, resourceName_png);

            //------创建输出流，绑定到response对象-------------------------------------------------------
            OutputStream out = resp.getOutputStream();
            //创建ZIP输出对象，绑定到输出流
            ZipOutputStream zipo = new ZipOutputStream(out);

            //流复制
            byte[] b = new byte[1024];
            int len = -1;

            //定义zip压缩包中的文件对象（zip实体）
            ZipEntry ze = new ZipEntry(resourceName_bpmn);
            //把创建的实体对象放到压缩包中
            zipo.putNextEntry(ze);
            //文件内容拷贝
            while((len = inputStream_bpmn.read(b,0,1024)) != -1){
                zipo.write(b,0,b.length);
            }
            zipo.closeEntry();
            //---------------
            ZipEntry ze1 = new ZipEntry(resourceName_png);
            zipo.putNextEntry(ze1);
            while((len = inputStream_png.read(b,0,1024)) != -1){
                zipo.write(b,0,b.length);
            }
            //关闭流
            inputStream_bpmn.close();
            inputStream_png.close();
            zipo.flush();
            zipo.close();
            out.flush();
            out.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void addJobs(JobsVo job,String dept) {
        job.setJobDate(new Date());//创建时间
        job.setProcessFlag(1);//状态1、审批中
        addObject(job);

        //设置流程实例变量集合
        Map<String,Object> variables = new HashMap<>();
        variables.put("userId",job.getUserId());//员工id
        variables.put("day",job.getDay());//天数
        variables.put("jobId",job.getJobId());//单据ID

            //根据用户设置下一个办理人（）
            String  zxempid = ""+sqlZhixin(dept);
            System.out.println("zxempid:"+zxempid);
            if(zxempid.equals(job.getUserId())){ //这个员工是主任
                List list = listBySQL2("select empId from charmodule where boss=0");
                System.out.println("下一个办理人id："+list.get(0));
                variables.put("x","zr");//单据ID
                variables.put("assignee",""+list.get(0));
            }else {
                System.out.println("下一个 id："+zxempid);
                variables.put("x","yg");//单据ID
                variables.put("assignee",""+zxempid);
            }
            //启动实例（通过流程定义的key来启动一个实例）
            ProcessInstance processInstance = runtimeService.startProcessInstanceByKey(job.getJobType(),variables);
            System.out.println("流程实例 "+processInstance.getId());

            //根据流程实例ID获取当前实例正在执行的任务
            Task task = taskService.createTaskQuery().processInstanceId(processInstance.getId()).orderByProcessInstanceId().desc().singleResult();
            System.out.println("任务ID： "+task.getId());
            //完成任务(通过任务ID完成该任务)
            taskService.complete(task.getId(),variables);
    }

    @Override
    public void lookLiuTu(String did, String imageName, HttpServletResponse resp) {
        InputStream in = repositoryService.getResourceAsStream(did,imageName);
        try {
            OutputStream out = resp.getOutputStream();
            // 把图片的输入流程写入resp的输出流中
            byte[] b = new byte[1024];
            for (int len = -1; (len= in.read(b))!=-1; ) {
                out.write(b, 0, len);
            }
            // 关闭流
            out.close();
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<JobsVo> selJob(String actorId) {
        List<JobsVo> list = listByHql("from JobsVo j where j.userId='"+actorId+"'");
        List empList = empService.selEmpAll("select p.postName,d.deptName,e.* from emp e,post p,dept d where e.empDeptId=d.deptId and e.empId=p.empId"); //查询所有员工
        //将com中的emp id转换成用户名
        for (int i = 0;i < list.size(); i++){
            JobsVo jvo = list.get(i);
            for(int j = 0;j < empList.size(); j++){
                Map map = (Map)empList.get(j);
                if(jvo.getUserId().equals(""+map.get("empId"))){
                    jvo.setUserId(""+map.get("empName"));
                    break;
                }
            }
            list.set(i,jvo);
        }
        return list;
    }

    @Override
    public Map lookLiuCheng(String jobId,String instId){
        Map<String, Object> rmap = new HashMap<>();
        String LiuId = "";//流程实例ID
        if(jobId!=null&&!"".equals(jobId)){
            //通过单据id查找实例对象
            HistoricVariableInstance hvi = historyService.createHistoricVariableInstanceQuery().variableValueEquals("jobId", Integer.parseInt(jobId)).singleResult();
            //通过历史流程变量查询变量对象(获取流程实例ID)
            LiuId = hvi.getProcessInstanceId();
        }
        //我的任务（查看办理进度）
        if(instId!=null&&!"".equals(instId)){
            LiuId = instId;
        }
        //获取历史任务实例
        HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()
                .processInstanceId(LiuId).singleResult();

        if(historicProcessInstance!=null){
            //获取流程定义信息
            ProcessDefinition pd = repositoryService.getProcessDefinition(historicProcessInstance.getProcessDefinitionId());
            // 获取流程定义的实体（包含了流程中的任务节点信息，连线信息）
            ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity)pd;
            //添加到map中
            rmap.put("pd",pd);
            // 获取流程历史中已执行节点，并按照节点在流程中执行先后顺序排序
            List<HistoricActivityInstance> historicActivityInstanceList = historyService.createHistoricActivityInstanceQuery()
                    .processInstanceId(LiuId).orderByHistoricActivityInstanceId().asc().list();
            // 已经激活的节点ID集合
            //激活的节点（1.任务已经完成；2.任务已经开始，但还未结束）
            List mapList = new ArrayList();
            //获取已经激活的节点ID
            for (HistoricActivityInstance activityInstance : historicActivityInstanceList) {
                //getActivityId方法获取已经激活的节点id
                ActivityImpl activityImpl = processDefinition.findActivity(activityInstance.getActivityId());
                //获取当前节点在图片中的坐标位置，左上角坐标及长宽
                int x = activityImpl.getX();
                int y = activityImpl.getY();
                int height = activityImpl.getHeight();
                int width = activityImpl.getWidth();
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("x", x);
                map.put("y", y);
                map.put("height", height);
                map.put("width", width);
                mapList.add(map);
            }
            rmap.put("maplist",mapList);
        }

        return rmap;
    }

    @Override
    public Map zhixieTask(String taskId, String instId){
        Map<String, Object> rmap = new HashMap<>();
        //根据流程实例ID查询流程实例
        ProcessInstance pi = runtimeService.createProcessInstanceQuery().processInstanceId(instId).singleResult();
        List<Comment> commentList = taskService.getProcessInstanceComments(instId); //历史审批信息
        List empList = empService.selEmpAll("select p.postName,d.deptName,e.* from emp e,post p,dept d where e.empDeptId=d.deptId and e.empId=p.empId"); //查询所有员工
        List maxlist = chuliComm(commentList,empList);
        rmap.put("emplist",empList);
        if(maxlist.size() == 0){
            rmap.put("zhi","0");
        }else {
            rmap.put("zhi","1");
            rmap.put("commentList",maxlist);
        }
        //获取当前活动id
        String activeId = pi.getActivityId();
        System.out.println("当前活动ID "+activeId);
        //获取当前活动(usertask2)
        //ActivityImpl impl = pdentity.findActivity(activeId);

        return rmap;
    }

    @Override
    public JobsVo selJobById(int id) {
        return (JobsVo)getObject(JobsVo.class,id);
    }

    @Override
    public void updJob(JobsVo jobsVo) {
        updObject(jobsVo);
    }

    @Override
    public void xiuGaiTask(int jobId,String taskId,String flow,String comment,String userId){
        //根据任务ID得到任务对象
        Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
        //通过任务对象获取流程实例ID
        String processInstId = task.getProcessInstanceId();
        //根据单据ID查询单据对象
        JobsVo job = selJobById(jobId);

        //设置当前任务办理人（主要是备注表）
        Authentication.setAuthenticatedUserId(userId);

        //设置备注信息(任务ID，实例ID，页面上的备注)
        taskService.addComment(taskId,processInstId,comment);

        //添加任务变量
        Map variable = new HashMap();
        variable.put("flow",flow);
        //设置办理人
        List list = listBySQL2("select empId from charmodule where boss=0");
        System.out.println("办理人id："+list.get(0));
        variable.put("assignee",""+list.get(0));
        //完成当前任务
        taskService.complete(taskId,variable);

        //根据流程实例获取实例对象(完成流程的实例依然会存放在数据库中 但是查询出来是null的)
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstId).singleResult();
        if(processInstance == null){
            if(flow.equals("拒绝")){
                //修改单据状态
                job.setProcessFlag(3);//3、审批不通过
            }else{
                //修改单据状态
                job.setProcessFlag(2);//2、审批通过
            }
            updJob(job);
        }
    }

    @Override
    public void xiuGaiTaskStu(int jobId, String taskId, String flow, String comment, String userId) {
        //根据任务ID得到任务对象
        Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
        //通过任务对象获取流程实例ID
        String processInstId = task.getProcessInstanceId();
        //根据单据ID查询单据对象
        JobsVo job = selJobById(jobId);
        //设置当前任务办理人（主要是备注表）
        Authentication.setAuthenticatedUserId(userId);
        //设置备注信息(任务ID，实例ID，页面上的备注)
        taskService.addComment(taskId,processInstId,comment);

        //添加任务变量
        Map variable = new HashMap();
        variable.put("flow",flow);
        //设置办理人
        if("授课教师".equals(task.getName())){//当前审批为科任老师
            String studId = job.getUserId();
            List list = listBySQL2("select classAdviser from classVo where classId = (select classId from student where studId = "+studId+")");

            System.out.println("班主任id："+list.get(0));
            variable.put("assignee",""+list.get(0));
        }else if("班主任".equals(task.getName())){
            List list = listBySQL2("SELECT empId FROM charmodule where boss=0");
            System.out.println("校长id："+list.get(0));
            variable.put("assignee",""+list.get(0));
        }

        //完成当前任务
        taskService.complete(taskId,variable);

        //根据流程实例获取实例对象(完成流程的实例依然会存放在数据库中 但是查询出来是null的)
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstId).singleResult();
        if(processInstance == null){
            if(flow.equals("拒绝")){
                //修改单据状态
                job.setProcessFlag(3);//3、审批不通过
            }else{
                //修改单据状态
                job.setProcessFlag(2);//2、审批通过
            }
            updJob(job);
        }
    }

    @Override
    public List lookMyBeiZhu(int id){
        //通过jobID查询历史变量对象
        HistoricVariableInstance hvi = historyService.createHistoricVariableInstanceQuery().variableValueEquals("jobId",id).singleResult();
        //获取流程实例id （查询历史批注）
        List<Comment> commentList = taskService.getProcessInstanceComments(hvi.getProcessInstanceId());        //System.out.println("历史时间"+commentList.get(0).getTime());
        //将com中的emp id转换成用户名
        List empList = empService.selEmpAll("select p.postName,d.deptName,e.* from emp e,post p,dept d where e.empDeptId=d.deptId and e.empId=p.empId"); //查询所有员工
        List comList = chuliComm(commentList,empList);
        return comList;
    }

    @Override
    public String sqlZhixin(String deptid){
        List list = listBySQL2("SELECT empId FROM charmodule where actEmp =1 and deptId ="+deptid);
        if(list.size() == 0){
            return "0"; //无主任则给总经理审批
        }else {
            return ""+list.get(0);
        }
    }

    public List chuliComm(List<Comment> commentList,List empList){
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List comList = new ArrayList<>();
        for (int i = 0;i < commentList.size(); i++){
            Map map = new HashMap();
            CommentEntity com = (CommentEntity) commentList.get(i);
            map.put("com",com);
            System.out.println("com对象:"+com);
            String shijian = formatter.format(com.getTime());
            map.put("sj",shijian);
            comList.add(i,map);

            for(int j = 0;j < empList.size(); j++){
                Map emp = (Map)empList.get(j);
                if(com.getUserId().equals(""+emp.get("empId"))){
                    com.setUserId(""+emp.get("empName"));
                    break;
                }
            }
            commentList.set(i,com);
        }
        return comList;
    }
}
