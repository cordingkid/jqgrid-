package egovframework.example.sample.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.example.sample.ServiceResult;
import egovframework.example.sample.service.ClCodeVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("testDAO")
public class TestDAO extends EgovAbstractDAO{

	public List<ClCodeVO> getClCodeList(ClCodeVO clCodeVO) {
		return (List<ClCodeVO>) list("testDAO.selectClCodeList", clCodeVO);
	}

	public int getTotalCount(String table) {
		return (int) select("testDAO.getTotalCount", table);
	}

	public ClCodeVO getClCodeInfo(String codeId) {
		return (ClCodeVO) select("testDAO.getClCodeInfo", codeId);
	}

	public int saveClCodeData(ClCodeVO clCodeVO) {
		return update("testDAO.saveClCodeData", clCodeVO);
	}

	public int deleteClCodeData(ClCodeVO clCodeVO) {
		return delete("testDAO.deleteClCodeData", clCodeVO);
	}

	public int checkClCode(ClCodeVO clCodeVO) {
		return (int) select("testDAO.checkClCode", clCodeVO);
	}

	public int addClCode(ClCodeVO clCodeVO) {
		return update("testDAO.addClCode", clCodeVO);
	}

}
