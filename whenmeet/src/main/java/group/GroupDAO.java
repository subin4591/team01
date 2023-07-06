package group;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.GroupCreateDTO;
import dto.UserDTO;

@Mapper
@Repository
public interface GroupDAO {
	// Group select
	// 승인된 유저 아이디
	public List<String> groupOkUsers(int seq);
	
	// 그룹 방장 정보
	public UserDTO groupHostInfo(String host_id);
	
	// 그룹 유저 정보
	public List<UserDTO> groupUserInfo(GroupCreateDTO dto);
}
