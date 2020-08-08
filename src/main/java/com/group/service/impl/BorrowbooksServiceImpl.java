package com.group.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.group.dao.BookMapper;
import com.group.dao.BorrowbooksMapper;
import com.group.dao.UserMapper;
import com.group.pojo.Borrowbooks;
import com.group.service.BorrowbooksService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class BorrowbooksServiceImpl implements BorrowbooksService {
    @Autowired
    BorrowbooksMapper borrowbooksMapper;

    @Autowired
    UserMapper um;
    @Autowired
    BookMapper bm;

    public List<Borrowbooks> selectByUsername(String username) {

        return     borrowbooksMapper.selectByUsername(username);
    }


    public int updateById(Borrowbooks borrowbooks) {
        return borrowbooksMapper.updateByPrimary(borrowbooks);
    }


    public List<Borrowbooks> selectByUsernameByappraisal(String username) {
        return borrowbooksMapper.selectByUsernameByappraisal( username) ;
    }


    public List<Borrowbooks> selectByUsernameByappraisal1() {
        return borrowbooksMapper.selectByUsernameByappraisal1( ) ;
    }
    public int add(Borrowbooks borrowbooks) {
        return borrowbooksMapper.insertSelective(borrowbooks);
    }

    public int select(Integer userid) {
        return borrowbooksMapper.select(userid);
    }

    public Borrowbooks selectbyid(Integer userid, Integer bookid) {
        return borrowbooksMapper.selectByid(userid,bookid);
    }

    public int deleteById(int id) {
        return borrowbooksMapper.deleteByPrimaryKey(id);
    }

    public Borrowbooks selectByid(Integer bookid) {
        return borrowbooksMapper.selectByPrimaryKey(bookid);
    }

    public HashMap<String,Object> queryAllBorrowBooks(Borrowbooks borrowbooks) {
        //查询所有的借阅信息
        /*分页查询步骤：1、设置分页查询的页码，每页显示的行数
         * 2、访问第三步定义的sql
         * 3、创建分页对象
         * 4、构建数据模型
         */
        PageHelper.startPage(borrowbooks.getPage(),borrowbooks.getRow());
        List<Borrowbooks> borrowbook_list = borrowbooksMapper.queryAllBorrowBooks(borrowbooks);
        PageInfo<Borrowbooks> pageInfo = new PageInfo<Borrowbooks>(borrowbook_list);
        HashMap<String,Object> hashMap = new HashMap<String, Object>();
        //当前页数据
        hashMap.put("list",pageInfo.getList());
        //下一页
        hashMap.put("nextPage",pageInfo.getNextPage());
        //上一页
        hashMap.put("prePage",pageInfo.getPrePage());
        //首页
        hashMap.put("indexPage",pageInfo.getFirstPage());
        //尾页
        hashMap.put("endPage",pageInfo.getLastPage());
        //总页数
        hashMap.put("allPages",pageInfo.getPages());
        //数据总数
        hashMap.put("alltotals",pageInfo.getTotal());
        return hashMap;
    }
    public List<Borrowbooks> selectByuserid(Integer userid) {
        return borrowbooksMapper.selectBtuseid(userid);
    }

    public int updateBybookid(Borrowbooks borrowbooks) {
        return borrowbooksMapper.updateByPrimaryKeySelective(borrowbooks);
    }





    public HashMap<String, Object> selectAllBooks(Borrowbooks s) {
        PageHelper.startPage(s.getPage(),s.getRow());
        //调用sql
        List<Borrowbooks> borrowbooksList=borrowbooksMapper.selectByPage(s.getUserid());
        for (Borrowbooks b:borrowbooksList
        ) {
            System.out.println(b);
        }

        PageInfo<Borrowbooks> pageInfo=new PageInfo<Borrowbooks>(borrowbooksList);

        //构建数据类型
        HashMap<String,Object> map=new HashMap<String,Object>();
        //获取每页类容
        map.put("list",pageInfo.getList());
        //获取总条数
        map.put("count",pageInfo.getTotal());
        //上一页
        map.put("prepage",pageInfo.getPrePage());
        //下一页
        map.put("nextpage",pageInfo.getNextPage());
        //总页数页
        map.put("pages",pageInfo.getPages());
        //首页
        map.put("firstpage",pageInfo.getNavigateFirstPage());
        //尾页
        map.put("endpage",pageInfo.getNavigateLastPage());
        //当前页
        map.put("thispage",s.getPage());

        return map;
    }


    public int returnBook(Borrowbooks borrowbooks) {
        return borrowbooksMapper.updateByPrimaryKeySelective(borrowbooks);
    }


    public int returnAllBook(List<String> asList) {
        return borrowbooksMapper.returnAllBook(asList);
    }


    public HashMap<String, Object> selectAllNoReturnBook(Borrowbooks borrowbooks) {
        PageHelper.startPage(borrowbooks.getPage(),borrowbooks.getRow());
        //调用sql
        List<Borrowbooks> borrowbooksList=borrowbooksMapper.selectAllNoReturnBookByPage(borrowbooks);
        for (Borrowbooks b:borrowbooksList
        ) {
            System.out.println(b);
        }

        PageInfo<Borrowbooks> pageInfo=new PageInfo<Borrowbooks>(borrowbooksList);

        //构建数据类型
        HashMap<String,Object> map=new HashMap<String,Object>();
        //获取每页类容
        map.put("list",pageInfo.getList());
        //获取总条数
        map.put("count",pageInfo.getTotal());
        //上一页
        map.put("prepage",pageInfo.getPrePage());
        //下一页
        map.put("nextpage",pageInfo.getNextPage());
        //总页数页
        map.put("pages",pageInfo.getPages());
        //首页
        map.put("firstpage",pageInfo.getNavigateFirstPage());
        //尾页
        map.put("endpage",pageInfo.getNavigateLastPage());
        //当前页
        map.put("thispage",borrowbooks.getPage());

        return map;
    }


    public int deleteBook(Borrowbooks borrowbooks) {
        return borrowbooksMapper.updateById(borrowbooks.getId());
    }


    public int deleteAllBook(List<String> asList) {
        return borrowbooksMapper.deleteAllBook(asList);
    }





    public int totaldown(Integer userid) {
        return um.totaldown(userid);
    }


    public int totaldowns(Integer count, Integer userid) {
        return um.totaldowns(count,userid);
    }


    public int totalup(Integer bookid) {
        return bm.totalup(bookid);
    }


    public int totalups(List<String> asList) {
        return bm.totalups(asList);
    }




}
