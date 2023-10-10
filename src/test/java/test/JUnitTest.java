package test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import egovframework.example.sample.service.MenuService;
import egovframework.example.sample.service.T_comtnmenuinfoVO;

public class JUnitTest {

	@Autowired
	private MenuService menuService;
	
	@Test
	public void test() {
		String author_code = "999999";
//		List<T_comtnmenuinfoVO> headerMenu = menuService.getHeaderMenu(author_code);
	}

}
