package dto;

public class MeetingScheduleDTO {
	
	private String group_id;
	private int seq;
	private String first_date;
	private String last_date;
	private int showView;
	
	public int getShowView() {
		return showView;
	}
	public void setShowView(int showView) {
		this.showView = showView;
	}
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getFirst_date() {
		return first_date;
	}
	public void setFirst_date(String first_date) {
		this.first_date = first_date;
	}
	public String getLast_date() {
		return last_date;
	}
	public void setLast_date(String last_date) {
		this.last_date = last_date;
	}
}
