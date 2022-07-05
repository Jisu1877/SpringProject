package com.spring.javagreenS_ljs.service;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_ljs.vo.ItemImageVO;

public interface ItemAdminService {

	public void setItemImage(MultipartHttpServletRequest multipart, ItemImageVO itemImageVO);

}
