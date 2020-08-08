package com.group.controller;

import com.group.pojo.Book;
import com.group.pojo.Borrowbooks;
import com.group.service.BookService;
import com.group.service.BorrowbooksService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;

@Controller
@RequestMapping("brrowBook")
public class BorrowbooksController {
    @Autowired
    BorrowbooksService borrowbook;
    @RequestMapping("appraisalsUI")
    public String  appriaisals(HttpServletRequest request, ModelMap map){
        String username=(String)request.getSession().getAttribute("userName");
        List<Borrowbooks> borrowbooks= borrowbook.selectByUsername(username);
        map.addAttribute("borrowbookList",borrowbooks);
        return "book/appraisalsUI";

    }

    @RequestMapping("appraisal")
    @ResponseBody
    public int  appriaisals(Borrowbooks borrowbooks){
        System.out.println(borrowbooks);
        return  borrowbook.updateById(borrowbooks);

    }

    @RequestMapping("selectapraisals")

    public String  selectapraisals(HttpServletRequest request, ModelMap map){
        String username=(String)request.getSession().getAttribute("userName");
        List<Borrowbooks> borrowbooks= borrowbook.selectByUsernameByappraisal(username);
        map.addAttribute("borrowbookList",borrowbooks);
        return "book/selectapraisals";

    }

    @RequestMapping("selectapraisals1")
    public String  selectapraisals1(HttpServletRequest request, ModelMap map){
        String username=(String)request.getSession().getAttribute("userName");
        List<Borrowbooks> borrowbooks= borrowbook.selectByUsernameByappraisal1();
        map.addAttribute("borrowbookList",borrowbooks);
        return "book/selectapraisals";

    }
    @RequestMapping("deleteById")
    public  String deeteByid(int id){
        borrowbook.deleteById(id);
        return "book/selectapraisals";
    }

    //查询所有
    @RequestMapping("selectAllBoorowBooks.do")
    public String queryAllBoorowBooksMessage(ModelMap modelMap, Borrowbooks borrowbooks) {
        HashMap<String, Object> borrowbookMessage_list = borrowbook.queryAllBorrowBooks(borrowbooks);
        modelMap.addAttribute("borrowbookMessage_list", borrowbookMessage_list);
        return "book/borrowBooks";
    }


    @RequestMapping("selectMyBoorowBooks.do")
    public String selectMyBoorowBooksMessage(ModelMap modelMap,HttpServletRequest request) {
        Borrowbooks borrowbooks = new Borrowbooks();
        borrowbooks.setUserid((Integer) request.getSession().getAttribute("userId"));
        HashMap<String, Object> borrowbookMessage_list = borrowbook.queryAllBorrowBooks(borrowbooks);
        modelMap.addAttribute("borrowbookMessage_list", borrowbookMessage_list);
        return "book/myBorrowBooks";
    }

    @RequestMapping("jieshu.do")
    public String jieshu(){
        return "borrowbook/brrowbooklist";
    }

    @RequestMapping("weihuan.do")
    public String weihuan(){
        return "borrowbook/noreturnbook";
    }
    //未归还
    @RequestMapping(value = "/brrowbook.ajax",produces = "application/json;charset=utf-8")
    @ResponseBody
    public HashMap<String,Object> jieshuajax(Borrowbooks borrowbooks){
        HashMap<String, Object> info=borrowbook.selectAllBooks(borrowbooks);

        return info;
    }
    //归还
    @RequestMapping(value = "noreturnbook.ajax",produces = "application/json;charset=utf-8")
    @ResponseBody
    public HashMap<String,Object> noreturnbook(Borrowbooks borrowbooks,String bookname,String author,String press){
        Book book=new Book();
        book.setBookname(bookname);
        book.setAuthor(author);
        book.setPress(press);
//        System.err.println(book);
        borrowbooks.setBook(book);
        HashMap<String, Object> info=borrowbook.selectAllNoReturnBook(borrowbooks);
        info.put("search",book);
        return info;
    }
    //未归还
    @RequestMapping("/returnbook.ajax")
    @ResponseBody
    public int returnbook(Borrowbooks borrowbooks,Integer bookid,Integer userid,Integer bookid2){
        borrowbooks.setId(bookid);
        int info=borrowbook.returnBook(borrowbooks);
        if (info>0){
            //user表减少1
            borrowbook.totaldown(userid);
            //book表增加1
            borrowbook.totalup(bookid2);
        }
        return info;
    }
    //归还
    @RequestMapping("/delete.ajax")
    @ResponseBody
    public int delete(Borrowbooks borrowbooks,Integer bookid){
        borrowbooks.setId(bookid);
        int info=borrowbook.deleteBook(borrowbooks);
        return info;
    }
    //未归还
    @RequestMapping("/returnAllBook.ajax")
    @ResponseBody
    public int returnAllBook(@RequestParam("id") String s, @RequestParam("count") Integer count, @RequestParam("userid")Integer userid, String bookids){

        int info=borrowbook.returnAllBook(Arrays.asList(s.split(",")));
        if (info>0){
            borrowbook.totaldowns(count,userid);
            System.err.println(bookids);
            borrowbook.totalups(Arrays.asList(bookids.split(",")));
        }
        return info;
    }
    //归还
    @RequestMapping("/deleteAllBook.ajax")
    @ResponseBody
    public int deleteAllBook(@RequestParam("id") String s){

        int info=borrowbook.deleteAllBook(Arrays.asList(s.split(",")));
        return info;
    }


}
