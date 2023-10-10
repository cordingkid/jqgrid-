package egovframework.example.sample.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.sample.ServiceResult;
import egovframework.example.sample.service.MenuService;
import egovframework.example.sample.service.T_comtnauthorinfoVO;
import egovframework.example.sample.service.T_comtnmenuinfoVO;
import egovframework.example.sample.service.T_comtnprogrmlistVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MenuManagementController {
	
	@Resource(name = "menuService")
	private MenuService menuService;
	
//	@ModelAttribute
//	public void headerData(Model model){
//		List<T_comtnmenuinfoVO> headerMenuList = menuService.getHeaderMenu("999999");
//		log.info("자동으로 도는지 체크" + headerMenuList);
//		model.addAttribute("headerMenuList", headerMenuList);
//	}

	@ResponseBody
	@RequestMapping(value = "/menuTreeList.do", method = RequestMethod.GET)
	public List<T_comtnmenuinfoVO> headerData(){
		List<T_comtnmenuinfoVO> headerMenuList = menuService.getHeaderMenu("999999");
		log.info("자동으로 도는지 체크" + headerMenuList);
		return headerMenuList;
	}

	@RequestMapping(value = "/authManagement.do", method = RequestMethod.GET)
	public String showAuthList(){
		return "menu/authList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getAuthorInfoList.do", method = RequestMethod.GET)
	public List<T_comtnauthorinfoVO> getAuthorInfoList(@ModelAttribute T_comtnauthorinfoVO t_comtnauthorinfoVO){
		List<T_comtnauthorinfoVO> authorInfoList = menuService.getAuthorInfoList(t_comtnauthorinfoVO);
		return authorInfoList;
	}
	
	@RequestMapping(value = "/detailAuthorInfo.do", method = RequestMethod.GET)
	public String showAuthorInfo(String authorCode, Model model,
			RedirectAttributes ra){
		String page = "";
		T_comtnauthorinfoVO authorInfoVO = menuService.showAuthorInfo(authorCode);
		if (authorInfoVO != null) {
			page = "menu/detailAuthorInfo";
			model.addAttribute("authorInfoVO", authorInfoVO);
		}else{
			page = "redirect:/authManagement.do";
			ra.addFlashAttribute("msg", "존재하지 않는 정보 입니다.");
		}
		log.info("권한 코드 : " + authorCode);
		return page;
	}
	
	@RequestMapping(value = "/authorInfoModify.do", method = RequestMethod.POST)
	public String authorInfoModify(@ModelAttribute T_comtnauthorinfoVO authorInfoVO,
			RedirectAttributes ra){
		String page = "";
		log.info("권한 상세 정보 : " + authorInfoVO);
		int res = menuService.authorInfoModify(authorInfoVO);
		if (res > 0) {
			page = "redirect:/detailAuthorInfo.do?authorCode=" + authorInfoVO.getAuthor_code();
			ra.addFlashAttribute("msg", "정상적으로 수정 되었습니다.");
		}else{
			page = "redirect:/detailAuthorInfo.do?authorCode=" + authorInfoVO.getAuthor_code();
			ra.addFlashAttribute("msg", "서버에러 다시 시도해주세요.");
		}
		return page;
	}
	
	@RequestMapping(value = "/authorInfoRegist.do", method = RequestMethod.GET)
	public String authorInfoRegistFrm(){
		return "menu/regist";
	}
	
	@RequestMapping(value = "/authorInfoRegist.do", method = RequestMethod.POST)
	public String authorInfoRegist(@ModelAttribute T_comtnauthorinfoVO authorInfoVO, 
			RedirectAttributes ra){
		String page = "";
		log.info("등록 권한 정보 : " + authorInfoVO);
		if (StringUtils.isBlank(authorInfoVO.getAuthor_code()) || 
				StringUtils.isBlank(authorInfoVO.getAuthor_nm()) ||
				StringUtils.isBlank(authorInfoVO.getAuthor_creat_de())) {
			// 설명 뺴고 나머지 정보가 하나라도 누락 되면
			page = "redirect:/authorInfoRegist.do";
			ra.addFlashAttribute("authorInfoVO", authorInfoVO);
			ra.addFlashAttribute("msg", "필수입력 사항을 작성해주세요.");
		}else{
			int res = menuService.authorInfoRegist(authorInfoVO);
			if (res > 0) {
				page = "redirect:/detailAuthorInfo.do?authorCode=" 
							+ authorInfoVO.getAuthor_code();
				ra.addFlashAttribute("msg", "등록이 완료되었습니다.");
			}else{
				page = "redirect:/authorInfoRegist.do";
				ra.addFlashAttribute("authorInfoVO", authorInfoVO);
				ra.addFlashAttribute("msg", "Server error!\n다시 시도 해주세요.");
			}
		}
		return page;
	}
	
	@RequestMapping(value = "/deleteAuthorInfo.do", method = RequestMethod.POST)
	public String deleteAuthorInfo(@ModelAttribute T_comtnauthorinfoVO authorInfoVO,
			RedirectAttributes ra){
		String page = "";
		int res = menuService.deleteAuthorInfo(authorInfoVO);
		if (res > 0) {
			page = "redirect:/authManagement.do";
			ra.addFlashAttribute("msg", "정상적으로 삭제 되었습니다.");
		}else{
			page = "redirect:/detailAuthorInfo.do?authorCode=" 
					+ authorInfoVO.getAuthor_code();
			ra.addFlashAttribute("msg", "서버에러 다시 시도해주세요.");
		}
		return page;
	}
	
	@ResponseBody
	@RequestMapping(value = "/authorInfoListDelete.do", method = RequestMethod.DELETE)
	public String authorInfoListDelete(@RequestBody Map<String, Object> delAuthorInfoList) {
		List<String> dataList = (List<String>) delAuthorInfoList.get("list");
		log.info("전달 데이터 : " + dataList);
		String resMsg = "";
		if (dataList.size() != 0) {
			for (String author_code : dataList) {
				T_comtnauthorinfoVO authorInfoVO = new T_comtnauthorinfoVO();
				authorInfoVO.setAuthor_code(author_code);
				int resCnt = menuService.deleteAuthorInfo(authorInfoVO);
				if (resCnt > 0) {
					resMsg = "success";
				}else{
					resMsg = "failed";
					break;
				}
			}
		}else{
			resMsg = "empty";
		}
		return resMsg;
	}
	
	//메뉴 설정 팝업창
	@RequestMapping(value = "/menuSetting.do", method = RequestMethod.GET)
	public String menuSettingPopup(String authorCode,
			Model model){
		log.info("authorCode : " + authorCode);
		model.addAttribute("authorCode", authorCode);
		return "menu/menuSetting";
	}
	//메뉴 설정 팝업창
	
	// 프로그램 관리 =====================
	
	@RequestMapping(value = "/progrmManageList.do", method = RequestMethod.GET)
	public String progrmManageList(){
		return "menu/progrmList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getProgrmList.do", method = RequestMethod.GET)
	public List<T_comtnprogrmlistVO> getProgrmList(@ModelAttribute T_comtnprogrmlistVO progrmVO){
		log.info("프로그램 가져올 데이터 : " + progrmVO.getProgrm_korean_nm());
		return menuService.getProgrmList(progrmVO);
	}
	
	
	@RequestMapping(value = "/detailProgrmFileInfo.do", method = RequestMethod.GET)
	public String detailProgrmFileInfo(String progrmFileNm,
			RedirectAttributes ra, Model model){
		String page = "";
		log.info("프로그램 파일 명 " + progrmFileNm);
		T_comtnprogrmlistVO progrmFileVO = menuService.detailProgrmFileInfo(progrmFileNm);
		if (progrmFileVO != null) {
			page = "menu/detailProgrmFile";
			model.addAttribute("progrmFileVO", progrmFileVO);
		}else{
			page = "redirect:/progrmManageList.do";
			ra.addFlashAttribute("msg", "존재 하지 않는 정보 입니다.");
		}
		return page;
	}
	
	
	@RequestMapping(value = "/progrmFileModify.do", method = RequestMethod.POST)
	public String progrmFileModify(@ModelAttribute T_comtnprogrmlistVO progrmVO,
			RedirectAttributes ra){
		log.info("수정할 데이터 : " + progrmVO);
		int res = menuService.progrmFileModify(progrmVO);
		String page = "redirect:/detailProgrmFileInfo.do?progrmFileNm=" + progrmVO.getProgrm_file_nm();
		if (res <= 0) {
			ra.addFlashAttribute("msg", "서버 에러 다시 시도해 주세요.");
			ra.addFlashAttribute("progrmFileVO", progrmVO);
		}
		return page;
	}
	
	
	@RequestMapping(value = "/delProgrmFile.do", method = RequestMethod.POST)
	public String delProgrmFile(@ModelAttribute T_comtnprogrmlistVO progrmVO,
			RedirectAttributes ra){
		log.info("삭제할 데이터 : " + progrmVO);
		int res = menuService.delProgrmFile(progrmVO);
		String page = "";
		if (res > 0) {
			page = "redirect:/progrmManageList.do";
			ra.addFlashAttribute("msg", "정상적으로 삭제되었습니다.");
		}else{
			page = "redirect:/detailProgrmFileInfo.do?progrmFileNm=" + progrmVO.getProgrm_file_nm();
			ra.addFlashAttribute("msg", "서버 에러 다시 시도해주세요.");
		}
		return page;
	}
	
	
	@RequestMapping(value = "/progrmFileRegist.do", method = RequestMethod.GET)
	public String progrmFileRegist(){
		return "menu/progrmFileRegist";
	}
	
	
	@RequestMapping(value = "/progrmFileRegist.do", method = RequestMethod.POST)
	public String progrmFileRegistProcess(@ModelAttribute T_comtnprogrmlistVO progrmFileVO,
			RedirectAttributes ra){
		log.info("저장할 프로그램 데이터 : " + progrmFileVO);
		int res = menuService.progrmFileRegistProcess(progrmFileVO);
		String page = "";
		if (res > 0) {
			page = "redirect:/detailProgrmFileInfo.do?progrmFileNm=" + progrmFileVO.getProgrm_file_nm();
		}else{
			page = "redirect:/progrmFileRegist.do";
			ra.addFlashAttribute("progrmFileVO", progrmFileVO);
		}
		return page;
	}
	// 프로그램 관리 =====================
	
	// 메뉴 가져오기
	@ResponseBody
	@RequestMapping(value = "/getMenuInfoList.do", method = RequestMethod.GET)
	public List<T_comtnmenuinfoVO> getMenuInfoList(@ModelAttribute T_comtnauthorinfoVO authorInfoVO) {
		log.info("권한 정보 : " + authorInfoVO.getAuthor_code());
		List<T_comtnmenuinfoVO> menuInfoList = menuService.getMenuInfoList(authorInfoVO);
		log.info("menuInfoList : " + menuInfoList);
		return menuInfoList;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/menuSetting.do", method = RequestMethod.POST)
	public String menuSettingProcess(@RequestBody Map<String, Object> menuDataMap) {
		log.info("메뉴 세팅 데이터 정보 : " + menuDataMap);
		ServiceResult result = menuService.menuSettingProcess(menuDataMap);
		String msg = "";
		if (result.equals(ServiceResult.OK)) {
			msg = "success";
		}else{
			msg = "failed";
		}
		return msg;
	}
	
	// 메뉴 리스트관리 페이지
	@RequestMapping(value = "/menuListManagement.do", method = RequestMethod.GET)
	public String menuListManagementPage() {
		return "menu/menuListManagement";
	}
	
	
	@RequestMapping(value = "/prgrmSearch.do", method = RequestMethod.GET)
	public String prgrmSearch() {
		return "menu/prgrmSearch";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getPrgrmList.do", method = RequestMethod.GET)
	public List<T_comtnprogrmlistVO> getPrgrmList(@ModelAttribute T_comtnprogrmlistVO prgrmListVO) {
		return menuService.getProgrmList(prgrmListVO);
	}
	
	
	@RequestMapping(value = "/deleteMenu.do", method = RequestMethod.POST)
	public String deleteMenu(@ModelAttribute T_comtnmenuinfoVO menuInfoVo,
			RedirectAttributes ra) {
		log.info("전달 데이터 : " + menuInfoVo);
		String page = "redirect:/menuListManagement.do";
		if (menuInfoVo.getMenu_no() != 0) {
			int res = menuService.deleteMenu(menuInfoVo);
			if (res > 0) {
				ra.addFlashAttribute("msg", "정상적으로 삭제되었습니다.");
			}else{
				ra.addFlashAttribute("msg", "서버에러입니다 다시 시도해주세요.");
			}
		}else{
			ra.addFlashAttribute("msg", "선택해주세요.");
		}
		return page;
	}
	
	
	@RequestMapping(value = "/updateMenu.do", method = RequestMethod.POST)
	public String updateMenu(@ModelAttribute T_comtnmenuinfoVO menuInfoVo,
			RedirectAttributes ra) {
		log.info("전달 데이터 : " + menuInfoVo);
		String page = "redirect:/menuListManagement.do";
		int res = menuService.updateMenu(menuInfoVo);
		if (res < 1) {
			ra.addFlashAttribute("msg", "서버에러입니다 다시 시도해주세요.");
		}
		return page;
	}
	
	
	@RequestMapping(value = "/insertMenu.do", method = RequestMethod.POST)
	public String insertMenu(@ModelAttribute T_comtnmenuinfoVO menuInfoVo,
			RedirectAttributes ra) {
		log.info("전달 데이터 : " + menuInfoVo);
		String page = "redirect:/menuListManagement.do";
		ServiceResult res = menuService.insertMenu(menuInfoVo);
		if (res.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("msg", "정상적으로 등록 되었습니다.");
		}else if(res.equals(ServiceResult.EXIST)) {
			ra.addFlashAttribute("msg", "이미 존재하는 메뉴 번호 입니다.");
		}else if(res.equals(ServiceResult.FAILED)){
			ra.addFlashAttribute("msg", "서버에러 다시 시도해주세요.");
		}
		return page;
	}
	
	
	@RequestMapping(value = "/menuSearch.do", method = RequestMethod.GET)
	public String menuSearch() {
		return "menu/menuSearch";
	}
	
	
	
}
