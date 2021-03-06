package com.zyfz.dao;

import com.zyfz.domain.Article;
import com.zyfz.domain.UserClick;

import java.util.List;

public interface ArticleMapper {

    int deleteByPrimaryKey(Integer id);

    int insert(Article record);

    int insertSelective(Article record);

    Article selectByPrimaryKey(Integer id);

    List<Article> selectAll();

    List<Article> selectAllWithUser();

    List<Article> selectByTitleLike(String key);

    int updateByPrimaryKeySelective(Article record);

    int updateByPrimaryKey(Article record);

    List<Article> selectWithUserInApp(Article record);

    //List<UserClick> getClick(Integer id);
}