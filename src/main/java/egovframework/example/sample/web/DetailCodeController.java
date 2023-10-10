package egovframework.example.sample.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.sample.service.ClCodeVO;
import egovframework.example.sample.service.CodeVO;
import egovframework.example.sample.service.DetailCodeVO;
import egovframework.example.sample.service.TestService2;
import egovframework.example.sample.service.TestService3;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class DetailCodeController {

	@Resource(name = "testService3")
	private TestService3 service3;
	
	@Resource(name = "testService2")
	private TestService2 service2;
	
	@RequestMapping("/test3.do")
	public String commCodeList(Model model){
		List<ClCodeVO> clCodeList = service2.getClCodeData();
		model.addAttribute("clCodeList", clCodeList);
		return "sample/test3";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getCommCodeList.do", method = RequestMethod.GET)
	public List<CodeVO> commCodeListAjax(@ModelAttribute CodeVO codeVO){
		return service3.getCommCodeData(codeVO);
	}
	
	@ResponseBody
	@RequestMapping(value = "/detailCodeList.do", method = RequestMethod.GET)
	public List<DetailCodeVO> detailCodeList(@ModelAttribute DetailCodeVO detailCodeVO){
		List<DetailCodeVO> detailCodeList = service3.detailCodeList(detailCodeVO);
		return detailCodeList;
	}
	
	@RequestMapping(value = "/detatilCodeRegist.do", method = RequestMethod.GET)
	public String detailCodeRegistForm(Model model){
		List<ClCodeVO> clCodeList = service2.getClCodeData();
		model.addAttribute("clCodeList", clCodeList);
		return "sample/register3";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getAutoPrimaryKeyDetailCode.do", method = RequestMethod.GET)
	public String getAutoPrimaryKeyDetailCode(@ModelAttribute DetailCodeVO detailCodeVO){
		String autoPk = service3.getAutoPrimaryKeyDetailCode(detailCodeVO);
		return autoPk;
	}
	
	@RequestMapping(value = "/detailCodeRegistProcess.do", method = RequestMethod.POST)
	public String detailCodeRegistProcess(@ModelAttribute DetailCodeVO detailCodeVO,
			RedirectAttributes ra){
		String page = "";
		log.info("상세코드 등록 전달 파라미터 : " + detailCodeVO);
		
		int res = service3.detailCodeRegistProcess(detailCodeVO);
		if (res > 0) {
			page = "redirect:/detailCodeInfo.do?code=" + detailCodeVO.getCode();
			ra.addFlashAttribute("msg", "정상적으로 등록이 완료 되었습니다.");
		}else{
			page = "redirect:/detatilCodeRegist.do";
			ra.addFlashAttribute("detailCodeVO", detailCodeVO);
			ra.addFlashAttribute("error", "서버 에러 다시 시도해주세요.");
		}
		return page;
	}
	
	@RequestMapping(value = "/detailCodeInfo.do")
	public String detailCodeInfo(String code, Model model,
			RedirectAttributes ra){
		String page = "";
		DetailCodeVO detailCodeVO = service3.detailCodeInfo(code);
		if (detailCodeVO != null) {
			log.info("상세코드 상세 데이터 : " + detailCodeVO);
			page = "sample/detail3";
			model.addAttribute("detailCodeVO", detailCodeVO);
		}else{
			page = "redirect:/test3.do";
			ra.addFlashAttribute("noData", "없는 정보 입니다.");
		}
		return page;
	}
	
	@RequestMapping(value = "/deleteDetailCode.do", method = RequestMethod.POST)
	public String deleteDetailCode(@ModelAttribute DetailCodeVO detailCodeVO,
			RedirectAttributes ra){
		String page = "";
		int res = service3.deleteDetailCode(detailCodeVO);
		if (res > 0) {
			page = "redirect:/test3.do";
			ra.addFlashAttribute("msg", "정상적으로 삭제 되었습니다.");
		}else{
			page = "redirect:/detailCodeInfo.do?code=" + detailCodeVO.getCode();
			ra.addFlashAttribute("error", "서버에러 다시 시도해주세요.");
		}
		return page;
	}
	
	@RequestMapping(value = "/updateDetailCodeFrm.do", method = RequestMethod.GET)
	public String updateDetailCodeFrm(String code,
			RedirectAttributes ra, Model model){
		String page = "";
		DetailCodeVO detailCodeVO = service3.detailCodeInfo(code);
		if (detailCodeVO != null) {
			page = "sample/register3";
			model.addAttribute("status", "u");
			model.addAttribute("detailCodeVO", detailCodeVO);
		}else{
			page = "redirect:/test3.do";
			ra.addFlashAttribute("noData", "없는 정보 입니다.");
		}
		return page;
	}
	
	
	@RequestMapping(value = "/updateDetailCodeProcess.do", method = RequestMethod.POST)
	public String updateDetailCodeProcess(@ModelAttribute DetailCodeVO detailCodeVO,
			RedirectAttributes ra){
		String page = "";
		log.info("수정 상세 코드 데이터 : " + detailCodeVO);
		int res = service3.updateDetailCodeProcess(detailCodeVO);
		if (res > 0) {
			page = "redirect:/detailCodeInfo.do?code=" + detailCodeVO.getCode();
			ra.addFlashAttribute("msg", "정상적으로 변경 되었습니다.");
		}else{
			page = "redirect:/updateDetailCodeFrm.do?code=" + detailCodeVO.getCode();
			ra.addFlashAttribute("msg", "서버 에러 다시 시도해주세요.");
		}
		return page;
	}
}











