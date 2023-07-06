package group;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.GroupCreateDTO;
import dto.UserDTO;

@Service("groupservice")
public class GroupService {
	@Autowired
	GroupDAO dao;
	
	// Group select
	// 승인된 유저 아이디
	public List<String> groupOkUsers(int seq) {
		return dao.groupOkUsers(seq);
	}
	
	// 그룹 방장 정보
	public UserDTO groupHostInfo(String host_id) {
		return dao.groupHostInfo(host_id);
	}
	
	// 그룹 유저 정보
	public List<UserDTO> groupUserInfo(GroupCreateDTO dto) {
		return dao.groupUserInfo(dto);
	}
}
