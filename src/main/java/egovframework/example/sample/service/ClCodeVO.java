package egovframework.example.sample.service;

import lombok.Setter;
import lombok.Getter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ClCodeVO {
	private String cl_code;
	private String cl_code_nm;
	private int cnt;
	private String cl_code_dc;
	private String use_at;
}
