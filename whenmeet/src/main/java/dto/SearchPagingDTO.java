package dto;

public class SearchPagingDTO {
	String category, sort_type, search_input, type;
	int start, end;
	
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSort_type() {
		return sort_type;
	}
	public void setSort_type(String sort_type) {
		if (sort_type.equals("time")) {
			this.sort_type = "writing_time";
		}
		else if (sort_type.equals("appl")) {
			this.sort_type = "applicant_cnt";
		}
		else {
			this.sort_type = sort_type;
		}
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	public String getSearch_input() {
		return search_input;
	}
	public void setSearch_input(String search_input) {
		this.search_input = search_input;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	// 메소드
	public void calcNum(int page, int divNum) {
		this.start = (page - 1) * divNum;
		this.end = divNum;
	}
}
