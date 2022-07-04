package com.spring.javagreenS_ljs.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_ljs.dao.ItemDAO;

@Service
public class ItemAdminServiceImpl implements ItemAdminService {
	
	@Autowired
	ItemDAO itemDAO;
}
