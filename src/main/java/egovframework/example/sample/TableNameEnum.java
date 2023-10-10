package egovframework.example.sample;

public enum TableNameEnum {
	공통분류코드("t_comtccmmnclcode"),
	공통코드("t_comtccmmncode"),
	공통코드상세("t_comtccmmndetailcode");
	
	private final String tableName;
	
	private TableNameEnum(String tableName) {
		this.tableName = tableName;
	}
	
	public String getTable() {
		return tableName;
	}
}
