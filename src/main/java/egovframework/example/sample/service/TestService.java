package egovframework.example.sample.service;

import java.util.List;

import egovframework.example.sample.ServiceResult;

public interface TestService {
	public List<ClCodeVO> getClCodeList(ClCodeVO clCodeVO);
	public int getTotalCount(String table);
	public ClCodeVO getClCodeInfo(String codeId);
	public ServiceResult saveClCodeData(ClCodeVO clCodeVO);
	public ServiceResult deleteClCodeData(ClCodeVO clCodeVO);
	public int checkClCode(ClCodeVO clCodeVO);
	public ServiceResult addClCode(ClCodeVO clCodeVO);
}
