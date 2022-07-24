package com.spring.javagreenS_ljs.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserStatusCodeEnum {

	ACTIVE("활동중"),
	SIGNOUT("탈퇴");
	
	private String label;
}
