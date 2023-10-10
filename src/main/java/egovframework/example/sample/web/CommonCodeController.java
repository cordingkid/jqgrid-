package egovframework.example.sample.web;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.sample.service.ClCodeVO;
import egovframework.example.sample.service.CodeVO;
import egovframework.example.sample.service.TestService2;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CommonCodeController {
	
	@Resource(name = "testService2")
	private TestService2 service2;
	
	@RequestMapping("/test2.do")
	public String commCodeList(Model model){
		List<ClCodeVO> clCodeList = service2.getClCodeData();
//		log.info("clCodeList : " + clCodeList);
		model.addAttribute("clCodeList", clCodeList);
		return "sample/test2";
	}
	
	@ResponseBody
	@RequestMapping(value = "/commCodeDataList.do", method = RequestMethod.GET)
	public List<CodeVO> commCodeDataList(@ModelAttribute CodeVO codeVO){
		List<CodeVO> codeList = service2.commCodeDataList(codeVO);
		log.info("데이터 갯수 : " + codeList.size());
		return codeList;
	}
	
	// 등록 폼 보여주기
	@RequestMapping(value = "/addCommCode.do", method = RequestMethod.GET)
	public String showAddCommCodeFrm(Model model){
		List<ClCodeVO> clCodeList = service2.getClCodeData();
		model.addAttribute("clCodeList", clCodeList);
		return "sample/register2";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getAutoPrimaryKey.do", method = RequestMethod.GET)
	public String getAutoPrimaryKey(@ModelAttribute CodeVO codeVO) {
		String autoPk = service2.getAutoPrimaryKey(codeVO);
		return autoPk;
	}
	
	// 등록 프로세스
	@RequestMapping(value = "/saveCommCode.do", method = RequestMethod.POST)
	public String saveCommCode(@ModelAttribute CodeVO codeVO,
			RedirectAttributes ra){
		// 원래는 codeVO 값 검사 해야함 
		String page = "";
		log.info("등록할 공통코드 : " + codeVO);
		
		int res = service2.saveCommCode(codeVO);
		if (res > 0) {
			page = "redirect:/showCommCodeInfo.do?codeId=" + codeVO.getCode_id();
			ra.addFlashAttribute("addSuccessMSg", "코드가 정상적으로 등록 되었습니다.");
		}else{
			ra.addFlashAttribute("error", "서버에러 다시 시도해주세요.");
			page = "redirect:/addCommCode.do";
		}
		return page;
	}
	
	@RequestMapping(value = "/showCommCodeInfo.do", method = RequestMethod.GET)
	public String showCommCodeInfo(String codeId, Model model) {
		CodeVO codeVO = service2.getCommCodeInfo(codeId);
		log.info("조회한 공통코드 : " + codeVO);
		model.addAttribute("codeVO", codeVO);
		return "sample/detail2";
	}
	
	@RequestMapping(value = "/updateCommCodeForm.do", method = RequestMethod.GET)
	public String updateCommCodeForm(String codeId, Model model){
		CodeVO codeVO = service2.getCommCodeInfo(codeId);
		model.addAttribute("status", "u");
		model.addAttribute("codeVO", codeVO);
		return "sample/register2";
	}
	
	@RequestMapping(value = "/uptCommCode.do", method = RequestMethod.POST)
	public String uptCommCode(@ModelAttribute CodeVO codeVO,
			RedirectAttributes ra){
		String page = "";
		int res = service2.uptCommCode(codeVO);
		if (res > 0) {
			page = "redirect:/showCommCodeInfo.do?codeId=" + codeVO.getCode_id();
			ra.addFlashAttribute("addSuccessMSg", "정상적으로 수정 되었습니다.");
		}else{
			page = "redirect:/updateCommCodeForm.do?codeId=" + codeVO.getCode_id();
			ra.addFlashAttribute("error", "서버에러 다시 시도해주세요.");
		}
		return page;
	}
	
	@RequestMapping(value = "/deleteCommCode.do", method = RequestMethod.POST)
	public String delCommCode(@ModelAttribute CodeVO codeVO,
			RedirectAttributes ra) {
		String page = "";
		int res = service2.delCommCode(codeVO);
		if (res > 0) {
			page = "redirect:/test2.do";
			ra.addFlashAttribute("delSuccessMsg", "정상적으로 삭제 되었습니다.");
		}else{
			page = "redirect:/showCommCodeInfo.do?codeId=" + codeVO.getCode_id();
			ra.addFlashAttribute("error", "서버 에러 다시 시도해주세요.");
		}
		return page;
	}
	
}
