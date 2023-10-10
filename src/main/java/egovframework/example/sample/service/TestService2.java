package egovframework.example.sample.service;

import java.util.List;

public interface TestService2 {

	List<ClCodeVO> getClCodeData();

	List<CodeVO> commCodeDataList(CodeVO codeVO);

	String getAutoPrimaryKey(CodeVO codeVO);

	int saveCommCode(CodeVO codeVO);

	CodeVO getCommCodeInfo(String codeId);

	int uptCommCode(CodeVO codeVO);

	int delCommCode(CodeVO codeVO);

}
