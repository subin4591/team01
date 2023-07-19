package schedule;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.ChatDTO;
import dto.GroupDTO;
import dto.GroupGanttDTO;
import dto.GroupUserDTO;
import dto.MeetingScheduleDTO;
import dto.MeetingScheduleDateDTO;
import dto.UserDTO;
import dto.userScheduleDTO;

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
	public void updateGroupSchedule(HashMap<String, String> map) throws Exception {
		scheduleMapper.updateGroupSchedule(map);
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
	public void updateGroupUserSetSchedule(HashMap<String, Object> map) throws Exception{		
		scheduleMapper.updateGroupUserSetSchedule(map);
	}
	public void deleteGroupUser(HashMap<String, Object> map) throws Exception{
		scheduleMapper.deleteGroupUser(map);
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
	
	public int selectUserScheduleDayCnt(HashMap<String, Object> map) throws Exception{
		return scheduleMapper.selectUserScheduleDayCnt(map);
	}
	public userScheduleDTO selectUserSchedule(userScheduleDTO dto) throws Exception{
		return scheduleMapper.selectUserSchedule(dto);
	}
	public List<userScheduleDTO> selectUserScheduleAll(userScheduleDTO dto) throws Exception{
		return scheduleMapper.selectUserScheduleAll(dto);
	}
	public int selectUserScheduleCnt(userScheduleDTO dto) throws Exception{
		return scheduleMapper.selectUserScheduleCnt(dto);
	}
	public int selectUserScheduleCntAll(userScheduleDTO dto) throws Exception{
		return scheduleMapper.selectUserScheduleCntAll(dto);
	}
	public void insertUserSchedule(userScheduleDTO dto) throws Exception{
		scheduleMapper.insertUserSchedule(dto);
	}
	public void updateUserSchedule(userScheduleDTO dto) throws Exception{
		scheduleMapper.updateUserSchedule(dto);
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
	
	public List<GroupGanttDTO> selectGroupGantt(String groupId) throws Exception{
		return scheduleMapper.selectGroupGantt(groupId);
	}
	public int selectGroupGanttCnt(String groupId) throws Exception{
		return scheduleMapper.selectGroupGanttCnt(groupId);
	}
	public List<GroupGanttDTO> selectDistinctGanttToDo(String group_id) throws Exception{
		return scheduleMapper.selectDistinctGanttToDo(group_id);
	}
	public List<GroupGanttDTO> selectGroupGanttToDo(HashMap<String, Object> map) throws Exception{
		return scheduleMapper.selectGroupGanttToDo(map);
	}
	public int selectDoItMax(String group_id) throws Exception{
		return scheduleMapper.selectDoItMax(group_id);
	}
	public void insertGroupGanttInit(HashMap<String, Object> map) throws Exception{
		scheduleMapper.insertGroupGanttInit(map);
	}
	public void insertGroupGantt(HashMap<String, Object> map) throws Exception{
		scheduleMapper.insertGroupGantt(map);
	}
	public void updateGroupGantt(HashMap<String, Object> map) throws Exception{
		scheduleMapper.updateGroupGantt(map);
	}
	public void deleteGroupGanttAll(String groupId) throws Exception{
		scheduleMapper.deleteGroupGanttAll(groupId);
	}
	public void deleteGroupGanttOne(HashMap<String, Object> map) throws Exception{
		scheduleMapper.deleteGroupGanttOne(map);
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
}
