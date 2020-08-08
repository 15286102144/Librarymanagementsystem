package com.group.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.group.dao.UserMapper;
import com.group.pojo.User;
import com.group.service.UserService;
import com.group.utils.GetIp;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.ByteSource;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.*;


@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;
    //注入邮件发送对象
    @Autowired
    private JavaMailSender mailSender;
@Autowired
GetIp getIp;

    public String checkLogin(User p, String remember, HttpServletResponse response, HttpServletRequest request) {
        //1.拿到当前用户
        Subject s = SecurityUtils.getSubject();
        //2.判断当前用户是否被认证，并做相关处理
        if(!s.isAuthenticated()){
            //UsernamePasswordToken 令牌类  稍后会把保存在里面账号密码和shiro的身份和凭证比对
            UsernamePasswordToken upt = new UsernamePasswordToken(p.getUsername(),p.getPassword());
            upt.setRememberMe(true);
            try {

                //进行认证(因为我们写了自定义的realm类，所以会自动到realm类里面去认证)
                s.login(upt);
                //登录成功
                //保存用户名在session
            //保存用户名和首页资源在session
                User user = new User();
                user = userMapper.queryPersonByPersonName(p.getUsername());
                s.getSession().setAttribute("userinfo", user);

                s.getSession().setAttribute("userName",p.getUsername());
//获取首页信息
                HashMap<String, Object> indexinfo = new HashMap<String, Object>();
                //获取ip
                Object ip = getIp.getLocalHostLANAddress();
                //获取当前时间
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String date = simpleDateFormat.format(new Date());
                //获取账户
                String username = p.getUsername();
                //姓名
                String name = "";
                if (userMapper.queryPersonByPersonName(p.getUsername()).getSex().equals("男")) {
                    name = "Mr." + p.getUsername();
                } else {
                    name = "Miss." + p.getUsername();
                }
                //获取服务器名称
                String servicename = "D:/tomcat/apache-tomcat-8.0.32";
                //获取服务器ip
                String serviceip = request.getSession().getServletContext().getRealPath("/");
                //获取在线人数
                // 获取 ServletContext 对象
                ServletContext context = request.getSession().getServletContext();
                int online=(Integer) context.getAttribute("onLineNum")+1;
                context.setAttribute("onLineNum",online);

                indexinfo.put("ip", ip);
                indexinfo.put("date", date);
                indexinfo.put("username", username);
                indexinfo.put("name", name);
                indexinfo.put("servicename", servicename);
                indexinfo.put("serviceip", serviceip);

                s.getSession().setAttribute("indexinfo", indexinfo);




                Set<String> roles = new HashSet<String>();
                //查询数据库得到用户的权限
                String role = userMapper.queryPersonByPersonName(p.getUsername()).getRole();
                    roles.add(role);
                s.getSession().setAttribute("roles",roles);


                //判断复选框的状态
                if(remember.equals("YES")){
                    //1.创建cookie  Servlet  cookie的使用
                   /* Cookie c = new Cookie("USERNAME",p.getPersonName());
                    Cookie c2 = new Cookie("PASSWORD",p.getPersonPassword());
                    //2.设置cookie的时间
                    c.setMaxAge(30*24*60*60);
                    c2.setMaxAge(30*24*60*60);
                    //3.将cookie回写给浏览器
                    response.addCookie(c);
                    response.addCookie(c2);*/

                    //在shiro  cookie的使用
                    //1.创建SimpleCookie
                    SimpleCookie simpleCookie1 = new SimpleCookie();
                    //2,在cookie存值
                    simpleCookie1.setName("USERNAME");
                    simpleCookie1.setValue(p.getUsername());
                    simpleCookie1.setMaxAge(30*24*60*60);
                    //4.回写给浏览器
                    simpleCookie1.saveTo(request,response);
                    SimpleCookie simpleCookie = new SimpleCookie();
                    simpleCookie.setName("PASSWORD");
                    simpleCookie.setValue(p.getPassword()+p.getUsername());
                    //3.设置cookie时候
                    simpleCookie.setMaxAge(30*24*60*60);
                    //4.回写给浏览器
                    simpleCookie.saveTo(request,response);
                }else {
                    Cookie[] cookies = request.getCookies();
                    //System.out.println(cookies);
                    if(cookies!=null){
                        for (Cookie c: cookies ) {
                            if(c.getName().equals("USERNAME")){
                                //System.out.println(222);
                                //servlet 如何删除Cookie ,将时间设置为0 并返回给浏览器
                                /*c.setMaxAge(0);
                                response.addCookie(c);*/
                                SimpleCookie sc = new SimpleCookie();
                                sc.setName("USERNAME");
                                sc.setValue("");
                                sc.setMaxAge(30);
                                sc.saveTo(request, response);
                            }
                            if(c.getName().equals("PASSWORD")){
                                SimpleCookie sc = new SimpleCookie();
                                sc.setName("PASSWORD");
                                sc.setValue("");
                                sc.setMaxAge(30);
                                sc.saveTo(request, response);
                            }
                        }
                    }
                }
                return "success";
            }catch (AuthenticationException e){
                //登录失败
                return "ERROR";
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    //查询是否有所需要的cookie
    public User queryCookie(HttpServletRequest request) {

        User p = new User();
        p.setUsername("");
        //得到所有的cookie
        // System.out.println(5555);
        Cookie[] cookies = request.getCookies();
        System.out.println(cookies);
        //System.out.println(cookies);
        if(cookies!=null){
            String se="";
            for (Cookie c: cookies ) {
                if(c.getName().equals("USERNAME")){
                    p.setUsername(c.getValue());
                }
                if(c.getName().equals("PASSWORD")){
                  se=  c.getValue();

                }

            }
            p.setPassword(se.replace(p.getUsername(),""));
            return p;
        }

        p.setUsername("");
        return p;
    }

    public boolean insert(User user) {
        //加密测试代码
        //设置加密方式
        String algorithmName="MD5";
        //设置待加密的原密码
        Object source=user.getPassword();
        //设置加盐方式(一般来说都是以用户名来加盐)
        Object salt= ByteSource.Util.bytes(user.getUsername());
        //加密次数
        int hashIterations=1024;
        SimpleHash newPassword=new SimpleHash(algorithmName, source, salt, hashIterations);

        user.setPassword(newPassword.toString());
        if(userMapper.queryPersonByPersonName(user.getUsername())!=null){
            return  false;
        }
        if(userMapper.insertSelective(user)>0){
            return true;
        }
        return false;
    }


    public boolean sendEmail(String email) {
        SimpleMailMessage message = new SimpleMailMessage();
        //定义发送者邮件地址
        message.setFrom(email);
        //定义接受者邮件地址
        message.setTo(email);
        //定义邮件主题，就是邮件标题
        message.setSubject("图书注册验证码：");
        //定义邮件内容
        int x = (int) (Math.random() * 1000);
        message.setText("请确实是否是本人，务必正确" + x);
           Subject subject=SecurityUtils.getSubject();
           subject.getSession().setAttribute("yanz",x);
        try {
            //发送邮件
            mailSender.send(message);
            System.out.println("发送成功");
            return true;
        } catch (Exception e) {
            System.out.println("发送失败");
            e.printStackTrace();
        }
     return false;



    }


    //查询所有用户

    public HashMap<String, Object> queryAllUser(User user) {
        //1.设置每页的查询页码，每页显示的行数
        PageHelper.startPage(user.getPage(),user.getRow());
        //2.查询自定义sql
        List<User> list = userMapper.selectByPage(user);
        //3.转换成分页对象
        PageInfo<User> pageInfo = new PageInfo<User>(list);

        //构建数据类型
        HashMap<String, Object> map = new HashMap<String, Object>();
        //结果集
        map.put("list",pageInfo.getList());
        //总条数
        map.put("count",pageInfo.getTotal());
        //获取上一页
        map.put("prePage",pageInfo.getPrePage());
        //获取下一页
        map.put("nextPage",pageInfo.getNextPage());
        //首页
        map.put("indexPage",pageInfo.getFirstPage());
        //末页
        map.put("endPage",pageInfo.getLastPage());

        map.put("allPage",pageInfo.getPageSize());

        return map;
    }


    public User selectByUsername(String username) {
        return userMapper.selectByUsername(username);
    }


    public int updateByPrimaryKeySelective(User user) {

        //加密测试代码
        //设置加密方式
        String algorithmName="MD5";
        //设置待加密的原密码
        Object source=user.getPassword();
        //设置加盐方式(一般来说都是以用户名来加盐)
        Object salt= ByteSource.Util.bytes(user.getUsername());
        //加密次数
        int hashIterations=1024;
        SimpleHash newPassword=new SimpleHash(algorithmName, source, salt, hashIterations);

        user.setPassword(newPassword.toString());
        return userMapper.updateByPrimaryKeySelective(user);
    }


    public int updateByPrimaryKey(User user) {
        //加密测试代码
        //设置加密方式
        String algorithmName="MD5";
        //设置待加密的原密码
        Object source=user.getPassword();
        //设置加盐方式(一般来说都是以用户名来加盐)
        Object salt= ByteSource.Util.bytes(user.getUsername());
        //加密次数
        int hashIterations=1024;
        SimpleHash newPassword=new SimpleHash(algorithmName, source, salt, hashIterations);

        user.setPassword(newPassword.toString());
        return userMapper.updateByPrimaryKey(user);
    }


    public int delete(int userid) {
        return userMapper.deleteByPrimaryKey(userid);
    }
    //查询男生人数
    public int selectManCount() {
        User user= userMapper.selectManCount();
        return user.getUserid() ;
    }

    //查询男女比例
    public int selectStatistic() {
        User user=userMapper.selectStatistic();
        return user.getUserid() ;
    }

}
