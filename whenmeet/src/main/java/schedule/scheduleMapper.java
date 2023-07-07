package schedule;

import java.util.HashMap;
import java.util.List;

import dto.GroupDTO;
import dto.GroupUserDTO;
import dto.UserDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface scheduleMapper {
	List<UserDTO> selectUser() throws Exception;
	UserDTO selectUserOne(String user_id) throws Exception;
	
	List<GroupDTO> selectGroup() throws Exception;
	GroupDTO selectGroupOne(String group_id) throws Exception;
	
	List<GroupUserDTO> selectGroupUser() throws Exception;
	GroupUserDTO selectGroupUserOne(HashMap<String, String> map) throws Exception;
	List<GroupUserDTO> selectGroupUsers(String group_id) throws Exception;
}
