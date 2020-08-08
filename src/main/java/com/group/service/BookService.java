package com.group.service;

import com.group.pojo.Book;
import com.group.pojo.Borrowbooks;

import java.util.HashMap;
import java.util.List;

public interface BookService {
    HashMap<String, Object> selectByPage(Book book);

    Book selectByid(int bookid);
    int updateBiid(Book book);

    int deleteByid(Integer bookid);

    void update(Integer book);

    int del(List<String> list);

    int addBook(Book book);

    void updateBybookid(Integer bookid);
    //借阅统计
    List<Book> getStatistic();

    //借阅统计
    List<Book> getStatistic2();
}
