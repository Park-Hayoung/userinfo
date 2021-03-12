package com.coreit.service;

import java.util.HashMap;
import java.util.List;

import com.coreit.domain.Criteria;
import com.coreit.domain.SearchVO;
import com.coreit.domain.UserInfoVO;

public interface UserInfoService {

	public List<UserInfoVO> getList();
	
	public List<UserInfoVO> getListWithPaging(Criteria cri);
	
	public List<UserInfoVO> searchList(SearchVO search);
	
	public UserInfoVO getUserInfo(int u_idx);
	
	public int insertUserInfo(UserInfoVO userInfo);
	
	public int updateUserInfo(UserInfoVO userInfo);
	
//	public UserInfoVO parseUserInfoData(HttpServletRequest request, UserInfoVO userInfo);
	
	public int deleteUserInfo(int u_idx);
	
	public int getTotal();
	
	public int getSearchTotal(String keyword);
	
	public List<String> getHobbyList();
	
	public HashMap<String, Boolean> getHobbyMap(String hobby);
}
