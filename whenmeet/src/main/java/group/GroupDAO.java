package group;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

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
	public List<UserDTO> groupUserInfo(ArrayList<String> list);
	
	// 그룹 아이디 중복체크
	public int findGroupID(String group_id);
	
	// 그룹 방장, 부방장 아이디
	public List<String> groupWhoHost(HashMap<String, String> map);
	
	// 그룹 정보
	public GroupDTO groupInfo(String group_id);
	
	
	/// Group insert
	// 그룹 생성
	public void insertGroup(GroupDTO dto);
	public void insertGroupUser(GroupUserDTO dto);
	
	
	/// Group update
	// 모집글 완료 처리
	public void updateMeetingEnd(int seq);
}
