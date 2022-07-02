package com.spring.javagreenS_ljs.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_ljs.vo.CategoryGroupVO;

public interface AdminDAO {

	public CategoryGroupVO getCategoryGroupInfor(@Param("category_group_code") String category_group_code);

	public void setCategoryGroup(@Param("vo") CategoryGroupVO vo);

	public ArrayList<CategoryGroupVO> getCategoryGroupInfor2();

}
