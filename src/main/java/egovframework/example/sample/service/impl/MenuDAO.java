package egovframework.example.sample.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.example.sample.service.T_comtnauthorinfoVO;
import egovframework.example.sample.service.T_comtnmenucreatdtlsVO;
import egovframework.example.sample.service.T_comtnmenuinfoVO;
import egovframework.example.sample.service.T_comtnprogrmlistVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("menuDAO")
public class MenuDAO extends EgovAbstractDAO {

	public List<T_comtnauthorinfoVO> getAuthorInfoList(T_comtnauthorinfoVO t_comtnauthorinfoVO) {
		return (List<T_comtnauthorinfoVO>) list("menuDAO.getAuthorInfoList", t_comtnauthorinfoVO);
	}

	public T_comtnauthorinfoVO showAuthorInfo(String authorCode) {
		return (T_comtnauthorinfoVO) select("menuDAO.showAuthorInfo", authorCode);
	}

	public int authorInfoModify(T_comtnauthorinfoVO authorInfoVO) {
		return update("menuDAO.authorInfoModify", authorInfoVO);
	}

	public int authorInfoRegist(T_comtnauthorinfoVO authorInfoVO) {
		return update("menuDAO.authorInfoRegist", authorInfoVO);
	}

	public int deleteAuthorInfo(T_comtnauthorinfoVO authorInfoVO) {
		return delete("menuDAO.deleteAuthorInfo", authorInfoVO);
	}

	public List<T_comtnprogrmlistVO> getProgrmList(T_comtnprogrmlistVO progrmVO) {
		return (List<T_comtnprogrmlistVO>) list("menuDAO.getProgrmList", progrmVO);
	}

	public T_comtnprogrmlistVO detailProgrmFileInfo(String progrmFileNm) {
		return (T_comtnprogrmlistVO) select("menuDAO.detailProgrmFileInfo", progrmFileNm);
	}

	public int progrmFileModify(T_comtnprogrmlistVO progrmVO) {
		return update("menuDAO.progrmFileModify", progrmVO);
	}

	public int delProgrmFile(T_comtnprogrmlistVO progrmVO) {
		return delete("menuDAO.delProgrmFile", progrmVO);
	}

	public int progrmFileRegistProcess(T_comtnprogrmlistVO progrmFileVO) {
		return update("menuDAO.progrmFileRegistProcess", progrmFileVO);
	}

	public List<T_comtnmenuinfoVO> getMenuInfoList(T_comtnauthorinfoVO authorInfoVO) {
		return (List<T_comtnmenuinfoVO>) list("menuDAO.getMenuInfoList", authorInfoVO);
	}

	public void nodeDelete(String authorCode) {
		delete("menuDAO.nodeDelete", authorCode);
	}

	public int menuCreatdProcess(T_comtnmenucreatdtlsVO menuCreatdVO) {
		return update("menuDAO.menuCreatdProcess", menuCreatdVO);
	}

	public int deleteMenu(T_comtnmenuinfoVO menuInfoVo) {
		return delete("menuDAO.deleteMenu", menuInfoVo);
	}

	public int updateMenu(T_comtnmenuinfoVO menuInfoVo) {
		return update("menuDAO.updateMenu", menuInfoVo);
	}

	public int checkMenuNo(T_comtnmenuinfoVO menuInfoVo) {
		return (int) select("menuDAO.checkMenuNo", menuInfoVo);
	}

	public int insertMenu(T_comtnmenuinfoVO menuInfoVo) {
		return update("menuDAO.insertMenu", menuInfoVo);
	}

	public List<T_comtnmenuinfoVO> getCreatdMenu(String string) {
		return (List<T_comtnmenuinfoVO>) list("menuDAO.getCreatdMenu", string);
	}

	public List<T_comtnmenuinfoVO> getCreatdMenu2(Map<String, Object> hashMap) {
		return (List<T_comtnmenuinfoVO>) list("menuDAO.getCreatdMenu2", hashMap);
	}


}
