package egovframework.example.sample.service.impl;

import java.util.List;
import java.util.Optional;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.common.NullCheck;
import egovframework.example.sample.service.CodeVO;
import egovframework.example.sample.service.DetailCodeVO;
import egovframework.example.sample.service.TestService3;

@Service("testService3")
public class TestService3Impl implements TestService3 {

	@Resource(name = "test3DAO")
	private Test3DAO dao3;
	
	@Override
	public List<CodeVO> getCommCodeData(CodeVO codeVO) {
		return dao3.getCommCodeData(codeVO);
	}
	
	@Override
	public List<DetailCodeVO> detailCodeList(DetailCodeVO detailCodeVO) {
		String nullCheckStr = null;
		
		nullCheckStr = NullCheck.nullCheck(detailCodeVO.getCode());
		detailCodeVO.setCode(nullCheckStr);
		
		nullCheckStr = NullCheck.nullCheck(detailCodeVO.getCode_id());
		detailCodeVO.setCode_id(nullCheckStr);
		
		nullCheckStr = NullCheck.nullCheck(detailCodeVO.getCode_nm());
		detailCodeVO.setCode_nm(nullCheckStr);
		
		return dao3.detailCodeList(detailCodeVO);
	}
	
	@Override
	public String getAutoPrimaryKeyDetailCode(DetailCodeVO detailCodeVO) {
		return dao3.getAutoPrimaryKeyDetailCode(detailCodeVO);
	}
	
	@Override
	public int detailCodeRegistProcess(DetailCodeVO detailCodeVO) {
		return dao3.detailCodeRegistProcess(detailCodeVO);
	}
	
	@Override
	public DetailCodeVO detailCodeInfo(String code) {
		return dao3.detailCodeInfo(code);
	}
	
	@Override
	public int deleteDetailCode(DetailCodeVO detailCodeVO) {
		return dao3.deleteDetailCode(detailCodeVO);
	}
	
	@Override
	public int updateDetailCodeProcess(DetailCodeVO detailCodeVO) {
		return dao3.updateDetailCodeProcess(detailCodeVO);
	}
}
