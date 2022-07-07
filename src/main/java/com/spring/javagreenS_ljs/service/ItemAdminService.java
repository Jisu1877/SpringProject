package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_ljs.vo.ItemImageVO;
import com.spring.javagreenS_ljs.vo.ItemVO;

public interface ItemAdminService {

	public void imgCheck(String detail_content);

	public void setItemInsert(ItemVO itemVO, MultipartHttpServletRequest multipart);

	public ArrayList<ItemVO> getItemSearch(String string, String item_name);

	public ArrayList<ItemVO> getItemAllInfor();

}
