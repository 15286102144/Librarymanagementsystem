package com.group.service;

import com.group.pojo.Borrowbooks;

import java.util.HashMap;
import java.util.List;

public interface BorrowbooksService {
    List<Borrowbooks> selectByUsername(String username);

    int updateById(Borrowbooks borrowbooks);

    List<Borrowbooks> selectByUsernameByappraisal(String username);
    List<Borrowbooks> selectByUsernameByappraisal1();

    int add(Borrowbooks borrowbooks);

    int select(Integer userid);

    Borrowbooks selectbyid(Integer userid, Integer bookid);

    int deleteById(int id);

    HashMap<String, Object> queryAllBorrowBooks(Borrowbooks borrowbooks);

    List<Borrowbooks> selectByuserid(Integer userid);

    int updateBybookid(Borrowbooks borrowbooks);

    HashMap<String, Object> selectAllBooks(Borrowbooks s);

    int returnBook(Borrowbooks borrowbooks);

    int returnAllBook(List<String> asList);

    HashMap<String, Object> selectAllNoReturnBook(Borrowbooks borrowbooks);

    int deleteBook(Borrowbooks borrowbooks);

    int deleteAllBook(List<String> asList);

    int totaldown(Integer userid);

    int totaldowns(Integer count, Integer userid);

    int totalup(Integer bookid);

    int totalups(List<String> asList);

}
