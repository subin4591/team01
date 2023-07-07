package group;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.GroupCreateDTO;
import dto.GroupDTO;
import dto.GroupUserDTO;
import dto.UserDTO;

@Mapper
@Repository
public interface GroupDAO {
	/// Group select
	// 승인된 유저 아이디
	public List<String> groupOkUsers(int seq);
	
	// 그룹 방장 정보
	public UserDTO groupHostInfo(String host_id);
	
	// 그룹 유저 정보
	public List<UserDTO> groupUserInfo(GroupCreateDTO dto);
	
	// 그룹 아이디 중복체크
	public int findGroupID(String group_id);
	
	
	/// Group insert
	// 그룹 생성
	public void insertGroup(GroupDTO dto);
	public void insertGroupUser(GroupUserDTO dto);
	
	
	/// Group update
	// 모집글 완료 처리
	public void updateMeetingEnd(int seq);
}
