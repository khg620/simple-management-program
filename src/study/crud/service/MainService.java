package study.crud.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import study.crud.beans.CountryBean;
import study.crud.beans.CustomBean;
import study.crud.dao.MainDao;

@Service
@RequiredArgsConstructor
public class MainService {
	
	private final MainDao mainDao;

	//저장
	public void saveCustomInfo(CustomBean customBean) {
		mainDao.saveCustomInfo(customBean);
	}
	
	//수정
	public void updateCustomInfo(CustomBean customBean) {
		mainDao.updateCustomInfo(customBean);
	}
	
	//사업자번호로 조회(수정 시 확인)
	public int checkCustom(CustomBean customBean) {
		return mainDao.checkCustom(customBean);
	}
	
	//조회
	public List<CustomBean> searchCustomInfo(CustomBean searchCustomBean) {
		
		return mainDao.searchCustomInfo(searchCustomBean);
	}

	//삭제
	public void deleteCustomInfo(String busi_num) {
		mainDao.deleteCustomInfo(busi_num);
	}

	//상세조회
	public CustomBean detailCustomInfo(String busi_num) {
		return mainDao.detailCustomInfo(busi_num);
	}

	//국가 조회
	public List<CountryBean> searchCountry(CountryBean countryBean) {
		return mainDao.searchCountry(countryBean);
	}

	//계좌 저장
	public void saveAccount(CustomBean saveCustomBean) {
		mainDao.saveAccount(saveCustomBean);
	}

	//계좌 수정
	public void updateAccount(CustomBean saveCustomBean) {
		mainDao.updateAccount(saveCustomBean);
	}
	

}
