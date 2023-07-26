package group;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.GroupCreateDTO;
import dto.GroupDTO;
import dto.GroupUserDTO;
import dto.MeetingPagingDTO;
import dto.UserDTO;

@Service("groupservice")
public class GroupService {
	@Autowired
	GroupDAO dao;
	
	/// Group select
	// 승인된 유저 아이디
	public List<String> groupOkUsers(int seq) {
		return dao.groupOkUsers(seq);
	}
	
	// 그룹 방장 정보
	public UserDTO groupHostInfo(String host_id) {
		return dao.groupHostInfo(host_id);
	}
	
	// 그룹 유저 정보
	public List<UserDTO> groupUserInfo(ArrayList<String> list) {
		return dao.groupUserInfo(list);
	}
	
	// 그룹 아이디 중복체크
	public int findGroupID(String group_id) {
		return dao.findGroupID(group_id);
	}
	
	// 그룹 방장, 부방장 아이디
	public List<String> groupWhoHost(HashMap<String, String> map) {
		return dao.groupWhoHost(map);
	}
	
	// 그룹 정보
	public GroupDTO groupInfo(String group_id) {
		return dao.groupInfo(group_id);
	}
	
	// 유저가 가입한 그룹 목록
	public List<GroupDTO> groupList(MeetingPagingDTO dto) {
		return dao.groupList(dto);
	}
	public int groupListCount(MeetingPagingDTO dto) {
		return dao.groupListCount(dto);
	}
	
	
	/// Group insert
	// 그룹 생성
	public void insertGroup(GroupDTO dto) {
		dao.insertGroup(dto);
	}
	public void insertGroupUser(GroupUserDTO dto) {
		dao.insertGroupUser(dto);
	}
	
	
	/// Group update
	// 모집글 완료 처리
	public void updateMeetingEnd(int seq) {
		dao.updateMeetingEnd(seq);
	}
	
	// 일반 멤버로 변경
	public void updateNotHost(GroupCreateDTO dto) {
		dao.updateNotHost(dto);
	}
	
	// 방장, 부방장 설정
	public void updateHost(GroupCreateDTO dto) {
		dao.updateHost(dto);
	}
	
	// 그룹 정보 수정
	public void updateGroupInfo(GroupDTO dto) {
		dao.updateGroupInfo(dto);
	}
	
	
	/// Group delete
	// 멤버 탈퇴
	public int deleteMember(GroupCreateDTO dto) {
		return dao.deleteMember(dto);
	}
}
