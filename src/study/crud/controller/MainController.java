package study.crud.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import study.crud.beans.CountryBean;
import study.crud.beans.CustomBean;
import study.crud.service.MainService;

@Controller
@RequiredArgsConstructor
public class MainController {
	
	private final MainService mainService;

	@GetMapping("main")
	public String main(@ModelAttribute("searchCustomBean") CustomBean searchCustomBean, @ModelAttribute("saveCustomBean") CustomBean saveCustomBean) {
		//System.out.println("확인" + session.getAttribute("searchResult"));
		
		return "main";
	}
	
	@GetMapping("main/result")
	public String main(@ModelAttribute("searchCustomBean") CustomBean searchCustomBean, @ModelAttribute("saveCustomBean") CustomBean saveCustomBean, Model model) {
		boolean result = true; //jsp에서 초기화면과 거래처 조회 화면 분기에 이용(빈 인풋이냐 인풋에 데이터를 출력 하느냐)
		model.addAttribute("result",result);
		return "main";
	}
	
	//거래처 정보 저장
	@PostMapping("custom/save")
	public String save(@ModelAttribute("saveCustomBean") CustomBean saveCustomBean, HttpSession session) {
		saveCustomBean.setBusi_num(saveCustomBean.getBusi_num().trim());
		saveCustomBean.setCountry_eng(saveCustomBean.getCountry_eng().trim());
		saveCustomBean.setCountry_kor(saveCustomBean.getCountry_kor().trim());
		saveCustomBean.setFactory(saveCustomBean.getFactory().trim());
		saveCustomBean.setTrade_bank(saveCustomBean.getTrade_bank().trim());
		saveCustomBean.setAccount_num(saveCustomBean.getAccount_num().trim()); //데이터 타입 CHAR타입이므로 공백처리 필요
		
		System.out.println(saveCustomBean);
		
		if(mainService.checkCustom(saveCustomBean) == 0) { //미등록 사업자번호 -> insert
			mainService.saveCustomInfo(saveCustomBean);		
			mainService.saveAccount(saveCustomBean);
		} else { //기등록 사업자번호 -> update
			mainService.updateCustomInfo(saveCustomBean);
			mainService.updateAccount(saveCustomBean);
		}
		
		session.invalidate(); //저장 후 화면 초기화하기 위해..(이거 안 하면 조회했던 결과가 그대로 남아있어서)
		return "save_success";
	}
	
	//좌측 조회
	@PostMapping("custom/search")
	public String searchCustomInfo(@ModelAttribute("searchCustomBean") CustomBean searchCustomBean, HttpSession session) {
		
		List<CustomBean> list = new ArrayList<CustomBean>();
		list = mainService.searchCustomInfo(searchCustomBean);
		
		//list.forEach(x -> System.out.println(x));
		
		session.setAttribute("list",list);
		
		return "redirect:/main";
	}
	
	//삭제
	@GetMapping("delete_custom")
	public String deleteCustomInfo(@RequestParam("busi_num") String busi_num, HttpSession session) {
		
		mainService.deleteCustomInfo(busi_num);
		session.invalidate();
		return "delete_success";
	}
	
	//더블클릭 시 우측 상세 조회
	@GetMapping("custom/detail")
	@ResponseBody
	public String detailCustomInfo(@RequestParam("busi_num") String busi_num, @ModelAttribute("searchCustomBean") CustomBean searchCustomBean, @ModelAttribute("saveCustomBean") CustomBean saveCustomBean, HttpSession session) {
		searchCustomBean = mainService.detailCustomInfo(busi_num.trim());
		
		//날짜 세팅
		searchCustomBean.setContract_period_s(searchCustomBean.getContract_period_s().substring(0,10));
		searchCustomBean.setContract_period_e(searchCustomBean.getContract_period_e().substring(0,10));
		
		searchCustomBean.setRegi_info_date(searchCustomBean.getRegi_info_date().substring(0, 10)+"T"+searchCustomBean.getRegi_info_date().substring(11));
		searchCustomBean.setModi_info_date(searchCustomBean.getModi_info_date().substring(0, 10)+"T"+searchCustomBean.getModi_info_date().substring(11));
		
		session.setAttribute("searchResult", searchCustomBean); // ** 꼭 세션에 바인딩을 해서 전달을 해야 하나..........
		System.out.println("scb" + busi_num + searchCustomBean);
		return "ok";
	}
	
	//국가조회 (ajax)
	@GetMapping("custom/country")
	public ResponseEntity<List<CountryBean>> searchCountry(HttpServletRequest request) {
		
		CountryBean countryBean = new CountryBean(); 
		countryBean.setCountry_eng(request.getParameter("country_eng_value"));
		countryBean.setCountry_kor(request.getParameter("country_kor_value"));
		
		
		List<CountryBean> list =  mainService.searchCountry(countryBean);
		request.getSession().setAttribute("countryList", list);
		//list.forEach(x -> System.out.println(x));
		ResponseEntity<List<CountryBean>> entity = new ResponseEntity<List<CountryBean>>(list, HttpStatus.OK);
		return entity;
	}
	
	//초기화
	@GetMapping("custom/init")
	public String initCustom(@ModelAttribute("searchCustomBean") CustomBean searchCustomBean, @ModelAttribute("saveCustomBean") CustomBean saveCustomBean, HttpSession session) {
		session.invalidate();
		return "redirect:/main";
	}
}
