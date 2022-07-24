package com.spring.javagreenS_ljs.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserStatusCodeEnum {

	ACTIVE(9, "활동중"),
	SIGNOUT(0, "탈퇴");
	
	private Integer index;
	private String label;
}
