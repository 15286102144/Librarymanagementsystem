package com.group.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.group.dao.BookMapper;
import com.group.pojo.Book;
import com.group.pojo.Borrowbooks;
import com.group.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class BookServiceImpl implements BookService {
    @Autowired
    BookMapper dao;
    public HashMap<String, Object> selectByPage(Book book) {
        PageHelper.startPage(book.getPage(), book.getRow());
        //2查询自定义的sql
        List<Book> list = (List<Book>) dao.select(book);
        //3 转换成分页对象
        PageInfo<Book> pageInfo = new PageInfo<Book>(list);
        //构建数据类型
        HashMap<String, Object> map = new HashMap<String, Object>();
        //当前页集合
        map.put("list", pageInfo.getList());
        //总条数
        map.put("count", pageInfo.getTotal());
        //上一页
        map.put("prePage", pageInfo.getPrePage());
        //下一页
        map.put("nextPage", pageInfo.getNextPage());
        //首页
        map.put("indexPage", pageInfo.getFirstPage());
        //尾页
        map.put("endPage", pageInfo.getLastPage());
//        //每页显示数
////        map.put("allPage", pageInfo.getPageSize());
        //总页数
        map.put("pages",pageInfo.getPages());
        return map;
    }

    public Book selectByid(int bookid) {
        return dao.selectByid(bookid);
    }

    public int updateBiid(Book book) {
        return dao.updateByPrimaryKeySelective(book);
    }

    public int deleteByid(Integer bookid) {
        return dao.deleteByPrimaryKey(bookid);
    }

    public void update(Integer book) {
        dao.update(book);
    }

    public int del(List<String> list) {
        return dao.del(list);
    }

    @Override
    public int addBook(Book book) {
      return   dao.insert(book);
    }

    @Override
    public void updateBybookid(Integer bookid) {
        dao.updateByid(bookid);
    }
    public List<Book> getStatistic() {
        return dao.getStatistic();

    }

    public List<Book> getStatistic2() {
        return dao.getStatistic2();
    }
}
