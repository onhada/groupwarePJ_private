package com.spring.app.reservation.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.reservation.model.ReservationDAO;

/** 
* @FileName  : ReservationService_imple.java 
* @Project   : TempFinal 
* @Date      : Dec 28, 2023 
* @작성자      : 김민경
* @변경이력    : 
* @프로그램설명    : 트랜잭션 처리를 담당하는 곳, 업무를 처리하는 곳, 비지니스(Business)단
*/
@Service
public class ReservationService_imple implements ReservationService {

	@Autowired
	private ReservationDAO dao;

	
	
	// === 자원카테고리 목록 가져오기 === //
	@Override
	public List<Map<String, String>> getResourceCategoryList() {
		List<Map<String, String>> resourceCategoryList =  dao.getResourceCategoryList();
		return resourceCategoryList;
	}
	
	
	// === 자원 목록 가져오기 === //
	@Override
	public List<Map<String, String>> getResourceList(Map<String, Object> paraMap) {
		List<Map<String, String>> resourceList =  dao.getResourceList(paraMap);
		return resourceList;
	}


	// === 자원카테고리 정보 가져오기 === //
	@Override
	public Map<String, Object> getResourceCategoryInfo(Map<String, Object> paraMap) {
		Map<String, Object> resourceCategoryInfo_map = dao.getResourceCategoryInfo(paraMap);
		return resourceCategoryInfo_map;
	}
	
}
