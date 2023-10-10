package egovframework.example.sample.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import egovframework.example.common.NullCheck;
import egovframework.example.sample.ServiceResult;
import egovframework.example.sample.service.MenuService;
import egovframework.example.sample.service.T_comtnauthorinfoVO;
import egovframework.example.sample.service.T_comtnmenucreatdtlsVO;
import egovframework.example.sample.service.T_comtnmenuinfoVO;
import egovframework.example.sample.service.T_comtnprogrmlistVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("menuService")
public class MenuServiceImpl implements MenuService {

	@Resource(name = "menuDAO")
	private MenuDAO dao;
	
	@Override
	public List<T_comtnauthorinfoVO> getAuthorInfoList(T_comtnauthorinfoVO t_comtnauthorinfoVO) {
		String nullCheckStr = NullCheck.nullCheck(t_comtnauthorinfoVO.getAuthor_nm());
		t_comtnauthorinfoVO.setAuthor_nm(nullCheckStr);
		return dao.getAuthorInfoList(t_comtnauthorinfoVO);
	}
	
	@Override
	public T_comtnauthorinfoVO showAuthorInfo(String authorCode) {
		return dao.showAuthorInfo(authorCode);
	}
	
	@Override
	public int authorInfoModify(T_comtnauthorinfoVO authorInfoVO) {
		return dao.authorInfoModify(authorInfoVO);
	}
	
	@Override
	public int authorInfoRegist(T_comtnauthorinfoVO authorInfoVO) {
		return dao.authorInfoRegist(authorInfoVO);
	}
	
	@Override
	public int deleteAuthorInfo(T_comtnauthorinfoVO authorInfoVO) {
		return dao.deleteAuthorInfo(authorInfoVO);
	}
	
	@Override
	public List<T_comtnprogrmlistVO> getProgrmList(T_comtnprogrmlistVO progrmVO) {
		String nullCheckStr = NullCheck.nullCheck(progrmVO.getProgrm_korean_nm());
		progrmVO.setProgrm_korean_nm(nullCheckStr);
		return dao.getProgrmList(progrmVO);
	}
	
	@Override
	public T_comtnprogrmlistVO detailProgrmFileInfo(String progrmFileNm) {
		return dao.detailProgrmFileInfo(progrmFileNm);
	}
	
	@Override
	public int progrmFileModify(T_comtnprogrmlistVO progrmVO) {
		return dao.progrmFileModify(progrmVO);
	}
	
	@Override
	public int delProgrmFile(T_comtnprogrmlistVO progrmVO) {
		return dao.delProgrmFile(progrmVO);
	}
	
	@Override
	public int progrmFileRegistProcess(T_comtnprogrmlistVO progrmFileVO) {
		return dao.progrmFileRegistProcess(progrmFileVO);
	}
	
	@Override
	public List<T_comtnmenuinfoVO> getMenuInfoList(T_comtnauthorinfoVO authorInfoVO) {
		// 데이터 가공후 리턴
		return menuInfoTreeProcess(dao.getMenuInfoList(authorInfoVO));
	}
	
	@Override
	public ServiceResult menuSettingProcess(Map<String, Object> menuDataMap) {
		ServiceResult result = null;
		String authorCode = (String) menuDataMap.get("authorCode");
		List<String> nodeData = (List<String>) menuDataMap.get("nodeData");
		
		if (StringUtils.isNotBlank(authorCode) && 
				nodeData != null && 
				nodeData.size() > 0) {
			// 전체 노드 제거후 새로운 노드 추가
			dao.nodeDelete(authorCode);
			for (String nodeId : nodeData) {
				T_comtnmenucreatdtlsVO menuCreatdVO = new T_comtnmenucreatdtlsVO();
				menuCreatdVO.setAuthor_code(authorCode);
				menuCreatdVO.setMenu_no(Integer.parseInt(nodeId));
				menuCreatdVO.setMapng_creat_id("admin");
				int res = dao.menuCreatdProcess(menuCreatdVO);
				if (res > 0) {
					result = ServiceResult.OK;
				}else{
					result = ServiceResult.FAILED;
					break;
				}
			}
		}else{
			result = ServiceResult.FAILED;
		}
		return result;
	}
	
	private List<T_comtnmenuinfoVO> menuInfoTreeProcess(List<T_comtnmenuinfoVO> menuInfoList){
		for (T_comtnmenuinfoVO data : menuInfoList) {
			if (data.getUpper_menu_no() == null) {
				data.setUpper_menu_no(0);
			}
			
			if (data.getProgrm_file_nm().equals("dir")) {
				data.setType("dir");
			}else{
				data.setType("file");
			}
		}
		return menuInfoList;
	}
	
	@Override
	public int deleteMenu(T_comtnmenuinfoVO menuInfoVo) {
		return dao.deleteMenu(menuInfoVo);
	}
	
	@Override
	public int updateMenu(T_comtnmenuinfoVO menuInfoVo) {
		return dao.updateMenu(menuInfoVo);
	}
	
	@Override
	public ServiceResult insertMenu(T_comtnmenuinfoVO menuInfoVo) {
		ServiceResult result = null;
		int cnt = dao.checkMenuNo(menuInfoVo);
		if (cnt > 0) { // 기본키가 있는거임
			result = ServiceResult.EXIST;
		}else{ // 없으면 이제 등록 할수 있음
			if (StringUtils.isBlank(menuInfoVo.getRelate_image_nm())) {
				menuInfoVo.setRelate_image_nm("/");
			}
			if (StringUtils.isBlank(menuInfoVo.getRelate_image_path())) {
				menuInfoVo.setRelate_image_path("/");
			}
			cnt = dao.insertMenu(menuInfoVo);
			result = cnt > 0 ? ServiceResult.OK : ServiceResult.FAILED;
		}
		return result;
	}
	
	@Override
	public List<T_comtnmenuinfoVO> getHeaderMenu(String string) {
		Map<String,Object> hashMap = new HashMap<>();
		hashMap.put("author_code", string);
		hashMap.put("upper_menu_no", 1000000);
		List<T_comtnmenuinfoVO> data = getNode(hashMap);
//		log.info("가공 후 데이터 : " + data);
		return data;
	}
	
	public List<T_comtnmenuinfoVO> getNode(Map<String, Object> hashMap){
		List<T_comtnmenuinfoVO> list = dao.getCreatdMenu2(hashMap);
		if (list != null) {
			for (int i = 0; i < list.size(); i++) {
				T_comtnmenuinfoVO node = list.get(i);
				hashMap.put("upper_menu_no", node.getMenu_no());
				node.setChildren(getNode(hashMap));
			}
		}
		return list;
	}
	
}
