package main;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.GroupDTO;
import dto.MainDTO;
import dto.MeetingDTO;
import dto.MeetingPagingDTO;
import dto.ScheduleDTO;
import dto.UserDTO;

@Service("mainservice")
public class MainService {
	
	@Autowired
	MainDAO dao;
	
	public List<MainDTO> myApplication(String user_id){
		return dao.myApplication(user_id);
	};
	public List<MainDTO> myWrite(String user_id){
		return dao.myWrite(user_id);
	};
	public List<GroupDTO> myGroup(String user_id){
		return dao.myGroup(user_id);
	};
	public List<MainDTO> rankList(LocalDate last){
		return dao.rankList(last);
	}
	public void address(String address,String group_id) {
		dao.address(address, group_id);
	} 
	public void scheduleAdd(String user_id,String start,String end,String title,String address,String memo) {
		dao.scheduleAdd(user_id, start, end, title, address, memo);
	}
	public List<ScheduleDTO> getSchedule(String user_id) {
		return dao.getSchedule(user_id);
	}
	public ScheduleDTO getScheduleOne(String user_id,String start,String end,String title) {
		return dao.getScheduleOne(user_id, start, end, title);
	}
	public void scheduleDelete(String user_id,String start,String end,String title) {
		dao.scheduleDelete(user_id, start, end, title);
	}
	public void scheduleChange(String title,String start,String end ,String address,String memo,
			String user_id,String p_title,String p_start,String p_end) {
		dao.scheduleChange(title, start, end, address, memo, user_id, p_title, p_start, p_end);
	}
	public String whoHost(String group_id) {
		return dao.whoHost(group_id);
	}
}
