package dto;

import java.util.ArrayList;

public class WriterModeDTO {
	int seq;
	ArrayList<String> user_id;
	String approval;
	
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public ArrayList<String> getUser_id() {
		return user_id;
	}
	public void setUser_id(ArrayList<String> user_id) {
		this.user_id = user_id;
	}
	public String getApproval() {
		return approval;
	}
	public void setApproval(String approval) {
		this.approval = approval;
	}
}
