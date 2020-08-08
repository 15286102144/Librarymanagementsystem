package com.group.controller;

import com.group.pojo.User;
import com.group.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;

@Controller
@RequestMapping("user")
public class UserController {
    @Autowired
    private UserService us;
  @RequestMapping("login.do")
  public  String login(){
      return "login";
  }
    @RequestMapping("checkLogin.do")
    @ResponseBody
    public String checkLogin(User user, String remember, HttpServletResponse response, HttpServletRequest request){
        //System.out.println(remember);
        //交给业务层来进行 shiro认证
        String info = us.checkLogin(user,remember,response,request);
        return info;
    }
    //DefaultFilter //这个类里面定义所有shiro所有的过滤器
    @RequestMapping("success.do")
    public String success(){

        return "index";
    }
    @RequestMapping("de.do")
    public String de(){

        return "book/addbook";
    }
    //退出用户
    @RequestMapping(value = "logout.do",produces = "application/json;charset=utf-8")
    @ResponseBody
    public User logout(HttpServletRequest request){
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        User p = us.queryCookie(request);
        System.out.println(p+"   persond");
        return p;
    }



    @RequestMapping("showWelcome.do")
    public String showWelcome(){
        //要获取服务器某些并通过EL表达式显示在welcome.jsp
        return "welcome";
    }
    //注册
    @RequestMapping(value = "regest.do" ,produces = "application/text;charset=utf-8")
    @ResponseBody
    public String regest(User user,@RequestParam(value="yanz",required=false) int yanz,HttpServletRequest request){
         if(yanz!=(Integer) (request.getSession().getAttribute("yanz")))
//             ((int)request.getSession().getAttribute("yanz"))
             return "验证码错误";
        if(user.getUsername()==null||user.getPassword()==null)
            return "密码/用户不能为空";
        boolean falg=us.insert(user);
if(falg)
        return "注册成功";

    return "注册失败，请重新注册";
    }

    @RequestMapping(value = "email.do" )
    @ResponseBody
    public boolean email(String email){

        return us.sendEmail(email);
    }

    @RequestMapping("logouts.do")
    public String logouts(HttpServletRequest request){
        System.out.println("xxxxx");
        ServletContext context = request.getSession().getServletContext();
        int online=(Integer) context.getAttribute("onLineNum")-1;
        context.setAttribute("onLineNum",online);
        Subject subject=SecurityUtils.getSubject();
        subject.logout();
        return "redirect:user/login.do";
    }
    @RequestMapping("userList.do")
    public String userList(){
        return "user/userList";
    }

    @RequestMapping("queryAllUser.do")
    @ResponseBody
    public HashMap<String,Object> queryAllUser(User user){

        HashMap<String,Object> map = us.queryAllUser(user);
        System.out.println("-----------map------"+map);
        return map;
    }

    @RequestMapping("update.do")
    public String update(String username, ModelMap model){
        User user = us.selectByUsername(username);
        System.out.println(user);
        model.addAttribute("user",user);
        return "user/update";
    }


    @RequestMapping("updateUser.do")
    public String updataUser(User user,ModelMap model){
        System.out.println(user);
        if (us.updateByPrimaryKey(user)>0){
            //刷新
            HashMap map = us.queryAllUser(user);
            model.addAttribute("info","修改成功");
            return "welcome";
        }else {
            return "user/update";
        }
    }


    @RequestMapping(value = "updateAjax.do",produces = "application/json;charset=utf-8",method = RequestMethod.POST)
    @ResponseBody  //由于加了ResponseBody，他会返回一个字符串
    public HashMap upadate(User user){
        System.out.println("---------updateAjax.do---------user="+user);
        HashMap map = new HashMap();
        if(us.updateByPrimaryKeySelective(user)>0){
            map.put("info","修改成功");
        }else{
            map.put("info","修改失败");
        }
        return map;  ////由于加了@ResponseBody注解，他会返回一个字符串

    }

    @RequestMapping(value = "delete.do",produces = "application/json;charset=utf-8",method = RequestMethod.POST)
    @ResponseBody  //由于加了ResponseBody，他会返回一个字符串
    public HashMap<String,Object> delete(@RequestParam("userid") int userid){
        HashMap<String,Object> map = new HashMap();
        if(us.delete(userid)>0){
            map.put("info","删除成功");
        }else{
            map.put("info","删除失败");
        }
        return map;  ////由于加了@ResponseBody注解，他会返回一个字符串

    }

}
