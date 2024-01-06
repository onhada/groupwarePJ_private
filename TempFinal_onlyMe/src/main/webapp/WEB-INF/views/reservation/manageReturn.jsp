<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>





<script type="text/javascript">

$(document).ready(function() {
	
	// 상단 탭메뉴에서 선택한 승인상태 카테고리의 목록 보여주기
	$(".type").click(function(e){
		var type = $(e.target).parent().attr("id");		
		location.href="<%= ctxPath%>/reservation/returnManageAdmin.gw?type="+type;
	});
	
	// 상단 탭메뉴의 카테고리 선택 표시 
	var type = <%= request.getAttribute("type")%>;
	$(`li#${type}`).addClass("on");
 
	
	
})// end of $(document).ready(function(){})-------------------------



// Function Declaration

</script>





<div id="contents" style="left: 276px;">
	<div class="setting_title">
		<h3>반납 관리</h3>
	</div>
	<div class="content_inbox">
		<!-- Contents -->
		<div class="setting_field">
			<ul class="tabType1">
				<li class="tab_menu" id="returnWait">
					<a href="javascript:void(0)" class="type">반납대기(<span id="return_cnt">4</span>)</a>
				</li>
				<li class="tab_menu" id="returned">
					<a href="javascript:void(0)" class="type">반납완료</a>
				</li>
			</ul>
			<div class="tab_page">
				<%-- 
				<div class="content_title">
					<!-- Title -->
					<form id="booking_return_frm">
						<fieldset>
							<input type="hidden" name="resource_no" value="" id="resource_no_hidden">
							<input type="hidden" name="sort_type" value="" id="sort_type_hidden">
							<input type="hidden" name="sort_asc" value="" id="sort_asc_hidden">
							<div class="fl pdt_10">
								<div id="return_btn_list_div">
									<span class="detail_select" style="padding-right: 6px;">
										<!-- 
										<label style="margin-left: -10px"><input type="checkbox" id="all_ck" onclick="bookingReturn.setAllCheck();" title="항목 선택"></label>
										<span id="checked_cnt_span" class="check_visible hide" style="padding-right: 20px;">0</span>
										 -->
									</span>
									<span class="detail_select check_not_visible">
										<a href="javascript:void(0)" onclick="bookingCommon.showDropdownList('category_list_ul', bookingReturn.hideDropdownList, false);">
											
											보기:
											<span id="dropdown_status_text">모두</span>
											<img src="<%= ctxPath%>/resources/image/icon/btn_drop.gif" alt="옵션 드롭다운 메뉴 열기" class="open_drop">
											
										</a>
									</span>
									<span class="detail_select check_not_visible">
										<!-- <a href="javascript:void(0)" onclick="bookingReturn.excelDownload();">다운로드</a> -->
									</span>
									<span class="detail_select check_visible hide">
										<a href="javascript:void(0)" class="booking_return_layer_btn return_batch_btn">반납 확인</a>
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
							<!-- 
							<div class="fr">
								<a href="javascript:void(0)" id="btn_search_undo" class="search_bt fl hide" style="margin: 6px 10px 0 0;" onclick="">
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
								</div>
							</div>
							 -->
						</fieldset>
					</form>
				</div>
 				--%>
				<div class="pdt_20">
					<table class="tableType01 rs-table" id="return_list_table">
						<colgroup>
							<col width="35">
							<col width="">
							<col width="">
							<col width="">
							<col width="30%">
							<c:if test='${requestScope.type == "returnWait"}'>
							<col width="">
							</c:if>
						</colgroup>
						<thead>
							<tr>
								<th scope="col"></th>
								<th scope="col">
									<a href="javascript:void(0);" class="sort booking_sort" sort_type="name">
										요청자
										<!-- <span class="icon down" sort_asc="asc"></span> -->
									</a>
								</th>
								<th scope="col">
									<a href="javascript:void(0);" class="sort booking_sort" sort_type="category">
										카테고리
										<!-- <span class="icon down" sort_asc="asc"></span> -->
									</a>
								</th>
								<th scope="col">
									<a href="javascript:void(0);" class="sort booking_sort" sort_type="resource">
										자원
										<!-- <span class="icon down" sort_asc="asc"></span> -->
								</th>
								<th scope="col">
									<a href="javascript:void(0);" class="sort booking_sort" sort_type="booking_date">
										예약 시간
										<!-- <span class="icon down" sort_asc="asc"></span> -->
									</a>
								</th>
								<c:if test='${requestScope.type == "returnWait"}'>
								<th scope="col">설정</th>
								</c:if>
							</tr>
						</thead>
						<tbody id="return_list_tbody">
						
							<c:if test="${not empty requestScope.reservationList || fn:length(requestScope.reservationList) > 0}">
							<c:forEach var="reservationvo" items="${requestScope.reservationList}">
								<tr>
									<td>
										<!-- 
										<label for=""><input type="checkbox" name="" value="19215"></label>
										 -->
									</td>
									<td>${reservationvo.rsvEmpName} (${reservationvo.rsvEmpEmail})</td>
									<td>${reservationvo.resourceCategoryName}</td>
									<td>${reservationvo.resourceName}</td>
									<td>${reservationvo.rsvStartDayTime} ~ ${reservationvo.rsvEndDayTime}</td>
									<c:if test='${requestScope.type == "returnWait"}'>
									<td>
										<button type="button" name="button" class="weakblue booking_return_layer_btn" onclick="returnRsourceModalOpen()">반납</button>
										<span class="grey_bar">|</span>
										<button type="button" name="button" class="weakblue rsv_detail_view_btn" id="${reservationvo.rsvResourceId}" onclick="reservation_info_detail_open(this.id)">상세보기</button>
									</td>
									</c:if>
								</tr>
							</c:forEach>
							</c:if>
							<c:if test="${empty requestScope.reservationList || fn:length(requestScope.reservationList) == 0}">
								<tr>
									<td colspan="6" class="center">반납 대기 리스트가 없습니다.</td>
								</tr>
							</c:if>
							<!-- 
							<tr>
								<td>
									<label for=""><input type="checkbox" name="" value="19215"></label>
								</td>
								<td>김이사(kim)</td>
								<td>법인 차량</td>
								<td>차량(4인)</td>
								<td>2023-12-01 06:30 ~ 2023-12-01 17:00</td>
								<td>
									<button type="button" name="button" class="weakblue booking_return_layer_btn" booking_no="19215">반납 확인</button>
								</td>
							</tr>
							<tr>
								<td>
									<label for=""><input type="checkbox" name="" value="19226"></label>
								</td>
								<td>대표이사(ceo)</td>
								<td>법인 차량</td>
								<td>차량(4인)</td>
								<td>2023-12-01 03:00 ~ 2023-12-01 04:30</td>
								<td>
									<button type="button" name="button" class="weakblue booking_return_layer_btn" booking_no="19226">반납 확인</button>
								</td>
							</tr>
							 -->
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
</div>