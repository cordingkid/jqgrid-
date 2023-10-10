package egovframework.example.sample.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.sample.service.ClCodeVO;
import egovframework.example.sample.service.CodeVO;
import egovframework.example.sample.service.TestService2;

@Service("testService2")
public class TestService2Impl implements TestService2 {

	@Resource(name = "test2DAO")
	private Test2DAO dao2;
	
	@Override
	public List<ClCodeVO> getClCodeData() {
		return dao2.getClCodeData();
	}
	
	@Override
	public List<CodeVO> commCodeDataList(CodeVO codeVO) {
		String nullChange = "";
		if (codeVO.getCl_code() == null) {
			codeVO.setCl_code(nullChange);
		}
		if (codeVO.getCode_id() == null) {
			codeVO.setCode_id(nullChange);
		}
		if (codeVO.getCode_id_nm() == null) {
			codeVO.setCode_id_nm(nullChange);
		}
		return dao2.commCodeDataList(codeVO);
	}
	
	@Override
	public String getAutoPrimaryKey(CodeVO codeVO) {
		return dao2.getAutoPrimaryKey(codeVO);
	}
	
	@Override
	public int saveCommCode(CodeVO codeVO) {
		return dao2.saveCommCode(codeVO);
	}
	
	@Override
	public CodeVO getCommCodeInfo(String codeId) {
		return dao2.getCommCodeInfo(codeId);
	}
	
	@Override
	public int uptCommCode(CodeVO codeVO) {
		return dao2.uptCommCode(codeVO);
	}
	
	@Override
	public int delCommCode(CodeVO codeVO) {
		return dao2.delCommCode(codeVO);
	}
	
}
