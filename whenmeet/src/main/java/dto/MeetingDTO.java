package dto;

public class MeetingDTO {
	int seq;
	String user_id, writer, title, contents, category, hidden, writing_time;
	int hits;
	String end;
	int applicant_cnt;
	String profile_url, contents_password;
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getHidden() {
		return hidden;
	}
	public void setHidden(String hidden) {
		this.hidden = hidden;
	}
	public String getWriting_time() {
		return writing_time;
	}
	public void setWriting_time(String writing_time) {
		this.writing_time = writing_time;
	}
	public int getHits() {
		return hits;
	}
	public void setHits(int hits) {
		this.hits = hits;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public int getApplicant_cnt() {
		return applicant_cnt;
	}
	public void setApplicant_cnt(int applicant_cnt) {
		this.applicant_cnt = applicant_cnt;
	}
	public String getProfile_url() {
		return profile_url;
	}
	public void setProfile_url(String profile_url) {
		this.profile_url = profile_url;
	}
	public String getContents_password() {
		return contents_password;
	}
	public void setContents_password(String contents_password) {
		this.contents_password = contents_password;
	}
	
	
}
