package com.group.dao;

import com.group.pojo.User;

import java.util.List;

public interface UserMapper {
    int deleteByPrimaryKey(Integer userid);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer userid);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    User queryPersonByPersonName(String username);


    int totaldown(Integer userid);

    int totaldowns(Integer count, Integer userid);

    User selectByUsername(String username);

    List<User> selectByPage(User user);
   //查询总人数
    User selectStatistic();
    //查询男生人数
    User selectManCount();
}