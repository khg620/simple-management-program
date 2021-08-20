package study.crud.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Component;

import study.crud.beans.CountryBean;
import study.crud.beans.CustomBean;

@Component
public interface MainMapper {

	@Insert("INSERT INTO CUSTOM ( "
			+ "  BUSI_NUM, "
			+ "  CUSTOM, "
			+ "  SHORTS, "
			+ "  CEO, "
			+ "  CHARGE_PERSON, "
			+ "  BUSI_CONDITION, "
			+ "  ITEM, "
			+ "  POST_NUM, "
			+ "  ADDR1, "
			+ "  ADDR2, "
			+ "  TEL, "
			+ "  FAX, "
			+ "  HOMEPAGE, "
			+ "  CO_YN, "
			+ "  FOREIGN_YN, "
			+ "  TAX_YN, "
			+ "  COUNTRY_ENG, "
			+ "  COUNTRY_KOR, "
			+ "  SPECIAL_RELATION, "
			+ "  TRADE_STOP, "
			+ "  CONTRACT_PERIOD_S, "
			+ "  CONTRACT_PERIOD_E, "
			+ "  REGI_INFO_MAN, "
			+ "  REGI_INFO_DATE, "
			+ "  MODI_INFO_MAN, "
			+ "  MODI_INFO_DATE "
			+ ")  "
			+ "VALUES ( "
			+ "  #{busi_num}, "
			+ "  #{custom}, "
			+ "  #{shorts}, "
			+ "  #{ceo}, "
			+ "  #{charge_person}, "
			+ "  #{busi_condition}, "
			+ "  #{item}, "
			+ "  #{post_num}, "
			+ "  #{addr1}, "
			+ "  #{addr2}, "
			+ "  #{tel}, "
			+ "  #{fax}, "
			+ "  #{homepage}, "
			+ "  #{co_yn}, "
			+ "  #{foreign_yn}, "
			+ "  #{tax_yn}, "
			+ "  #{country_eng}, "
			+ "  #{country_kor}, "
			+ "  #{special_relation}, "
			+ "  #{trade_stop}, "
			+ "  #{contract_period_s}, "
			+ "  #{contract_period_e}, "
			+ "  #{regi_info_man}, "
			+ "  SYSDATE, "
			+ "  #{modi_info_man}, "
			+ "  SYSDATE"
			+ ")")
	void saveCustomInfo(CustomBean customBean);
	
	//사업자번호 중복인지 조회(수정 시 사용)
	@Select("SELECT "
			+ "    COUNT(*)"
			+ "  FROM "
			+ "    CUSTOM "
			+ "  WHERE "
			+ "    TRIM(BUSI_NUM) = #{busi_num}")
	int checkCustom(CustomBean customBean);
	
	//같은 사업자번호일 시 수정 쿼리 실행
	@Update("UPDATE "
			+ "    CUSTOM "
			+ "  SET "
			+ "  	BUSI_NUM = #{busi_num}, "
			+ "  	CUSTOM = #{custom}, "
			+ "  	SHORTS = #{shorts}, "
			+ " 	CEO = #{ceo}, "
			+ "  	CHARGE_PERSON= #{charge_person}, "
			+ "  	BUSI_CONDITION= #{busi_condition}, "
			+ "  	ITEM= #{item}, "
			+ "  	POST_NUM= #{post_num}, "
			+ "  	ADDR1= #{addr1}, "
			+ "  	ADDR2= #{addr2}, "
			+ "  	TEL= #{tel}, "
			+ "  	FAX= #{fax}, "
			+ "  	HOMEPAGE= #{homepage}, "
			+ "  	CO_YN= #{co_yn}, "
			+ "  	FOREIGN_YN= #{foreign_yn}, "
			+ "  	TAX_YN=#{tax_yn}, "
			+ "  	COUNTRY_ENG=#{country_eng}, "
			+ "  	COUNTRY_KOR= #{country_kor}, "
			+ "  	SPECIAL_RELATION=#{special_relation}, "
			+ "  	TRADE_STOP=#{trade_stop}, "
			+ "  	CONTRACT_PERIOD_S=#{contract_period_s}, "
			+ "  	CONTRACT_PERIOD_E=#{contract_period_e}, "
			+ "  	MODI_INFO_MAN=#{modi_info_man}, "
			+ "  	MODI_INFO_DATE= SYSDATE "
			+ "	WHERE "
			+ "  	TRIM(BUSI_NUM) = #{busi_num}")
	void updateCustomInfo(CustomBean customBean);
	
	
	@Delete("DELETE "
			+ "FROM "
			+ "  CUSTOM "
			+ "WHERE "
			+ "  TRIM(BUSI_NUM) = #{busi_num}")
	void deleteCustomInfo(String busi_num); //데이터타입이 char 타입이어서 공백을 채워주거나/ 나는 쿼리문에서 공백 제거하여 비교
	
