package schedule;

import java.util.HashMap;
import java.util.List;

import dto.ChatDTO;
import dto.GroupDTO;
import dto.GroupUserDTO;
import dto.UserDTO;
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
	
	String getLocation(String group_id) throws Exception;
	void addChat(HashMap<String, Object> map) throws Exception;
	List<ChatDTO> getChat(String group_id) throws Exception;
}
