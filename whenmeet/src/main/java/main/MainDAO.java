package main;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.GroupDTO;
import dto.MainDTO;
import dto.ScheduleDTO;
import dto.UserDTO;

@Mapper
@Repository
public interface MainDAO {

	public List<MainDTO> myApplication(String user_id);
	public List<MainDTO> myWrite(String user_id);
	public List<GroupDTO> myGroup(String user_id);
	public List<MainDTO> rankList();
	public void address(String address,String group_id);
	public UserDTO userInfo(String user_id);
	public void scheduleAdd(String user_id,String start,String end,String title,String address,String memo);
	public List<ScheduleDTO> getSchedule(String user_id);
	public ScheduleDTO getScheduleOne(String user_id,String start,String end,String title);
	public void scheduleDelete(String user_id,String start,String end,String title);
	public void scheduleChange(String title,String start,String end ,String address,String memo,
								String user_id,String p_title,String p_start,String p_end);
}
