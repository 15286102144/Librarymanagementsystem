package com.group.service.impl;

import com.group.dao.EvaluationMapper;
import com.group.pojo.Evaluation;
import com.group.service.EvaluationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EvaluationServiceimpl implements EvaluationService {
    @Autowired
    EvaluationMapper dao;
    public int insrte(Evaluation evaluation) {
        return dao.insertSelective(evaluation);
    }

    public List<Evaluation> selectByuserid(Integer userid) {
        return dao.selectByuserid(userid);
    }

    public List<Evaluation> selectBy() {
        return dao.selectby();
    }


}
