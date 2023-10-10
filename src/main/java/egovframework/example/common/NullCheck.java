package egovframework.example.common;

/**
 * null 체크해서 공백으로 반환하는 클래스
 * @author 정재균
 *
 */
public class NullCheck {
	
	private final static String BLANK_STR = "";

	public static String nullCheck(String str){
		if (str == null) {
			str = BLANK_STR;
		}
		return str;
	}
}
