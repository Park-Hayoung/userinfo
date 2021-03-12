package com.coreit.domain;

import java.util.Date;

import lombok.Data;

@Data
public class UserInfoVO {
	private int u_idx;
	private String u_id;
	private String u_pw;
	private String u_name;
	private String u_birth;
	private String u_gender;
	private String u_email;
	private String u_phone;
	private String u_tel;
	private String u_hobby;
	private String u_edu;
	private String cret_id;
	private String cret_ip;
	private Date cret_date;
	private String modi_id;
	private String modi_ip;
	private Date modi_date;
	private String del_yn;
}
