package com.group.service;

import com.group.pojo.Evaluation;

import java.util.List;

public interface EvaluationService {
    int insrte(Evaluation evaluation);

   List<Evaluation> selectByuserid(Integer userid);

    List<Evaluation> selectBy();
}
