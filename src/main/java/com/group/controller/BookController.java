package com.group.controller;

import com.group.dao.EvaluationMapper;
import com.group.pojo.Book;
import com.group.pojo.Borrowbooks;

import com.group.pojo.Evaluation;
import com.group.service.BookService;
import com.group.service.BorrowbooksService;

import com.group.service.EvaluationService;
import com.group.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("book")
public class BookController {
    @Autowired
    BookService service;
    @Autowired
    BorrowbooksService borrowbooksService;
    @Autowired
    UserService userService;
@Autowired
EvaluationService ev;
    @RequestMapping(value = "one.do")
    public String one(MultipartFile  file ,MultipartFile  filee,Book book){
        return "ond";
    }
    @RequestMapping(value = "one1.do")
    public String one1(){

        return "ond";
    }
    //图书页面
    @RequestMapping(value = "Library.do")
    public String Library(Book book, ModelMap map){
        HashMap<String, Object> listMap = service.selectByPage(book);
        map.addAttribute("data", listMap);
        map.addAttribute("bookname", book.getBookname());
        map.addAttribute("author", book.getAuthor());
        map.addAttribute("press", book.getPress());
        map.addAttribute("price", book.getPrice());
        map.addAttribute("bookid", book.getBookid());
        return "book/Library";
    }
    @RequestMapping(value = "Library1.do")
    public String Library1(Book book, ModelMap map){
        HashMap<String, Object> listMap = service.selectByPage(book);
        map.addAttribute("data", listMap);
        map.addAttribute("bookname", book.getBookname());
        map.addAttribute("author", book.getAuthor());
        map.addAttribute("press", book.getPress());
        map.addAttribute("price", book.getPrice());
        map.addAttribute("bookid", book.getBookid());
        return "book/Library1";
    }
    //修改跳转页面
    @RequestMapping(value = "updatePage.do")
    public String updatePage(Book book, ModelMap map){
        if(book!=null) {
            Book listMap = service.selectByid(book.getBookid());
            map.addAttribute("list", listMap);
        }
        return "book/updatePage";
    }
    //修改图书数据
    @RequestMapping(value = "update.do")
    public String update(Book book, ModelMap map){
        int a=  service.updateBiid(book);
        return "redirect:Library.do";
    }
    //删除图书数据
    @RequestMapping(value = "delete.do")
    public String delete(Book book){
        Integer bookid = book.getBookid();
        int a=  service.deleteByid(bookid);
        return "redirect:Library.do";
    }
    //借阅按钮
    @RequestMapping(value ="borrow.ajax",produces = "application/text;charset=utf-8")
    @ResponseBody
    public String borrow(Borrowbooks borrowbooks, HttpServletRequest request){
        Integer userid = (Integer) request.getSession().getAttribute("userId");
        Integer bookid = borrowbooks.getBookid();
        borrowbooks.setUserid(userid);
        Book book = service.selectByid(bookid);
        int a =borrowbooksService.select(userid);
        Borrowbooks s=borrowbooksService.selectbyid(userid,bookid);

        if (s!=null){
            return "你已经借过这本书了！";
        }else if (book.getSum()==0){
            return "这书太抢手了被借光了！！！";
        }else if (a>=5){
            return "你借阅的数量已经超过了个人最高纪录了！！";
        }else {
            borrowbooksService.add(borrowbooks);
            service.update(bookid);
            return "借阅成功";
        }
    }
    //图书详情
    @RequestMapping(value = "view.do")
    public String view(Book book){
        System.out.println("book = " + book);
        return "book/xiyouji";
    }
    //批量删除
    @RequestMapping(value = "delAjax.ajax",produces = "application/text;charset=utf-8")
    @ResponseBody
    public String view(@RequestParam("id") String id ){

        //把字符串转换集合
        List<String> list = Arrays.asList(id.split(","));
        for (String s : list) {
            String m="";
            for (int i = 2; i < s.length()-2; i++) {
                m+=s.charAt(i);
            }
            int bookid=Integer.parseInt(m);
            service.deleteByid(bookid);
        }

        return "删除成功";
    }
    //添加图书跳转页面
    @RequestMapping(value = "addpage.do")
    public String addpa(){
        return "book/addBook";
    }
    //添加图书跳转页面
    @RequestMapping(value = "/book/addbook.do")
    public String addbook(){
        System.out.println("添加");

        return "添加成功";
    }
    //用户评价
    @RequestMapping(value = "evaluation.ajax",produces = "application/text;charset=utf-8")
    @ResponseBody
    public String evaluation(Evaluation evaluation ,HttpServletRequest request){
        Integer userid=(Integer) request.getSession().getAttribute("userId");
        String username=(String ) request.getSession().getAttribute("userName");
        evaluation.setUserid(userid);
        evaluation.setUsername(username);
        int c= ev.insrte(evaluation);
        return "提交成功";
    }
    //用户查看评价
    @RequestMapping(value = "evaluationd.do")
    public String evaup(ModelMap map ,HttpServletRequest request){
        Integer userid=(Integer) request.getSession().getAttribute("userId");
        List<Evaluation> evaluations= ev.selectByuserid(userid);
        for (Evaluation e : evaluations) {
            // 设置日期格式
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String format = simpleDateFormat.format( e.getData());
            map.addAttribute("data",format);
        }
        map.addAttribute("dapt",evaluations);
        return "book/evaluationform";
    }
    //管理员查看评价
    @RequestMapping(value = "evaluationdd.do")
    public String evaudp(ModelMap map){
        List<Evaluation> evaluations= ev.selectBy();
        for (Evaluation e : evaluations) {
            // 设置日期格式
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String format = simpleDateFormat.format( e.getData());
            map.addAttribute("data",format);
        }
        map.addAttribute("dapt",evaluations);
        return "book/evaluationform";
    }
    @RequestMapping(value = "evel.do")
    public String wee(){
        return "book/evaluation";
    }
    //图书借阅超时页面
    @RequestMapping(value = "evaluationform.do")
    public String evaluationform(ModelMap map,HttpServletRequest request) throws ParseException, ParseException {
        Integer userid=(Integer)request.getSession().getAttribute("userId");
        List<Borrowbooks> borrowbooks= borrowbooksService.selectByuserid(userid);
        List<Map> list=new ArrayList<Map>();
        for (Borrowbooks e : borrowbooks) {
            // 设置日期格式
            //算两个日期间隔多少天
            Map<String,Object> amp=new HashMap<String, Object>();
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = new Date();
            String dateString = format.format(date);
            String datastring = format.format(e.getDate());
            Date date1 = format.parse(dateString);
            Date date2 = format.parse(datastring);
            int a = (int) ((date1.getTime() - date2.getTime()) / (1000*3600*24));
            int i=0;
            if (a>=7){
                if (i==0) {
                    amp.put("info","以下图书借阅超时了！！！请做相应操作！");
                    i++;
                }
                //获取图书
                Book book1 = service.selectByid(e.getBookid());
                //获取借书时间
                String dff = format.format( e.getDate());
                //存图书id
                amp.put("bookid",e.getBookid());
                //存用户名
                amp.put("username",request.getSession().getAttribute("userName"));
                //存图书名
                amp.put("bookname",book1.getBookname());
                //存借书表id
                amp.put("id",e.getId());
                //存借书时间
                amp.put("date",dff);
                list.add(amp);
            }
        }
        map.addAttribute("list",list);
        return "book/borrowingform";
    }
    //还书
    @RequestMapping("huanshu.do")
    public String huanshu(Borrowbooks borrowbooks){
        borrowbooks.setState(0);
        Integer bookid = borrowbooks.getBookid();
        service.updateBybookid(bookid);
        int a= borrowbooksService.updateBybookid(borrowbooks);
        return "redirect:evaluationform.do";
    }
    //图书续借
    @RequestMapping("xujie.do")
    public String xujie(Borrowbooks borrowbooks){
        Date date=new Date();
        borrowbooks.setDate(date);
        int a= borrowbooksService.updateBybookid(borrowbooks);
        return "redirect:evaluationform.do";
    }

