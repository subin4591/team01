package dto;

import java.util.ArrayList;

public class GroupInvitationDTO {
	String group_id, user_id, invitation_time, name, profile_url;
	ArrayList<String> user_list;

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

	public String getInvitation_time() {
		return invitation_time;
	}

	public void setInvitation_time(String invitation_time) {
		this.invitation_time = invitation_time;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getProfile_url() {
		return profile_url;
	}

	public void setProfile_url(String profile_url) {
		this.profile_url = profile_url;
	}

	public ArrayList<String> getUser_list() {
		return user_list;
	}

	public void setUser_list(ArrayList<String> user_list) {
		this.user_list = user_list;
	}
	
}
