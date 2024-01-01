<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>




<script type="text/javascript">

$(document).ready(function() {
	
	
	
	

		
	
	// 상단 탭메뉴의 카테고리 선택 표시 
	$(".tab_menu").click(function(e){
	
		var type = $(e.target).parent().attr("id");
		// console.log(type);
	/* 	
		$(e.target).parent().parent().find(".tab_menu").removeClass("on");
		$(e.target).parent().addClass("on");
		 */
		location.href="<%= ctxPath%>/reservation/approvalManageAdmin.gw?type="+type;
		
		
	});
	
	
	

	var type = <%= request.getAttribute("type")%>;
	$(`li#${type}`).addClass("on");
 
	
	
	
})// end of $(document).ready(function(){})-------------------------



// Function Declaration

</script>




<div id="contents" style="left: 276px;">
	<div class="setting_title">
		<h3>승인 관리</h3>
	</div>
	<div class="content_inbox">
		<!-- Contents -->
		<div class="setting_field">
		
			<ul class="tabType1">
				<li class="tab_menu" id="approvalWait">
					<a href="javascript:void(0);">승인대기</a>
				</li>
				<li class="tab_menu" id="approved">
					<a href="javascript:void(0);">승인</a>
				</li>
				<li class="tab_menu" id="approvalReject">
					<a href="javascript:void(0);">반려</a>
				</li>
			</ul>

			<div>
				<div class="content_title">
					<!-- Title -->
					<form id="booking_acknowledge_frm">
						<input type="hidden" name="category_no" value="">
						<input type="hidden" name="resource_no" value="" id="resource_no_hidden">
						<input type="hidden" name="sort_type" value="name" id="sort_type_hidden">
						<input type="hidden" name="sort_asc" value="asc" id="sort_asc_hidden">
						<fieldset>
							<div class="fl pdt_10">
								<div id="ackowledge_btn_list_div">
									<span class="detail_select" style="padding-right: 6px;">
										<label style="margin-left: -10px"><input type="checkbox" id="all_ck" onclick="bookingAcknowledge.setAllCheck();" title="항목 선택"></label>
									</span>
									<span class="detail_select" style="padding-right: 6px;" id="listCnt"></span>
									<span class="detail_select check_not_visible">
										<a href="javascript:void(0)" onclick="bookingCommon.showDropdownList('category_list_ul', bookingAcknowledge.hideDropdownList, false);">
											보기:
											<span id="dropdown_status_text">모두</span>
											<img src="<%= ctxPath%>/resources/image/icon/btn_drop.gif" alt="옵션 드롭다운 메뉴 열기" class="open_drop">
										</a>
									</span>
									<span class="detail_select">
										<a href="javascript:void(0)" class="booking_del_btn hide">삭제</a>
									</span>
								</div>
								<div class="dropdown" style="left: 15px; top: 18px;">
									<ul class="dropdown-menu hide" id="category_list_ul">
										<li id="category_all_li">
											<a href="javascript:void(0)">
												<span class="dropdown_text_name">모두</span>
											</a>
										</li>
										<li no="1982">
											<a href="javascript:void(0)">
												<span class="dropdown_text_name">회의실</span>
												<span class="icon down deg902"></span>
											</a>
										</li>
										<li no="1983">
											<a href="javascript:void(0)">
												<span class="dropdown_text_name">법인 차량</span>
												<span class="icon down deg902"></span>
											</a>
										</li>
										<li no="1985">
											<a href="javascript:void(0)">
												<span class="dropdown_text_name">사내 콘도</span>
												<span class="icon down deg902"></span>
											</a>
										</li>
									</ul>
								</div>
								<div class="dropdown" style="left: 146px; top: 18px;">
									<ul class="dropdown-menu hide" id="resource_list_ul">
										<li cate_no="1982" no="2294">
											<a href="javascript:void(0)">
												<span class="dropdown_text_name">회의실 B2</span>
											</a>
										</li>
										<li cate_no="1982" no="2297">
											<a href="javascript:void(0)">
												<span class="dropdown_text_name">회의실 A1</span>
											</a>
										</li>
										<li cate_no="1982" no="2298">
											<a href="javascript:void(0)">
												<span class="dropdown_text_name">회의실 M5</span>
											</a>
										</li>
										<li cate_no="1983" no="2295">
											<a href="javascript:void(0)">
												<span class="dropdown_text_name">차량(4인)</span>
											</a>
										</li>
										<li cate_no="1983" no="2299">
											<a href="javascript:void(0)">
												<span class="dropdown_text_name">차량(6인)</span>
											</a>
										</li>
										<li cate_no="1985" no="2300">
											<a href="javascript:void(0)">
												<span class="dropdown_text_name">콘도1(제주)</span>
											</a>
										</li>
										<li cate_no="1985" no="2301">
											<a href="javascript:void(0)">
												<span class="dropdown_text_name">콘도2(속초)</span>
											</a>
										</li>
									</ul>
								</div>
							</div>
							<!-- 수정필) 시간되면... 검색 -->
							<!-- <div class="fr" style="display: flex; align-items: center; gap: 10px;">
								<a href="javascript:void(0)" id="btn_search_undo" class="search_bt fl hide" style="margin: 6px 10px 0 0;">
									<span class="sp_menu searchCancel"></span>
									검색 취소
								</a>
								<div class="in-search fl">
									<div class="search">
										<fieldset>
											<input type="text" id="nameSearch" autocomplete="off" maxlength="30" name="txtSearch" value="" placeholder="이름 검색" style="margin-top: 5px;">
											<span class="btn_search">
												<span class="icon src cpointer">
													<em class="blind">검색</em>
												</span>
											</span>
										</fieldset>
									</div>
								</div> -->
								<!-- 수정필) 시간되면... 엑셀다운로드 -->
								<!-- <span>
									<button class="excel-button" type="button" onclick="bookingAcknowledge.excelDownload();">
										<img src="https://static.hiworks.com/hr/svg/xls.svg" alt="download excel">
									</button>
								</span> -->
							</div>
						</fieldset>
					</form>
				</div>
				
				<div class="pdt_20">
					<table class="tableType01 rs-table">
						<colgroup>
							<col width="35">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
							<col width="">
						</colgroup>
						<thead>
							<tr>
								<th scope="col"></th>
								<th scope="col">
									<a href="javascript:void(0);" class="sort booking_sort" sort_type="name">
										요청자
										<span class="icon down" sort_asc="asc"></span>
									</a>
								</th>
								<th scope="col">
									<a href="javascript:void(0);" class="sort booking_sort" sort_type="category">
										카테고리
										<span class="icon down" sort_asc="asc"></span>
									</a>
								</th>
								<th scope="col" width="15%">
									<a href="javascript:void(0);" class="sort booking_sort" sort_type="resource">
										자원
										<span class="icon down" sort_asc="asc"></span>
									</a>
								</th>
								<th scope="col" width="25%">
									<a href="javascript:void(0);" class="sort booking_sort" sort_type="booking_date">
										예약 시간
										<span class="icon down" sort_asc="asc"></span>
									</a>
								</th>
								<c:if test='${requestScope.type != "approvalWait"}'>
								<th scope="col" id="updateTime" type="hidden" class="">
									<a href="javascript:void(0);" class="sort booking_sort" sort_type="approval_date">
										결재 시간
										<span class="icon down" sort_asc="asc"></span>
									</a>
								</th>
								</c:if>
								<th scope="col">설정</th>
							</tr>
						</thead>
						<tbody id="booking_list_tbody">
						
							<c:if test="${not empty requestScope.reservationList || fn:length(requestScope.reservationList) > 0}">
							<c:forEach var="reservationvo" items="${requestScope.reservationList}">
							<tr>
								<td>
									<label for=""><input type="checkbox"></label>
								</td>
								<td>${reservationvo.rsvEmpName} (${reservationvo.rsvEmpEmail})</td>
								<td>${reservationvo.resourceCategoryName}</td>
								<td>${reservationvo.resourceName}</td>
								<td>${reservationvo.rsvStartDayTime} ~ ${reservationvo.rsvEndDayTime}</td>
								<c:if test='${requestScope.type != "approvalWait"}'>
								<td>${reservationvo.approvalDay}</td>
								</c:if>
								<td>
									<button type="button" name="button" class="weakblue booking_acknowledge_btn" onclick="rsvApproveModalOpen()">승인</button>
									<span class="grey_bar">|</span>
									<button type="button" name="button" class="weakblue booking_reject_btn" onclick="rsvRejectModalOpen()">반려</button>
									<span class="grey_bar">|</span>
									<button type="button" name="button" class="weakblue rsv_detail_view_btn" onclick="reservation_info_detail_open('${reservationvo.rsvResourceId}')">상세보기</button>
								</td>
							</tr>
							</c:forEach>
							</c:if>
							<c:if test="${empty requestScope.reservationList || fn:length(requestScope.reservationList) == 0}">
								<tr>
									<td colspan="7" class="center">등록된 예약이 없습니다.</td>
								</tr>
							</c:if>
							
						</tbody>
					</table>
					<!-- 수정필 페이지바 만들 거임 ... ?
					<div style="text-align: center; margin-top: 15px" id="ack_paging">
						<div class="paginate">
							<strong>1</strong>
						</div>
					</div>
					 -->
				</div>
				<div class="pdt_20">
					<p>
						총
						<span id="total_cnt">${requestScope.totalCount}</span> 
						개
					</p>
				</div>
			</div>
			
		</div>
		<!-- Contents End-->
	</div>
	<!-- 예약 리스트 생성 -->

</div>