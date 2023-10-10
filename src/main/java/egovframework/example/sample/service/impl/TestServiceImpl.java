package egovframework.example.sample.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.example.sample.ServiceResult;
import egovframework.example.sample.service.ClCodeVO;
import egovframework.example.sample.service.TestService;

@Service("testService")
public class TestServiceImpl implements TestService {

	@Resource(name = "testDAO")
	private TestDAO dao;
	
	@Override
	public List<ClCodeVO> getClCodeList(ClCodeVO clCodeVO) {
		// 처음 들어왔을때 데이터 null 이라서 변환 nullChange 라는 문자열로 공백으로 변환
		String nullChange = "";
		if (clCodeVO.getCl_code() == null) {
			clCodeVO.setCl_code(nullChange);
		}
		if (clCodeVO.getCl_code_nm() == null) {
			clCodeVO.setCl_code_nm(nullChange);
		}
		List<ClCodeVO> clCodeList = dao.getClCodeList(clCodeVO);
		return clCodeList;
	}
	
	@Override
	public int getTotalCount(String table) {
		return dao.getTotalCount(table);
	}
	
	@Override
	public ClCodeVO getClCodeInfo(String codeId) {
		return dao.getClCodeInfo(codeId);
	}
	
	
	@Override
	public ServiceResult saveClCodeData(ClCodeVO clCodeVO) {
		ServiceResult result = null;
		int resCnt = dao.saveClCodeData(clCodeVO);
		if (resCnt > 0) {
			result = ServiceResult.OK;
		}else{
			result = ServiceResult.FAILED;
		}
		return result;
	}
	
	@Transactional
	@Override
	public ServiceResult deleteClCodeData(ClCodeVO clCodeVO) {
		ServiceResult result = null;
		// 삭제 하기 전에 하위에 있는 데이터들도 삭제 하도록 설정해야함
		int resCnt = dao.deleteClCodeData(clCodeVO);
		if (resCnt > 0) {
			result = ServiceResult.OK;
		}else{
			result = ServiceResult.FAILED;
		}
		return result;
	}
	
	@Override
	public int checkClCode(ClCodeVO clCodeVO) {
		return dao.checkClCode(clCodeVO);
	}
	
	@Override
	public ServiceResult addClCode(ClCodeVO clCodeVO) {
		ServiceResult result = null;
		int resCnt = dao.addClCode(clCodeVO);
		if (resCnt > 0) {
			result = ServiceResult.OK;
		}else{
			result = ServiceResult.FAILED;
		}
		return result;
	}
}
