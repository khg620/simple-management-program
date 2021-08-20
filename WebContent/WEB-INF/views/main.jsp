<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>거래처 관리</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
* {
	box-sizing: border-box;
	margin: 0;
}

body {
	width: 100%;
}

table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
	text-align: center;
}

th {
	font-weight: 400;
}

#left .label, #right .label, #right .wrap .label {
	min-width: 90px;
	flex: 0 1 0;
}

input[name="busi_num"], input[name="custom"], input[name="shorts"],
	input[name="charge_person"], input[name="contract_period_e"] {
	flex: 1 0 0;
}

#right input[name="busi_num"] {
	margin-right: 5px;
}

input[name="contract_period_s"] {
	flex: 1 0 0;
	width: 85%;
}

#right .group .label {
	width: 90px;
}

input[name="post_num"], input[name="country_eng"], input[name="country_kor"],
	select[name="country_eng"], select[name="country_kor"] {
	margin-right: 5px;
	flex: 1 1 0;
}

input[name="regi_info_man"], input[name="modi_info_man"] {
	margin-right: 5px;
}

#left button {
	margin-left: auto;
	width: 80px;
}

#right button {
	width: 80px;
}

.busi-search-table {
	margin-top: 20px;
}

.busi-search-table table {
	width: 324px;
}

td.left {
	width: 150px;
}

.container {
	width: fit-content;
	margin: auto;
	padding: 30px 20px;
}

.header-title {
	font-size: 24px;
	margin-bottom: 15px;
}

.group {
	display: flex;
	flex-direction: column;
}

.wrap {
	display: flex;
	width: 100%;
	margin-bottom: 5px;
}

.sub-wrap {
	display: flex;
	width: 100%;
	align-items: center;
}

#left {
	margin-top: 35px;
	margin-right: 20px;
}

.busi-search-form {
	width: 324px;
	padding: 20px;
	border: 1px solid black;
}

#right {
	padding: 5px 20px;
}

.right-container {
	padding: 5px 20px;
	border: 1px solid black;
}

#right .top_nav {
	display: flex;
	width: 100%;
	justify-content: flex-end;
}

.row-group {
	display: flex;
}

.account-table {
	width: 100%;
}

.contract {
	display: flex;
	width: 100%;
}

.contract .label {
	width: 90px;
}

.css {
	flex: 1 0 0;
}

.css::after {
	content: "~";
	margin-left: 3px;
	margin-right: 5px;
}
.account-input {
  
}

#factory,
#trade_bank,
#account_num {
	border: none;
	outline: none;
	width: 100%;
	height: 100%;
}
.country-search-list {
	margin-left: 90px;
	margin-bottom: 5px;
	display: flex;
	width :405px;
	max-height: 50px;
	overflow: auto;
}
.country-right,
.country-left {
	padding: 5px;
	width: 50%;
	flex: 1 0 0;
}
.country-right div,
.country-left div {
  border-bottom: 1px solid lightgrey;
}
</style>
</head>

