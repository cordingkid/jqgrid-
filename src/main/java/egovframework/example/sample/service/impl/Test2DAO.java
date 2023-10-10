package egovframework.example.sample.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.example.sample.service.ClCodeVO;
import egovframework.example.sample.service.CodeVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("test2DAO")
public class Test2DAO extends EgovAbstractDAO{

	public List<ClCodeVO> getClCodeData() {
		return (List<ClCodeVO>) list("test2DAO.getClCodeData");
	}

	public List<CodeVO> commCodeDataList(CodeVO codeVO) {
		return (List<CodeVO>) list("test2DAO.commCodeDataList", codeVO);
	}

	public String getAutoPrimaryKey(CodeVO codeVO) {
		return (String) select("test2DAO.getAutoPrimaryKeyCmmCode", codeVO);
	}

	public int saveCommCode(CodeVO codeVO) {
		return update("test2DAO.saveCommCode", codeVO);
	}

	public CodeVO getCommCodeInfo(String codeId) {
		return (CodeVO) select("test2DAO.getCommCodeInfo", codeId);
	}

	public int uptCommCode(CodeVO codeVO) {
		return update("test2DAO.uptCommCode", codeVO);
	}

	public int delCommCode(CodeVO codeVO) {
		return delete("test2DAO.delCommCode", codeVO);
	}

}
