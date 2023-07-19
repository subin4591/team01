package dto;

import java.util.Date;

public class GroupGanttDTO {
	private String group_id;
	private int big_todo;
	private int small_todo;
	private String big_todo_content;
	private String small_todo_content;
	private int check_do;
	private Date big_todo_start;
	private Date big_todo_end;
	
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	public int getBig_todo() {
		return big_todo;
	}
	public void setBig_todo(int big_todo) {
		this.big_todo = big_todo;
	}
	public int getSmall_todo() {
		return small_todo;
	}
	public void setSmall_todo(int small_todo) {
		this.small_todo = small_todo;
	}
	public String getBig_todo_content() {
		return big_todo_content;
	}
	public void setBig_todo_content(String big_todo_content) {
		this.big_todo_content = big_todo_content;
	}
	public String getSmall_todo_content() {
		return small_todo_content;
	}
	public void setSmall_todo_content(String small_todo_content) {
		this.small_todo_content = small_todo_content;
	}
	public int getCheck_do() {
		return check_do;
	}
	public void setCheck_do(int check_do) {
		this.check_do = check_do;
	}
	public Date getBig_todo_start() {
		return big_todo_start;
	}
	public void setBig_todo_start(Date big_todo_start) {
		this.big_todo_start = big_todo_start;
	}
	public Date getBig_todo_end() {
		return big_todo_end;
	}
	public void setBig_todo_end(Date big_todo_end) {
		this.big_todo_end = big_todo_end;
	}
	
	
}