<body>
	<div class="container">
		<header id="head">
			<h1 class="header-title">거래처 관리</h1>
		</header>

		<!--조회-->
		<div class="wrap">
			<section id="left">
				<div class="busi-search-form">
					<form:form action="${root }custom/search" method="post" modelAttribute="searchCustomBean" class="search-form">
						<div class="wrap">
							<form:label path="busi_num" class="label">사업자번호</form:label>
							<form:input type="text" maxlength="12" path="busi_num" />
						</div>
						<div class="wrap">
							<form:label path="custom" class="label">거래처명</form:label>
							<form:input type="text" path="custom" />
						</div>
						<div class="wrap">
							<form:button type="submit">조회</form:button>
						</div>
					</form:form>
				</div>
				<div class="busi-search-table">
					<c:choose>
						<c:when test="${result }">

						</c:when>
						<c:otherwise>
							<table>
								<thead>
									<tr>
										<td class="left">사업자번호</td>
										<td>거래처명</td>
									</tr>
								</thead>
								<tbody>

									<c:forEach var="item" items="${list }">
										<tr>
											<td class="search-result busi_num left">${item.busi_num }</td>
											<td class="search-result">${item.custom }</td>
										</tr>
									</c:forEach>

								</tbody>
							</table>
						</c:otherwise>
					</c:choose>
				</div>
			</section>


			<!--입력-->
			<section id="right">
				<div class="wrap top_nav">
					<div>
						<button type="button" class="search-custom">조회</button>
						<button type="button" class="init-btn">초기화</button>
						<button type="button" class="save-btn">저장</button>
						<button type="button" class="delete-btn">삭제</button>
					</div>
				</div>
				<div class="right-container">
					<form:form action="${root }custom/save" method="post" modelAttribute="saveCustomBean" class="save-form">
						<div class="row-group wrap">
							<div class="wrap">
								<form:label path="busi_num" class="label">사업자번호</form:label>
								<c:choose>
									<c:when test="${result }">
										<form:input type="text" path="busi_num" value="${searchResult.busi_num }" class="busi_num" readonly="true" />
									</c:when>
									<c:otherwise>
										<form:input type="text" path="busi_num" value="${searchResult.busi_num }" class="busi_num" />
									</c:otherwise>
								</c:choose>
							</div>
							<div class="wrap">
								<form:label path="shorts" class="label">약칭</form:label>
								<form:input type="text" path="shorts" value="${searchResult.shorts }" />
							</div>
						</div>

						<div class="wrap">
							<form:label path="custom" class="label">거래처명</form:label>
							<form:input type="text" path="custom" value="${searchResult.custom }" />
						</div>

						<div class="wrap">
							<div class="wrap">
								<form:label path="ceo" class="label">대표자</form:label>
								<form:input type="text" path="ceo" value="${searchResult.ceo }" />
							</div>
							<div class="wrap">
								<form:label path="charge_person" class="label">담당자</form:label>
								<form:input type="text" path="charge_person" value="${searchResult.charge_person }" />
							</div>
						</div>

						<div>
							<div class="wrap">
								<form:label path="busi_condition" class="label">업태</form:label>
								<form:input type="text" path="busi_condition" value="${searchResult.busi_condition }" />
							</div>
							<div class="wrap">
								<form:label path="item" class="label">종목</form:label>
								<form:input type="text" path="item" value="${searchResult.item }" />
							</div>
						</div>

						<div>
							<div class="wrap">
								<form:label path="post_num" class="label">우편번호</form:label>
								<form:input type="text" path="post_num" value="${searchResult.post_num }" />
								<button type="button" class="postSearch">검색</button>
							</div>
							<div id="wrap" style="display: none; border: 1px solid; width: 500px; height: 300px; margin: 5px 0; position: relative">
								<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor: pointer; position: absolute; right: 0px; top: -1px; z-index: 1" onclick="foldDaumPostcode()" alt="접기 버튼">
							</div>
							<div class="wrap">
								<form:label path="addr1" class="label">주소1</form:label>
								<form:input type="text" path="addr1" value="${searchResult.addr1 }" />
							</div>
						</div>

						<div class="wrap">
							<form:label path="addr2" class="label">주소2</form:label>
							<form:input type="text" path="addr2" value="${searchResult.addr2 }" />
						</div>

						<div>
							<div class="wrap">
								<form:label path="tel" class="label">전화번호</form:label>
								<form:input type="tel" path="tel" value="${searchResult.tel }" />
							</div>
							<div class="wrap">
								<form:label path="fax" class="label">팩스번호</form:label>
								<form:input type="fax" path="fax" value="${searchResult.fax }" />
							</div>
						</div>

						<div class="wrap">
							<form:label path="homepage" class="label">홈페이지</form:label>
							<form:input type="text" path="homepage" value="${searchResult.homepage }" />
						</div>

						<div class="row-group">
							<div class="wrap">
								<span class="label">법인여부</span>
								<c:choose>
									<c:when test="${searchResult.co_yn == 'Y' }">
										<form:radiobutton path="co_yn" value="Y" checked="checked" />
										<form:label path="co_yn">법인</form:label>

										<form:radiobutton path="co_yn" value="N" />
										<form:label path="co_yn">개인</form:label>
									</c:when>
									<c:when test="${searchResult.co_yn == 'N' }">
										<form:radiobutton path="co_yn" value="Y" />
										<form:label path="co_yn">법인</form:label>

										<form:radiobutton path="co_yn" value="N" checked="checked" />
										<form:label path="co_yn">개인</form:label>
									</c:when>
									<c:otherwise>
										<form:radiobutton path="co_yn" value="Y" />
										<form:label path="co_yn">법인</form:label>

										<form:radiobutton path="co_yn" value="N" />
										<form:label path="co_yn">개인</form:label>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="wrap">
								<span class="label">해외여부</span>
								<c:choose>
									<c:when test="${searchResult.foreign_yn == 'Y' }">
										<form:radiobutton path="foreign_yn" value="N" />
										<form:label path="foreign_yn">국내</form:label>

										<form:radiobutton path="foreign_yn" value="Y" checked="checked" />
										<form:label path="foreign_yn">해외</form:label>
									</c:when>
									<c:when test="${searchResult.foreign_yn == 'N' }">
										<form:radiobutton path="foreign_yn" value="N" checked="checked" />
										<form:label path="foreign_yn">국내</form:label>

										<form:radiobutton path="foreign_yn" value="Y" />
										<form:label path="foreign_yn">해외</form:label>
									</c:when>
									<c:otherwise>
										<form:radiobutton path="foreign_yn" value="N" />
										<form:label path="foreign_yn">국내</form:label>

										<form:radiobutton path="foreign_yn" value="Y" />
										<form:label path="foreign_yn">해외</form:label>
									</c:otherwise>
								</c:choose>

							</div>
						</div>

						<div>
							<div class="wrap">
								<c:choose>
									<c:when test="${searchResult.tax_yn == 'Y' }">
										<form:label path="tax_yn" class="label">과세구분</form:label>
										<form:select path="tax_yn">
											<form:option value="" disabled="disabled">과세/면세</form:option>
											<form:option value="Y" selected="selected">과세</form:option>
											<form:option value="N">면세</form:option>
										</form:select>
									</c:when>
									<c:when test="${searchResult.tax_yn == 'N' }">
										<form:label path="tax_yn" class="label">과세구분</form:label>
										<form:select path="tax_yn">
											<form:option value="" disabled="disabled">과세/면세</form:option>
											<form:option value="Y">과세</form:option>
											<form:option value="N" selected="selected">면세</form:option>
										</form:select>
									</c:when>
									<c:otherwise>
										<form:label path="tax_yn" class="label">과세구분</form:label>
										<form:select path="tax_yn">
											<form:option value="" selected="selected" disabled="disabled">과세/면세</form:option>
											<form:option value="Y">과세</form:option>
											<form:option value="N">면세</form:option>
										</form:select>
									</c:otherwise>
								</c:choose>

							</div>
							<div class="wrap">
								<span class="label">국가</span>
								<form:input type="text" path="country_eng" class="country-eng-input" value="${searchResult.country_eng }" />
								<form:input type="text" path="country_kor" class="country-kor-input" value="${searchResult.country_kor }" />
								<!--<form:select path="country_eng" class="country-eng-select" style="display:none;"></form:select>
								<form:select path="country_kor" class="country-kor-select" style="display:none;"></form:select>-->
								<form:input path="country_eng" class="country-eng-select" style="display:none;"/>
								<form:input path="country_kor" class="country-kor-select" style="display:none;"/>
								<button type="button" class="country-search-btn">검색</button>
								
							</div>
							<div class="country-search-list">
								<div class="country-left"></div>
								<div class="country-right"></div>
							</div>
						</div>

						<div class="wrap">
							<c:choose>
								<c:when test="${searchResult.special_relation == 'Y' }">
									<div class="sub-wrap">
										<form:label path="special_relation" class="label">특수관계자</form:label>
										<form:checkbox path="special_relation" value="Y" checked="checked" />
									</div>
								</c:when>
								<c:otherwise>
									<div class="sub-wrap">
										<form:label path="special_relation" class="label">특수관계자</form:label>
										<form:checkbox path="special_relation" value="Y" />
									</div>

								</c:otherwise>
							</c:choose>

							<c:choose>
								<c:when test="${searchResult.trade_stop == 'Y' }">
									<div class="sub-wrap">
										<form:label path="trade_stop" class="label">거래중지</form:label>
										<form:checkbox path="trade_stop" value="Y" checked="checked" />
									</div>
								</c:when>
								<c:otherwise>
									<div class="sub-wrap">
										<form:label path="trade_stop" class="label">거래중지</form:label>
										<form:checkbox path="trade_stop" value="Y" />
									</div>
								</c:otherwise>
							</c:choose>
						</div>

						<div class="wrap">
							<div class="contract">
								<span class="label">계약기간</span>
								<div class="css">
									<form:input type="date" path="contract_period_s" value="${searchResult.contract_period_s }" />
								</div>

								<form:input type="date" path="contract_period_e" value="${searchResult.contract_period_e }" />
							</div>
						</div>

						<div class="group">
							<div class="wrap">
								<span class="label">등록정보</span>
								<form:input type="text" path="regi_info_man" value="${searchResult.regi_info_man }" />
								<form:input type="datetime-local" path="regi_info_date" value="${searchResult.regi_info_date }" />
							</div>
							<div class="wrap">
								<span class="label">변경정보</span>
								<form:input type="text" path="modi_info_man" value="${searchResult.modi_info_man }" />
								<form:input type="datetime-local" path="modi_info_date" value="${searchResult.modi_info_date }" />
							</div>
						</div>

						<div>
							<span>거래처계좌정보</span>

							<table class="account-table">
								<thead>
									<tr>
										<th>사무소</th>
										<th>은행</th>
										<th>계좌번호</th>
									</tr>
								</thead>
								<tbody>

									<tr>
										<td class="account-input">
											<form:input path="factory" value="${searchResult.factory }" />
										</td>
										<td class="account-input">
											<form:input path="trade_bank" value="${searchResult.trade_bank }" />
										</td>
										<td class="account-input">
											<form:input path="account_num" value="${searchResult.account_num }" />
										</td>
									</tr>

								</tbody>
							</table>

						</div>
					</form:form>
				</div>
			</section>
		</div>

	</div>

	<script>
	//초기화 버튼
	const init_btn = document.querySelector('.init-btn');
	init_btn.addEventListener('click',() => {
		location.href = "/WishitTest/custom/init";
	});
	
   //더블클릭시 우측 상세조회
   const result = document.querySelectorAll('.search-result');
   result.forEach(x => x.addEventListener('dblclick', (e) => {
	  const busi_num = e.target.parentElement.querySelector('.search-result.busi_num').innerText;
	  const current_custom = e.target.parentElement;
	  current_custom.style.backgroundColor="lightgrey";
	  
	  const search_btn = document.querySelector('.search-custom');
	  search_btn.addEventListener('click', () => {
		  
		  $.ajax({
			  url: "/WishitTest/custom/detail?busi_num="+busi_num,
			  type: "get",
			  success: function(result) {
				  if(result == "ok") {
				  	location.href="/WishitTest/main/result"; //사업자번호 수정을 막는다
				  }					   
			  }
		  })
	  }) 
   }))
   
   //저장
   const form = document.querySelector('#saveCustomBean');
   const save_btn = document.querySelector('.save-btn');
   	save_btn.addEventListener('click',(e) => {
   		form.submit();
   	});
   	
   //삭제
   const del_btn = document.querySelector('.delete-btn');
   
   del_btn.addEventListener('click', () => {
	   const busi_num = document.querySelector('#saveCustomBean .busi_num').value;
	   console.log(busi_num);
   	location.href="/WishitTest/delete_custom?busi_num="+busi_num;
   })
   	
   	
  	//배송 주소 api
   const find_address_btn = document.querySelector('.postSearch');
   var element_wrap = document.getElementById('wrap');
   find_address_btn.addEventListener('click', execDaumPostcode);

   function foldDaumPostcode() {
   	// iframe을 넣은 element를 안보이게 한다.
   	element_wrap.style.display = 'none';
   }

   function execDaumPostcode() {
   	var currentScroll = document.querySelector('#post_num').getBoundingClientRect().top;
   	console.log(currentScroll);
   	new daum.Postcode({
   		oncomplete: function(data) {
   			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

   			// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
   			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
   			var roadAddr = data.roadAddress; // 도로명 주소 변수
   			var extraRoadAddr = ''; // 참고 항목 변수

   			// 법정동명이 있을 경우 추가한다. (법정리는 제외)
   			// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
   			if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
   				extraRoadAddr += data.bname;
   			}
   			// 건물명이 있고, 공동주택일 경우 추가한다.
   			if (data.buildingName !== '' && data.apartment === 'Y') {
   				extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
   			}
   			// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
   			if (extraRoadAddr !== '') {
   				extraRoadAddr = ' (' + extraRoadAddr + ')';
   			}

   			// 우편번호와 주소 정보를 해당 필드에 넣는다.
   			document.querySelector('#post_num').value = data.zonecode;
   			document.querySelector("#addr1").value = roadAddr;
   			document.querySelector("#addr1").value = data.jibunAddress;

   			// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
   			if (roadAddr !== '') {
   				document.querySelector("#addr1").value += extraRoadAddr;
   			} else {
   				document.querySelector("#addr1").value += '';
   			}

   				
   			document.querySelector('#addr2').focus();
   			// iframe을 넣은 element를 안보이게 한다.
   			// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
   			element_wrap.style.display = 'none';

   			// 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
   			window.scrollTo(0,currentScroll);
   			console.log(document.body.scrollBottom);
   		},
   		onresize: function(size) {
   			element_wrap.style.height = size.height + 'px';
   		},
   		width: '100%',
   		height: '100%'
   	}).embed(element_wrap);

   	// iframe을 넣은 element를 보이게 한다.
   	element_wrap.style.display = 'block';
   }

   //국가 검색
   const country_btn = document.querySelector('.country-search-btn');
   const country_eng = document.querySelector('.country-eng-input');
   const country_kor = document.querySelector('.country-kor-input');
   
   let country;
   country_btn.addEventListener('click', () => {
	   
	   const country_eng_value = document.querySelector('.country-eng-select').innerText; 
	   const country_kor_value = document.querySelector('.country-kor-select').value;
	   console.log(country_eng_value)
	   $.ajax({
		   url: "/WishitTest/custom/country?country_eng="+country_eng_value+"country_kor="+country_kor_value,
		   type: "get",
		   async: false,
		   success: function(result) {
			   country = result;
			   //console.log(country);
		   }
	   })
	   
	    //input -> select//
   
   //input을 숨기고 select로 보이기 -> 안 보이게만 하면 서버로 값이 전달돼서 아예 없애야겠다.
   
   country_eng.style.display = 'none';
   country_kor.style.display = 'none';
   
   //input을 지우고 select 삽입
   country_eng.remove();
   country_kor.remove();
   
   
   const country_eng_select = document.querySelector('.country-eng-select');
   country_eng_select.style.display = 'inline-block';
   country_eng_select.style.width = '200px';
   const country_kor_select = document.querySelector('.country-kor-select');
   country_kor_select.style.display = 'inline-block';
   country_kor_select.style.width = '200px';
  
   //서버로부터 받은 데이터를 *select option 태그 안에 넣기
   const country_right = document.querySelector('.country-right');
   const country_left = document.querySelector('.country-left');
   
   let list = Array.from(country);
   for(let i = 0; i < list.length; i++) {
	   //var opt1 = document.createElement('option');
	   var opt1 = document.createElement('div');
	   //opt1.setAttribute('value',list[i].country_eng);
	   opt1.innerText = list[i].country_eng;
	   //country_eng_select.appendChild(opt1);
		country_left.appendChild(opt1);
	   
	   //var opt2 = document.createElement('option');
	   var opt2 = document.createElement('div');
	   //opt2.setAttribute('value',list[i].country_kor);
	   opt2.innerText = list[i].country_kor;
	  // country_kor_select.appendChild(opt2);
	   country_right.appendChild(opt2);
   }
	   return country;
   });
   
   
   //select option 동기화시켜주기
