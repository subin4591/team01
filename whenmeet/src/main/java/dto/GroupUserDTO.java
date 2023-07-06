package dto;

public class GroupUserDTO {
	String group_id;
	String user_id;
	int host, sub_host, set_schedule;
	
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getHost() {
		return host;
	}
	public void setHost(int host) {
		this.host = host;
	}
	public int getSub_host() {
		return sub_host;
	}
	public void setSub_host(int sub_host) {
		this.sub_host = sub_host;
	}
	public int getSet_schedule() {
		return set_schedule;
	}
	public void setSet_schedule(int set_schedule) {
		this.set_schedule = set_schedule;
	}
	
	
}
