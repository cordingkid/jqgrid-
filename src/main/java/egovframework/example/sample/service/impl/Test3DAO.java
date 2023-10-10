package egovframework.example.sample.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.example.sample.service.CodeVO;
import egovframework.example.sample.service.DetailCodeVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("test3DAO")
public class Test3DAO extends EgovAbstractDAO {

	public List<CodeVO> getCommCodeData(CodeVO codeVO) {
		return (List<CodeVO>) list("test3DAO.getCommCodeData", codeVO);
	}

	public List<DetailCodeVO> detailCodeList(DetailCodeVO detailCodeVO) {
		return (List<DetailCodeVO>) list("test3DAO.detailCodeList", detailCodeVO);
	}

	public String getAutoPrimaryKeyDetailCode(DetailCodeVO detailCodeVO) {
		return (String) select("test3DAO.getAutoPrimaryKeyDetailCode", detailCodeVO);
	}

	public int detailCodeRegistProcess(DetailCodeVO detailCodeVO) {
		return update("test3DAO.detailCodeRegistProcess", detailCodeVO);
	}

	public DetailCodeVO detailCodeInfo(String code) {
		return (DetailCodeVO) select("test3DAO.detailCodeInfo", code);
	}

	public int deleteDetailCode(DetailCodeVO detailCodeVO) {
		return delete("test3DAO.deleteDetailCode", detailCodeVO);
	}

	public int updateDetailCodeProcess(DetailCodeVO detailCodeVO) {
		return update("test3DAO.updateDetailCodeProcess", detailCodeVO);
	}
	
}
