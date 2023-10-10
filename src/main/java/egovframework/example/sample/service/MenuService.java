package egovframework.example.sample.service;

import java.util.List;
import java.util.Map;

import egovframework.example.sample.ServiceResult;

public interface MenuService {

	List<T_comtnauthorinfoVO> getAuthorInfoList(T_comtnauthorinfoVO t_comtnauthorinfoVO);

	T_comtnauthorinfoVO showAuthorInfo(String authorCode);

	int authorInfoModify(T_comtnauthorinfoVO authorInfoVO);

	int authorInfoRegist(T_comtnauthorinfoVO authorInfoVO);

	int deleteAuthorInfo(T_comtnauthorinfoVO authorInfoVO);

	List<T_comtnprogrmlistVO> getProgrmList(T_comtnprogrmlistVO progrmVO);

	T_comtnprogrmlistVO detailProgrmFileInfo(String progrmFileNm);

	int progrmFileModify(T_comtnprogrmlistVO progrmVO);

	int delProgrmFile(T_comtnprogrmlistVO progrmVO);

	int progrmFileRegistProcess(T_comtnprogrmlistVO progrmFileVO);

	List<T_comtnmenuinfoVO> getMenuInfoList(T_comtnauthorinfoVO authorInfoVO);

	ServiceResult menuSettingProcess(Map<String, Object> menuDataMap);

	int deleteMenu(T_comtnmenuinfoVO menuInfoVo);

	int updateMenu(T_comtnmenuinfoVO menuInfoVo);

	ServiceResult insertMenu(T_comtnmenuinfoVO menuInfoVo);

	List<T_comtnmenuinfoVO> getHeaderMenu(String string);


}
