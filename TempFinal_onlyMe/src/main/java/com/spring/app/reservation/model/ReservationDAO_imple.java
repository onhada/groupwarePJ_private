package com.spring.app.reservation.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

/** 
* @FileName  : ReservationDAO_imple.java 
* @Project   : TempFinal 
* @Date      : Dec 28, 2023 
* @작성자      : hada 
* @변경이력    : 
* @프로그램설명    : Repository(DAO) 선언
*/
@Repository
public class ReservationDAO_imple implements ReservationDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;

	
	
	// === 자원카테고리 목록 가져오기 === //
	@Override
	public List<Map<String, String>> getResourceCategoryList() {
		List<Map<String, String>> resourceCategoryList =  sqlsession.selectList("reservation.getResourceCategoryList");
		return resourceCategoryList;
	}
	
	
	// === 자원 목록 가져오기 === //
	@Override
	public List<Map<String, String>> getResourceList(Map<String, Object> paraMap) {
		List<Map<String, String>> resourceList =  sqlsession.selectList("reservation.getResourceList", paraMap);
		return resourceList;
	}


	// === 자원카테고리 정보 가져오기 === //
	@Override
	public Map<String, Object> getResourceCategoryInfo(Map<String, Object> paraMap) {
		Map<String, Object> resourceCategoryInfo_map = sqlsession.selectOne("reservation.getResourceCategoryInfo", paraMap);
		return resourceCategoryInfo_map;
	}


	// === 자원 정보 가져오기 === //
	@Override
	public Map<String, Object> getResourceInfo(Map<String, Object> paraMap) {
		Map<String, Object> resourceInfo_map = sqlsession.selectOne("reservation.getResourceInfo", paraMap);
		return resourceInfo_map;
	}


	// === 모든 자원 목록 가져오기 === //
	@Override
	public List<Map<String, String>> getAllResourceList() {
		List<Map<String, String>> allResourceList =  sqlsession.selectList("reservation.getAllResourceList");
		return allResourceList;
	}


	// === 해당일시에 등록된 예약이 있는지 조회 === //
	@Override
	public List<Map<String, String>> selectReservation(Map<String, Object> paraMap) {
		List<Map<String, String>> existReservationList = sqlsession.selectList("reservation.selectReservation", paraMap);
		return existReservationList;
	}


	// === 예약하기 (자원예약 table에 insert) === //
	@Override
	public void addReservation(Map<String, Object> paraMap) {
		sqlsession.insert("reservation.addReservation", paraMap);
	}


	// === 승인여부, 반납필수여부 알아오기 === //
	@Override
	public Map<String, Object> getResourceOption(String resourceId) {
		Map<String, Object> option_map = sqlsession.selectOne("reservation.getResourceOption", resourceId);
		return option_map;
	}
	
	
	
}
