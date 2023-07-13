package schedule;

import java.util.HashMap;
import java.util.List;

import dto.ChatDTO;
import dto.GroupDTO;
import dto.GroupUserDTO;
import dto.MeetingScheduleDTO;
import dto.MeetingScheduleDateDTO;
import dto.UserDTO;
import dto.userScheduleDTO;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
public interface scheduleMapper {
	List<UserDTO> selectUser() throws Exception;
	UserDTO selectUserOne(String user_id) throws Exception;
	
	List<GroupDTO> selectGroup() throws Exception;
	GroupDTO selectGroupOne(String group_id) throws Exception;
	
	List<GroupUserDTO> selectGroupUser() throws Exception;
	GroupUserDTO selectGroupUserOne(HashMap<String, Object> map) throws Exception;
	List<GroupUserDTO> selectGroupUsers(String group_id) throws Exception;
	void updateGroupUserSubHost(HashMap<String, Object> map) throws Exception;
	void updateGroupUserSetSchedule(HashMap<String, Object> map) throws Exception;
	
	List<MeetingScheduleDTO> selectMeetingScheduleAll(String group_id) throws Exception;
	List<MeetingScheduleDTO> selectMeetingScheduleAllShow(HashMap<String, Object> map) throws Exception;
	int selectMeetingScheduleAllShowCnt(HashMap<String, Object> map) throws Exception;
	MeetingScheduleDTO selectMeetingScheduleOne(HashMap<String, Object> map) throws Exception;
	int selectMeetingScheduleCnt(HashMap<String, Object> map) throws Exception;
	void insertMeetingSchedule(MeetingScheduleDTO dto) throws Exception;
	void updateMeetingScheduleShowViewAllZero(String group_id) throws Exception;
	void updateMeetingScheduleShowViewOne(HashMap<String, Object> map) throws Exception;
	
	int selectUserScheduleDayCnt(HashMap<String, Object> map) throws Exception;
	userScheduleDTO selectUserSchedule(userScheduleDTO dto) throws Exception;
	List<userScheduleDTO> selectUserScheduleAll(userScheduleDTO dto) throws Exception;
	int selectUserScheduleCnt(userScheduleDTO dto) throws Exception;
	int selectUserScheduleCntAll(userScheduleDTO dto) throws Exception;
	void insertUserSchedule(userScheduleDTO dto) throws Exception;
	void updateUserSchedule(userScheduleDTO dto) throws Exception;
	
	MeetingScheduleDateDTO selectMeetingScheduleDate(String group_id) throws Exception;
	int selectMeetingScheduleDateCnt(String group_id) throws Exception;
	void insertMeetingScheduleDate(HashMap<String, Object> map) throws Exception;
	void updateMeetingScheduleDate(HashMap<String, Object> map) throws Exception;
	
	String getLocation(String group_id) throws Exception;
	void addChat(HashMap<String, Object> map) throws Exception;
	List<ChatDTO> getChat(String group_id) throws Exception;
}