/*   const country_eng_select = document.querySelector('.country-eng-select');
   const country_kor_select = document.querySelector('.country-kor-select');
   country_eng_select.addEventListener('click', () => {
	   //console.log(country_eng_select.options.selectedIndex)
	   
	   if(country_eng_select.options.selectedIndex === 0) {
		   country_kor_select.options.selectedIndex = 0;
	   } else if (country_eng_select.options.selectedIndex === 1) {
		   country_kor_select.options.selectedIndex = 1;
	   } else {
		   country_kor_select.options.selectedIndex = 2;
	   }
   });
   country_kor_select.addEventListener('click', () => {
	   //console.log(country_eng_select.options.selectedIndex)
	   
	   if(country_kor_select.options.selectedIndex === 0) {
		   country_eng_select.options.selectedIndex = 0;
	   } else if (country_kor_select.options.selectedIndex === 1) {
		   country_eng_select.options.selectedIndex = 1;
	   } else {
		   country_eng_select.options.selectedIndex = 2;
	   }
   });
*/   


	//국가 조회 결과 더블 클릭 시 인풋에 값 넣어주기
	const country_right = document.querySelector('.country-right');
   const country_left = document.querySelector('.country-left');
   
	country_right.addEventListener('click', (e) => {
		selectValue(e, 'kor');
	});
	country_left.addEventListener('click', (e) => {
		selectValue(e, 'eng');
	});
	
	const selectValue = (e, s) => {
		const right_sub = document.querySelectorAll('.country-right div');
		const left_sub = document.querySelectorAll('.country-left div');
		   
		//console.log(e.target.innerText)
		//console.log(Array.from(right_sub))
		
		
		if(s === 'kor') {
			console.log(e.target.innerText)
			console.log("test"+Array.from(right_sub).indexOf('대한민국'))
			document.querySelector('.country-kor-select').innerText = e.target.innerText;
			//document.querySelector('.country-eng-select').innerText = left_sub[Array.from(right_sub).indexOf(e.target.innerText)].innerText;
			//console.log(left_sub)
		}
		
		if(s === 'eng') {
			document.querySelector('.country-eng-select').value = e.target.innerText;
			document.querySelector('.country-kor-select').value = right_sub[0].innerText;
		}
	}
 
   //날짜
 
	const regi_date = document.querySelector('#regi_info_date');
	const modi_date = document.querySelector('#modi_info_date');
	   
   //초기화 상태에서는 오늘 날짜를 기본으로 보여준다
	if(regi_date.value == '' && modi_date.value == '') {
	   //toISOString 함수는 UTC 시간 기준 반환 (한국보다 9시간 더해진 시간)
	   //오프셋 변경
	   const offset = new Date().getTimezoneOffset()*60000;
	   regi_date.value = new Date(Date.now() - offset).toISOString().slice(0,-1);
	   modi_date.value = new Date(Date.now() - offset).toISOString().slice(0,-1);
	   
	   regi_date.disabled = true;
	   modi_date.disabled = true;
		   
	 }/*else {
		   regi_date.value = regi_date.value.replace(' ','T'); //의도와 달리 else문을 타야 할 것 같은 상황에서 타지 않는다.. => 서버쪽에서 형식 세팅하기로..
		   console.log(regi_date.value)
	 }*/
   

   </script>
</body>

</html>