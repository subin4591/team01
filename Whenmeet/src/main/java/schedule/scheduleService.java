package schedule;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.ChatDTO;
import dto.GroupDTO;
import dto.GroupUserDTO;
import dto.MeetingScheduleDTO;
import dto.MeetingScheduleDateDTO;
import dto.UserDTO;

@Service("scheduleService")
public class scheduleService {
	
	@Autowired
	private scheduleMapper scheduleMapper;

	public List<UserDTO> selectUser() throws Exception {
		return scheduleMapper.selectUser();
	}
	public UserDTO selectUserOne(String user_id) throws Exception {
		return scheduleMapper.selectUserOne(user_id);
	}
	
	public List<GroupDTO> selectGroup() throws Exception{
		return scheduleMapper.selectGroup();
	}	
	public GroupDTO selectGroupOne(String group_id) throws Exception {
		return scheduleMapper.selectGroupOne(group_id);
	}
	
	public List<GroupUserDTO> selectGroupUser() throws Exception{
		return scheduleMapper.selectGroupUser();
	}
	public GroupUserDTO selectGroupUserOne(HashMap<String, Object> map) throws Exception{
		return scheduleMapper.selectGroupUserOne(map);
	}
	public List<GroupUserDTO> selectGroupUsers(String group_id) throws Exception{
		return scheduleMapper.selectGroupUsers(group_id);
	}
	
	public void updateGroupUserSubHost(HashMap<String, Object> map) throws Exception{		
		scheduleMapper.updateGroupUserSubHost(map);
	}
	public String getLocation(String group_id) throws Exception{
		return scheduleMapper.getLocation(group_id);
	}
	void addCaht(HashMap<String, Object> map) throws Exception{
		scheduleMapper.addChat(map);
	}
	List<ChatDTO> getChat(String group_id) throws Exception{
		return scheduleMapper.getChat(group_id);
	}
	
	public  List<MeetingScheduleDTO> selectMeetingScheduleAll(String group_id) throws Exception{
		return scheduleMapper.selectMeetingScheduleAll(group_id);
	}
	public  List<MeetingScheduleDTO> selectMeetingScheduleAllShow(HashMap<String, Object> map) throws Exception{
		return scheduleMapper.selectMeetingScheduleAllShow(map);
	}
	public  int selectMeetingScheduleAllShowCnt(HashMap<String, Object> map) throws Exception{
		return scheduleMapper.selectMeetingScheduleAllShowCnt(map);
	}
	public MeetingScheduleDTO selectMeetingScheduleOne(HashMap<String, Object> map) throws Exception{
		return scheduleMapper.selectMeetingScheduleOne(map);
	}
	public int selectMeetingScheduleCnt(HashMap<String, Object> map) throws Exception{
		return scheduleMapper.selectMeetingScheduleCnt(map);
	}
	public void insertMeetingSchedule(MeetingScheduleDTO dto) throws Exception{
		scheduleMapper.insertMeetingSchedule(dto);
	}
	public void updateMeetingScheduleShowViewAllZero(String group_id) throws Exception {
		scheduleMapper.updateMeetingScheduleShowViewAllZero(group_id);
	}
	public void updateMeetingScheduleShowViewOne(HashMap<String, Object> map) throws Exception{
		scheduleMapper.updateMeetingScheduleShowViewOne(map);
	}
	
	public MeetingScheduleDateDTO selectMeetingScheduleDate(String group_id) throws Exception{
		return scheduleMapper.selectMeetingScheduleDate(group_id);
	}
	public int selectMeetingScheduleDateCnt(String group_id) throws Exception{
		return scheduleMapper.selectMeetingScheduleDateCnt(group_id);
	}
	public void insertMeetingScheduleDate(HashMap<String, Object> map) throws Exception{
		scheduleMapper.insertMeetingScheduleDate(map);
	}
	public void updateMeetingScheduleDate(HashMap<String, Object> map) throws Exception{
		scheduleMapper.updateMeetingScheduleDate(map);
	}
}
