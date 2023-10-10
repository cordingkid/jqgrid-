package egovframework.example.sample.service;

import java.util.List;

public interface TestService3 {

	List<CodeVO> getCommCodeData(CodeVO codeVO);

	List<DetailCodeVO> detailCodeList(DetailCodeVO detailCodeVO);

	String getAutoPrimaryKeyDetailCode(DetailCodeVO detailCodeVO);

	int detailCodeRegistProcess(DetailCodeVO detailCodeVO);

	DetailCodeVO detailCodeInfo(String code);

	int deleteDetailCode(DetailCodeVO detailCodeVO);

	int updateDetailCodeProcess(DetailCodeVO detailCodeVO);

}
