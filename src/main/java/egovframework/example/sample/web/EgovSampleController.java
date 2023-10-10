/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.sample.web;

import java.util.List;

import javax.annotation.Resource;
import javax.jws.WebParam.Mode;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ibatis.common.logging.Log;

import egovframework.example.sample.ServiceResult;
import egovframework.example.sample.TableNameEnum;
import egovframework.example.sample.service.ClCodeVO;
import egovframework.example.sample.service.TestService;

/**
 * @Class Name : EgovSampleController.java
 * @Description : EgovSample Controller Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */

@Controller
public class EgovSampleController {

	@Resource(name = "testService")
	private TestService service;
	
	private Logger log = Logger.getLogger(EgovSampleController.class); 
	
	@RequestMapping("/test.do")
	public String mainPage (Model model){
		String table = TableNameEnum.공통분류코드.getTable();
		int totalCount = service.getTotalCount(table);
		log.info("전체 데이터 갯수  : " + totalCount);
		model.addAttribute("totalCount", totalCount);
		return "sample/main";
	}
	
	// jqGridData 가져오기
	@ResponseBody
	@RequestMapping(value = "/getClCodeData.do", method = RequestMethod.GET)
	public List<ClCodeVO> getClCodeData(@ModelAttribute ClCodeVO clCodeVO){
		log.info("검색시 전달 파라미터 공통분류코드: " + clCodeVO.getCl_code() +" 공통분류코드명 : "+ clCodeVO.getCl_code_nm());
		List<ClCodeVO> clCodeList = service.getClCodeList(clCodeVO);
		log.info("jqGrid return 값 사이즈 : " + clCodeList.size());
		return clCodeList;
	}
	
	@RequestMapping(value = "/detailCode.do", method = RequestMethod.GET)
	public String showDetailForm(String codeId, 
			Model model,
			RedirectAttributes ra){
		String page = "";
		log.info("전달 파라미터 확인 : " + codeId);
		ClCodeVO clCodeVO = service.getClCodeInfo(codeId);
		if (clCodeVO != null) {
			model.addAttribute("clCodeVO", clCodeVO);
			page = "sample/detail";
		}else{
			page = "redirect:/test.do";
			ra.addFlashAttribute("noData", "존재 하지 않습니다.");
		}
		return page;
	}
	
	@RequestMapping(value = "/updateForm.do", method = RequestMethod.GET)
	public String registerForm(String clCode,
			Model model, RedirectAttributes ra){
		String page = "";
		ClCodeVO clCodeVO = service.getClCodeInfo(clCode);
		if (clCodeVO != null) {
			model.addAttribute("status", "u");
			model.addAttribute("clCodeVO", clCodeVO);
			page = "sample/register";
		}else{
			page = "redirect:/test.do";
			ra.addFlashAttribute("noData", "존재 하지 않습니다.");
		}
		return page;
	}
	
	@RequestMapping(value = "/saveClCode.do", method = RequestMethod.POST)
	public String saveClCodeData(@ModelAttribute ClCodeVO clCodeVO,
			RedirectAttributes ra){
		log.info("저장 clCodeVo : " + clCodeVO.toString());
		ServiceResult result = service.saveClCodeData(clCodeVO);
		String page = "";
		if (ServiceResult.OK.equals(result)) {
			page = "redirect:/detailCode.do?codeId=" + clCodeVO.getCl_code();
		}else{
			page = "redirect:/updateForm.do?clCode=" + clCodeVO.getCl_code();
			ra.addFlashAttribute("error", "서버오류입니다 다시 시도해주세요.");
		}
		return page;
	}
	
	@RequestMapping(value = "/delete.do", method = RequestMethod.POST)
	public String deleteClCode(@ModelAttribute ClCodeVO clCodeVO,
			RedirectAttributes ra){
		log.info("삭제 clCodeVo : " + clCodeVO.toString());
		ServiceResult result = service.deleteClCodeData(clCodeVO);
		String page = "";
		if (ServiceResult.OK.equals(result)) {
			page = "redirect:/test.do";
			ra.addFlashAttribute("delSuccessMsg", "정상적으로 삭제되었습니다.");
		}else{
			page = "redirect:/detailCode.do?codeId=" + clCodeVO.getCl_code();
			ra.addFlashAttribute("error", "서버오류입니다 다시 시도해주세요.");
		}
		return page;
	}
	
	@RequestMapping(value = "/addClCode.do", method = RequestMethod.GET)
	public String addClCode() {
		return "sample/register";
	}
	
	@RequestMapping(value = "/addClCodeProcess.do", method = RequestMethod.POST)
	public String addClCodeProcess(@ModelAttribute ClCodeVO clCodeVO,
			Model model,
			RedirectAttributes ra){
		log.info("저장 하려고 하는 파라미터 clCodeVo : " + clCodeVO);
		String page = "";
		int resCnt = service.checkClCode(clCodeVO);
		ServiceResult result = null;
		if (resCnt == 0) {
			result = service.addClCode(clCodeVO);
			if (ServiceResult.OK.equals(result)) {
				// 등록 성공할시
				page = "redirect:/detailCode.do?codeId=" + clCodeVO.getCl_code();
				ra.addFlashAttribute("addSuccessMSg", "정상적으로 등록되었습니다.");
			}else{
				page = "sample/register";
				model.addAttribute("error", "서버 에러입니다. 다시 시도해주세요.");
				model.addAttribute("clCodeVO", clCodeVO);
			}
		}else{
			page = "sample/register";
			model.addAttribute("error", "이미 존재하는 분류코드 입니다.");
			model.addAttribute("clCodeVO", clCodeVO);
		}
		return page;
	}
	
	@RequestMapping(value = "/boot.do")
	public String asdwa(){
		return "sample/boot";
	}
	
}
