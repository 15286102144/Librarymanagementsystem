package com.group.dao;

import com.group.pojo.Evaluation;

import java.util.List;

public interface EvaluationMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Evaluation record);

    int insertSelective(Evaluation record);

    Evaluation selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Evaluation record);

    int updateByPrimaryKey(Evaluation record);
    List<Evaluation> selectByuserid(Integer userid);

    List<Evaluation> selectby();

}