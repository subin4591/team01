package dto;

import java.util.ArrayList;

public class GroupCreateDTO {
	String host_id;
	ArrayList<String> sub_host_id, user_list;
	String group_name, group_description, project_end_time;
	
	public String getHost_id() {
		return host_id;
	}
	public void setHost_id(String host_id) {
		this.host_id = host_id;
	}
	public ArrayList<String> getSub_host_id() {
		return sub_host_id;
	}
	public void setSub_host_id(ArrayList<String> sub_host_id) {
		this.sub_host_id = sub_host_id;
	}
	public ArrayList<String> getUser_list() {
		return user_list;
	}
	public void setUser_list(ArrayList<String> user_list) {
		this.user_list = user_list;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public String getGroup_description() {
		return group_description;
	}
	public void setGroup_description(String group_description) {
		this.group_description = group_description;
	}
	public String getProject_end_time() {
		return project_end_time;
	}
	public void setProject_end_time(String project_end_time) {
		this.project_end_time = project_end_time;
	}
	
	
}
