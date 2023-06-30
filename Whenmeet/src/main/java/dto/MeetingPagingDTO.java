package dto;

import java.util.ArrayList;

public class MeetingPagingDTO {
	String category, sort_type;
	int start, end;
	String user_id;
	int seq;
	ArrayList<Integer> seq_list;
	
	// getter & setter
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
		this.sort_type = sort_type;
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
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public ArrayList<Integer> getSeq_list() {
		return seq_list;
	}
	public void setSeq_list(ArrayList<Integer> seq_list) {
		this.seq_list = seq_list;
	}
	
	// 메소드
	public void calcNum(int page, int divNum) {
		this.start = (page - 1) * divNum;
		this.end = divNum;
	}
	
}