    /*添加书*/
    @RequestMapping("bookList.do")
    public String bookList(){
        return "book/addBook";
    }

    @RequestMapping(value = "addBook.do",produces = "application/text;charset=utf-8")
    @ResponseBody
    public String addBook( MultipartFile imgFile, MultipartFile document,Book book,HttpServletRequest request){

        //获取服务器地址
        String realpath = request.getSession().getServletContext().getRealPath("/upload");
        //Book book=new Book();
        String img="",document0="";
        try{
//判断file数组不能为空并且长度大于0
            if (document != null && document.getSize()> 0) {
                //循环获取file数组中得文件

                    //保存文件
                    document0 = saveFile(document, realpath);

            }
            if (imgFile != null && imgFile.getSize()> 0) {
                //循环获取file数组中得文件

                    //保存文件
                    img = saveFile(imgFile, realpath);

            }

            book.setPicturepath(img);
            book.setBookpath(document0);

            service.addBook(book);
            return "添加成功";
        }catch (Exception e){
        }
        return "null";
    }

    //保存文件
    private String saveFile(MultipartFile file, String path) {
        // 判断文件是否为空
        String savePath;
        if (!file.isEmpty()) {
            try {
                File filepath = new File(path);
                if (!filepath.exists())
                    filepath.mkdirs();
                // 文件保存路径
                String se=file.getOriginalFilename();

                savePath = path +"/"+se;
                // 转存文件
                System.out.println(savePath);
                file.transferTo(new File(savePath));
                return "/upload/"+se;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "";
    }

    @RequestMapping("statictic.do")
    public String statictic(){
        return "book/statictic";
    }

    @RequestMapping(value = "getStatictic.do",produces = "application/json;charset=utf-8")
    @ResponseBody
    public List<Book> getStatictic(){
        List<Book> mapList=service.getStatistic();
        return mapList;
    }

    @RequestMapping(value = "getStatictic3.do",produces = "application/json;charset=utf-8")
    @ResponseBody
    public List<Book> getStatictic3(){
        List<Book> mapList=service.getStatistic2();
        return mapList;
    }

    @RequestMapping(value = "getStatictic2.do",produces = "application/json;charset=utf-8")
    @ResponseBody
    public HashMap<String ,Object> getStatictic2(){

        HashMap<String ,Object> hashMap=new HashMap<String, Object>();
        int i = userService.selectStatistic();
        int i1 = userService.selectManCount();
        //男生比例
        double a=i1/(i*1.0);
        System.err.println(a);
        int c=i-i1;
        double b=c/(i*1.0);
        hashMap.put("NAN",a);
        hashMap.put("NV",b);
        return hashMap;
    }
}
