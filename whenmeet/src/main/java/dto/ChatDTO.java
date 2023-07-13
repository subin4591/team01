package dto;

public class ChatDTO {
	String group_id,name,text,writing_time,profile_url;

	public String getProfile_url() {
		return profile_url;
	}

	public void setProfile_url(String profile_url) {
		this.profile_url = profile_url;
	}

	public String getGroup_id() {
		return group_id;
	}

	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getWriting_time() {
		return writing_time;
	}

	public void setWriting_time(String writing_time) {
		this.writing_time = writing_time;
	}
	
	
}
