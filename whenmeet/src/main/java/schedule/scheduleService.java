package schedule;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.GroupDTO;
import dto.GroupUserDTO;
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
}
