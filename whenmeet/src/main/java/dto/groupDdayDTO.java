package dto;

public class groupDdayDTO {
	private String group_id;
	private String final_schedule;
	private String start_time;
	private String end_time;
	private int dday;
	
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	public String getFinal_schedule() {
		return final_schedule;
	}
	public void setFinal_schedule(String final_schedule) {
		this.final_schedule = final_schedule;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public int getDday() {
		return dday;
	}
	public void setDday(int dday) {
		this.dday = dday;
	}
	
}
