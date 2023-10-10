package egovframework.example.sample.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class CodeVO {
	private String code_id;
	private String cl_code;
	private String cl_code_nm;
	private String code_id_nm;
	private String code_id_dc;
	private String use_at;
	private int cnt;
}
