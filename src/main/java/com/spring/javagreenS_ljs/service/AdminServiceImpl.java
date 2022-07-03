package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_ljs.dao.AdminDAO;
import com.spring.javagreenS_ljs.vo.CategoryGroupVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminDAO adminDAO;

	@Override
	public CategoryGroupVO getCategoryGroupInfor(String category_group_code) {
		return adminDAO.getCategoryGroupInfor(category_group_code);
	}

	@Override
	public void setCategoryGroup(CategoryGroupVO vo) {
		adminDAO.setCategoryGroup(vo);
	}

	@Override
	public ArrayList<CategoryGroupVO> getCategoryGroupInfor() {
		return adminDAO.getCategoryGroupInfor2();
	}

	@Override
	public void setCategoryUseNot(int category_group_idx) {
		adminDAO.setCategoryUseNot(category_group_idx);
	}

	@Override
	public void setCategoryLevelSort(int changeLevel, int changeValue) {
		adminDAO.setCategoryLevelSort(changeLevel, changeValue);
	}

	@Override
	public int getCategoryLevel99() {
		return adminDAO.getCategoryLevel99();
	}
}