	//우측 상세조회
	@Select("SELECT  "
			+ "  BUSI_NUM, "
			+ "  CUSTOM, "
			+ "  SHORTS, "
			+ "  CEO, "
			+ "  CHARGE_PERSON, "
			+ "  BUSI_CONDITION, "
			+ "  ITEM, "
			+ "  POST_NUM, "
			+ "  ADDR1, "
			+ "  ADDR2, "
			+ "  TEL, "
			+ "  FAX, "
			+ "  HOMEPAGE, "
			+ "  CO_YN, "
			+ "  FOREIGN_YN, "
			+ "  TAX_YN, "
			+ "  COUNTRY_ENG, "
			+ "  COUNTRY_KOR, "
			+ "  SPECIAL_RELATION, "
			+ "  TRADE_STOP, "
			+ "  CONTRACT_PERIOD_S, "
			+ "  CONTRACT_PERIOD_E, "
			+ "  REGI_INFO_MAN, "
			+ "  REGI_INFO_DATE, "
			+ "  MODI_INFO_MAN, "
			+ "  MODI_INFO_DATE,"
			+ "  FACTORY,"
			+ "  TRADE_BANK,"
			+ "  ACCOUNT_NUM "
			+ "FROM "
			+ "  CUSTOM "
			+ "JOIN "
			+ " ACCOUNT "
			+ "USING (BUSI_NUM) "
			+ "WHERE "
			+ " TRIM(BUSI_NUM) = #{busi_num}"
			)
	CustomBean detailCustomInfo(String busi_num);
	
	//좌측화면 조회
	@Select("SELECT "
			+ "   BUSI_NUM, "
			+ "   CUSTOM"
			+ " FROM "
			+ "   CUSTOM "
			+ " WHERE "
			+ "	  BUSI_NUM LIKE '%'||#{busi_num}||'%' "
			+ "	AND "
			+ "	  CUSTOM LIKE '%'||#{custom}||'%'")
	List<CustomBean> searchCustomInfo(CustomBean searchCustomBean);

	//국가조회
	@Select("SELECT "
			+ "   COUNTRY_ENG, "
			+ "   COUNTRY_KOR "
			+ " FROM "
			+ "   COUNTRY"
			+ " WHERE "
			+ "   COUNTRY_ENG LIKE '%'||#{country_eng}||'%' "
		)
	List<CountryBean> searchCountry(CountryBean countryBean);

	//계좌 저장
	@Insert("INSERT INTO "
			+ "ACCOUNT( "
			+ "  BUSI_NUM, "
			+ "  FACTORY, "
			+ "  TRADE_BANK, "
			+ "  ACCOUNT_NUM "
			+ "  ) "
			+ "VALUES ( "
			+ "  #{busi_num}, "
			+ "  #{factory}, "
			+ "  #{trade_bank}, "
			+ "  #{account_num} "
			+ ")")
	void saveAccount(CustomBean saveCustomBean);

	//계좌 수정
	@Update("UPDATE "
			+ "    ACCOUNT "
			+ "  SET "
			+ "    FACTORY=#{factory}, "
			+ "    TRADE_BANK=#{trade_bank}, "
			+ "    ACCOUNT_NUM=#{account_num} "
			+ "  WHERE "
			+ "    TRIM(BUSI_NUM)=#{busi_num}")
	void updateAccount(CustomBean saveCustomBean);
	
}
