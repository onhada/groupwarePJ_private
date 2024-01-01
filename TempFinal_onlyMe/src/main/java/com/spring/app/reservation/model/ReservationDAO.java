package com.spring.app.reservation.model;

import java.util.List;
import java.util.Map;

import com.spring.app.common.domain.EmployeeVO;
import com.spring.app.reservation.domain.ReservationVO;

public interface ReservationDAO {

	/** 
	* @Method Name  : getResourceCategory 
	* @작성일   : Dec 29, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 자원카테고리 목록 가져오기
	* @return 
	*/
	List<Map<String, String>> getResourceCategoryList();
	
	/** 
	* @Method Name  : getResourceList 
	* @작성일   : Dec 29, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 자원 목록 가져오기
	* @param paraMap
	* @return 
	*/
	List<Map<String, String>> getResourceList(Map<String, Object> paraMap);

	/** 
	* @Method Name  : getResourceCategoryInfo_map 
	* @작성일   : Dec 29, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 자원카테고리 정보 가져오기
	* @param paraMap
	* @return 
	*/
	Map<String, Object> getResourceCategoryInfo(Map<String, Object> paraMap);

	/** 
	* @Method Name  : getResourceInfo 
	* @작성일   : Dec 30, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 자원 정보 가져오기
	* @param paraMap
	* @return 
	*/
	Map<String, Object> getResourceInfo(Map<String, Object> paraMap);

	/** 
	* @Method Name  : getAllResourceList 
	* @작성일   : Dec 30, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 모든 자원 목록 가져오기
	* @return 
	*/
	List<Map<String, String>> getAllResourceList();

	/** 
	* @Method Name  : getResourceOption 
	* @작성일   : Dec 30, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 승인여부, 반납필수여부 알아오기
	* @param resourceId
	* @return 
	*/
	Map<String, Object> getResourceOption(String resourceId);

	/** 
	* @Method Name  : selectReservation 
	* @작성일   : Dec 30, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 해당일시에 등록된 예약이 있는지 조회
	* @param paraMap
	* @return 
	*/
	List<Map<String, String>> selectReservation(Map<String, Object> paraMap);

	/** 
	* @Method Name  : addReservation 
	* @작성일   : Dec 30, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 예약하기 (자원예약 table에 insert)
	* @param paraMap 
	*/
	void addReservation(Map<String, Object> paraMap);

	/** 
	* @Method Name  : getReservationList 
	* @작성일   : Dec 31, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 예약 목록 가져오기
	* @param paraMap
	* @return 
	*/
	List<ReservationVO> getReservationList(Map<String, Object> paraMap);

	/** 
	* @Method Name  : getReservationInfoDetail 
	* @작성일   : Dec 31, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 자원예약 한 건에 대한 정보 가져오기
	* @param paraMap
	* @return 
	*/
	ReservationVO getReservationInfoDetail(Map<String, Object> paraMap);

	/** 
	* @Method Name  : getEmpInfo 
	* @작성일   : Dec 31, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 사원 정보 가져오기
	* @param paraMap
	* @return 
	*/
	Map<String, String> getEmpInfo(Map<String, Object> paraMap);

	/** 
	* @Method Name  : delReservation 
	* @작성일   : Dec 31, 2023 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 예약 삭제하기
	* @param paraMap
	* @return 
	*/
	int delReservation(Map<String, Object> paraMap);
	
	/** 
	* @Method Name  : returnRsource 
	* @작성일   : Jan 1, 2024 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 예약 자원 반납하기
	* @param paraMap
	* @return 
	*/
	int returnRsource(Map<String, Object> paraMap);
	
	/** 
	* @Method Name  : isAdmin 
	* @작성일   : Jan 1, 2024 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 로그인 사원이 인사관리자인지 확인
	* @param paraMap
	* @return 
	*/
	String isAdmin(Map<String, Object> paraMap);

	/** 
	* @Method Name  : getTotalCount 
	* @작성일   : Jan 1, 2024 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 총 예약 건수 가져오기
	* @param paraMap
	* @return 
	*/
	int getTotalCount(Map<String, Object> paraMap);

	/** 
	* @Method Name  : rsvApprove 
	* @작성일   : Jan 2, 2024 
	* @작성자   : hada 
	* @변경이력  : 
	* @Method 설명 : 예약 승인하기
	* @param paraMap
	* @return 
	*/
	int rsvApprove(Map<String, Object> paraMap);

}
