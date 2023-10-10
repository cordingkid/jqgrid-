package egovframework.example.sample.service;

import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class T_comtnmenuinfoVO {
	private Integer menu_no;
	private String menu_nm;
	private Integer upper_menu_no;
	private String progrm_file_nm;
	private int menu_ordr;
	private String menu_dc;
	private String relate_image_path;
	private String relate_image_nm;
	private String target;
	
	// 선택 되었는지 체크 하는 필드
	private int selectedCnt;
	private String type;
	private String url;
	private List<T_comtnmenuinfoVO> children;
	
	public void addChild(T_comtnmenuinfoVO child){
		if (children == null) {
			children = new ArrayList<>();
		}
		children.add(child);
	}
}
