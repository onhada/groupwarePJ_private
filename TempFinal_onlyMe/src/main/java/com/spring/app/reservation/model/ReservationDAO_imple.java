package com.spring.app.reservation.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.app.common.domain.EmployeeVO;
import com.spring.app.reservation.domain.ReservationVO;

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


	// === 승인여부, 반납필수여부 알아오기 === //
	@Override
	public Map<String, Object> getResourceOption(String resourceId) {
		Map<String, Object> option_map = sqlsession.selectOne("reservation.getResourceOption", resourceId);
		return option_map;
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

	
	// === 예약 목록 가져오기 === //
	@Override
	public List<ReservationVO> getReservationList(Map<String, Object> paraMap) {
		List<ReservationVO> reservationList = sqlsession.selectList("reservation.getReservationList", paraMap);
		return reservationList;
	}


	// === 자원예약 한 건에 대한 정보 가져오기 === //
	@Override
	public ReservationVO getReservationInfoDetail(Map<String, Object> paraMap) {
		ReservationVO rsvvo = sqlsession.selectOne("reservation.getReservationInfoDetail", paraMap);
		return rsvvo;
	}


	// === 사원 정보 가져오기 === //
	@Override
	public Map<String, String> getEmpInfo(Map<String, Object> paraMap) {
		Map<String, String> empInfo_map = sqlsession.selectOne("reservation.getEmpInfo", paraMap);  
		return empInfo_map;
	}


	// === 예약 삭제하기 === //
	@Override
	public int delReservation(Map<String, Object> paraMap) {
		int result = sqlsession.delete("reservation.delReservation", paraMap);  
		return result;
	}

	
	// === 예약 자원 반납하기 === //
	@Override
	public int returnRsource(Map<String, Object> paraMap) {
		int result = sqlsession.update("reservation.returnRsource", paraMap);  
		return result;
	}
	
	
	// === 로그인 사원이 인사관리자인지 확인 === //
	@Override
	public String isAdmin(Map<String, Object> paraMap) {
		String rsvAdminEmpId = sqlsession.selectOne("reservation.isAdmin", paraMap);
		return rsvAdminEmpId;
	}


	// === 총 예약 건수 가져오기 === //
	@Override
	public int getTotalCount(Map<String, Object> paraMap) {
		int totalCount = sqlsession.selectOne("reservation.getTotalCount", paraMap);
		return totalCount;
	}

	
	// === 예약 승인하기 === //
	@Override
	public int rsvApprove(Map<String, Object> paraMap) {
		int result = sqlsession.update("reservation.rsvApprove", paraMap);  
		return result;
	}
	
	
	
	
	
}
