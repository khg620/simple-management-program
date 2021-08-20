package study.crud.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import study.crud.beans.CountryBean;
import study.crud.beans.CustomBean;
import study.crud.mapper.MainMapper;

@Repository
@RequiredArgsConstructor
public class MainDao {
	
	private final MainMapper mainMapper;

	//저장
	public void saveCustomInfo(CustomBean customBean) {
		mainMapper.saveCustomInfo(customBean);
	}
	
	//수정
	public void updateCustomInfo(CustomBean customBean) {
		mainMapper.updateCustomInfo(customBean);
	}
	
	//사업자번호로 조회(수정 시 확인)
	public int checkCustom(CustomBean customBean) {
		return mainMapper.checkCustom(customBean);
	}

	//조회
	public List<CustomBean> searchCustomInfo(CustomBean searchCustomBean) {
		 
		return mainMapper.searchCustomInfo(searchCustomBean);
	}

	//삭제
	public void deleteCustomInfo(String busi_num) {
		
		mainMapper.deleteCustomInfo(busi_num);
	}

	//상세조회
	public CustomBean detailCustomInfo( String busi_num) {
		System.out.println("mapper" + mainMapper.detailCustomInfo(busi_num));
		return mainMapper.detailCustomInfo(busi_num);
	}

	//국가조회
	public List<CountryBean> searchCountry(CountryBean countryBean) {
		return mainMapper.searchCountry(countryBean);
	}

	//계좌 저장
	public void saveAccount(CustomBean saveCustomBean) {
		mainMapper.saveAccount(saveCustomBean);
	}

	//계좌 수정
	public void updateAccount(CustomBean saveCustomBean) {
		mainMapper.updateAccount(saveCustomBean);
	}
}
