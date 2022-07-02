package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import com.spring.javagreenS_ljs.vo.CategoryGroupVO;

public interface AdminService {
	
	//오버로딩
	public ArrayList<CategoryGroupVO> getCategoryGroupInfor();
	
	//오버로딩
	public CategoryGroupVO getCategoryGroupInfor(String category_group_code);
	
	
	public void setCategoryGroup(CategoryGroupVO vo);
	

}
