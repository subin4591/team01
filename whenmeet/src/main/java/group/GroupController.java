package group;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.GroupCreateDTO;
import dto.GroupDTO;
import dto.GroupUserDTO;
import dto.MeetingPagingDTO;
import dto.UserDTO;
import jakarta.servlet.http.HttpSession;

@Controller
public class GroupController {
	@Autowired
	@Qualifier("groupservice")
	GroupService service;
	
	int divNum = 10;
	
	@RequestMapping("/group/invitation")
	public ModelAndView groupInvitaion(HttpSession session) {
		// ModelAndView 생성
		ModelAndView mv = new ModelAndView();
		
		// session_id
		String session_id = (String)session.getAttribute("session_id");
		
		if (session_id == null) {
			mv.setViewName("schedule/scheduleError");
		}
		else {
			// 방장 정보 생성
			UserDTO host_info = service.groupHostInfo(session_id);
			
			mv.addObject("host_info", host_info);
			mv.setViewName("group/group_invitation");			
		}
		
		return mv;
	}
	
	@RequestMapping("/group/invitation/IDSearch")
	@ResponseBody
	public UserDTO groupInvitationIDSearch(String id) {
		UserDTO user = service.groupHostInfo(id);
		if (user == null) {
			user = new UserDTO();
			user.setName("null");
		}
		return user;
	}
	
	@GetMapping(value = {"/group/create", "/group/create/result"})
	public String groupCreateGet() {
		return "schedule/scheduleError";
	}
	
	@PostMapping("/group/create")
	public ModelAndView groupCreatePost(int seq, HttpSession session) {
		// session_id
		String session_id = (String)session.getAttribute("session_id");
		
		// 모집글 완료 처리
		service.updateMeetingEnd(seq);
		
		// 승인된 유저 목록 생성
		List<UserDTO> user_info;
		GroupCreateDTO dto = new GroupCreateDTO();
		dto.setHost_id(session_id);
		dto.setUser_list(new ArrayList<>(service.groupOkUsers(seq)));
		if (dto.getUser_list().size() == 0) {
			user_info = null;
		}
		else {
			user_info = service.groupUserInfo(dto.getUser_list());
		}
		
		// 방장 정보 생성
		UserDTO host_info = service.groupHostInfo(session_id);
		
		// ModelAndView 생성
		ModelAndView mv = new ModelAndView();
		mv.addObject("host_info", host_info);
		mv.addObject("user_info", user_info);
		mv.setViewName("group/group_create");
			
		return mv;
	}
	
	@PostMapping("/group/create/result")
	public ModelAndView groupCreateResult(GroupCreateDTO dto) {
		// GroupDTO 생성
		GroupDTO group_dto = new GroupDTO();
		group_dto.setGroup_name(dto.getGroup_name());
		group_dto.setGroup_description(dto.getGroup_description());
		group_dto.setProject_end_time(dto.getProject_end_time());
		
		if (dto.getProject_end_time().equals("")) {
			group_dto.setProject_end_time(null);
		}
		
		// group_id 생성
		String group_id = RandomStringUtils.random(8, true, true);
		while (service.findGroupID(group_id) == 1) {
			group_id = RandomStringUtils.random(8, true, true);
		}
		group_dto.setGroup_id(group_id);
		
		// group_table insert
		service.insertGroup(group_dto);
		
		if (dto.getProject_end_time().equals("")) {
			group_dto.setProject_end_time("null");
		}
		
		// GroupUserDTO 생성 및 유저 정보 생성
		GroupUserDTO gu = new GroupUserDTO();
		gu.setGroup_id(group_id);
		
		// 방장
		gu.setUser_id(dto.getHost_id());
		gu.setHost(1);
		gu.setSub_host(0);
		service.insertGroupUser(gu);	// table insert
		UserDTO host_info = service.groupHostInfo(dto.getHost_id());	// host_info
		
		// 부방장
		gu.setHost(0);
		gu.setSub_host(1);
		
		ArrayList<String> sub = dto.getSub_host_id();
		ArrayList<String> user_list = dto.getUser_list();
		List<UserDTO> sub_host_info;
		
		if (dto.getSub_host_id() != null) {
			// group_user_table insert
			for (int i = 0; i < sub.size(); i++) {
				user_list.remove(sub.get(i));
				gu.setUser_id(sub.get(i));
				service.insertGroupUser(gu);
			}
			
			// 유저 정보 생성
			sub_host_info = service.groupUserInfo(dto.getSub_host_id());
		}
		else {
			sub_host_info = null;
		}
		
		// 그 외 멤버
		gu.setSub_host(0);
		List<UserDTO> user_info;
		dto.setUser_list(user_list);
		
		if (user_list != null) {
			if (user_list.size() != 0) {
				// group_user_table insert
				for(int i = 0; i < user_list.size(); i++) {
					gu.setUser_id(user_list.get(i));
					service.insertGroupUser(gu);
				}
				
				// 유저 정보 생성
				user_info = service.groupUserInfo(user_list);
			}
			else {
				user_info = null;
			}
		}
		else {
			user_info = null;
		}
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("group_dto", group_dto);
		mv.addObject("host_info", host_info);
		mv.addObject("sub_host_info", sub_host_info);
		mv.addObject("user_info", user_info);
		mv.addObject("group_id", group_id);
		mv.setViewName("group/group_create_success");
		return mv;
	}
	
	@RequestMapping("/group/change/{groupId}")
	public ModelAndView groupChange(@PathVariable("groupId") String groupId, HttpSession session) {
		// 방장 아이디
		HashMap<String, String> map = new HashMap<>();
		map.put("group_id", groupId);
		map.put("host", "host");
		String host = service.groupWhoHost(map).get(0);
		
		// ModelAndView 생성
		ModelAndView mv = new ModelAndView();
		if (session.getAttribute("session_id") != null) {
			if (session.getAttribute("session_id").equals(host)) {
				// 방장 정보
				UserDTO host_info = service.groupHostInfo(host);
				
				// 부방장 정보
				map.put("host", "sub_host");
				ArrayList<String> sub_list = new ArrayList<>(service.groupWhoHost(map));
				List<UserDTO> sub_info;
				if (sub_list.size() != 0) {
					sub_info = service.groupUserInfo(sub_list);
				}
				else {
					sub_info = null;
				}
				
				// 멤버 정보
				map.put("host", "member");
				ArrayList<String> mem_list = new ArrayList<>(service.groupWhoHost(map));
				List<UserDTO> mem_info;
				if (mem_list.size() != 0) {
					mem_info = service.groupUserInfo(mem_list);
				}
				else {
					mem_info = null;
				}
				
				// 그룹 정보
				GroupDTO group_info = service.groupInfo(groupId);
				
				mv.addObject("host_info", host_info);
				mv.addObject("sub_info", sub_info);
				mv.addObject("mem_info", mem_info);
				mv.addObject("group_info", group_info);
				mv.setViewName("group/group_change");
			}
			else {
				mv.setViewName("schedule/scheduleError");
			}
		}
		else {
			mv.setViewName("schedule/scheduleError");
		}
		
		return mv;
	}
	
	@RequestMapping("/group/change/host")
	@ResponseBody
	public HashMap<String, String> groupChangeHost(GroupCreateDTO dto, HttpSession session) {
		// 기존 host, 변경 host
		String session_id = (String)session.getAttribute("session_id");
		String host_id = dto.getHost_id();
		
		// 기존 host 일반 멤버로 변경
		ArrayList<String> user_list = new ArrayList<>();
		user_list.add(session_id);
		dto.setUser_list(user_list);
		
		service.updateNotHost(dto);
		
		// host 변경
		user_list.clear();
		user_list.add(host_id);
		dto.setUser_list(user_list);
		dto.setHost_id("host");
		
		service.updateHost(dto);
		
		// 새 host 정보
		UserDTO user = service.groupHostInfo(host_id);
		
		// return
		HashMap<String, String> map = new HashMap<>();
		map.put("host", user.getName());
		
		return map;
	}
	
	@RequestMapping("/group/change/subHost")
	@ResponseBody
	public HashMap<String, Object> groupChangeSubHost(GroupCreateDTO dto) {
		// 기존 sub host
		ArrayList<String> getName = new ArrayList<>();
		ArrayList<String> getList = dto.getUser_list();
		
		if (getList != null) {
			for (int i = 0; i < getList.size(); i++) {
				getName.add(service.groupHostInfo(getList.get(i)).getName());
			}
			
			// 기존 sub host 일반 멤버로 변경
			service.updateNotHost(dto);
		}
		else {
			getName.add("없음");
		}
		
		String origin_sub = String.join(", ", getName);
		
		// 변경 sub host
		getName.clear();
		getList = dto.getSub_host_id();
		
		if (getList != null) {
			for (int i = 0; i < getList.size(); i++) {
				getName.add(service.groupHostInfo(getList.get(i)).getName());
			}
			
			// sub host 변경
			dto.setUser_list(getList);
			dto.setHost_id("sub_host");
			
			service.updateHost(dto);
		}
		else {
			getName.add("없음");
		}
		
		String change_sub = String.join(", ", getName);
		
		// return
		HashMap<String, Object> map = new HashMap<>();
		map.put("origin_sub", origin_sub);
		map.put("change_sub", change_sub);
		map.put("sub_host_id", dto.getSub_host_id());
		
		return map;
	}
	
	@RequestMapping("/group/change/member")
	@ResponseBody
	public HashMap<String, Object> groupChangeMember(GroupCreateDTO dto) {
		int cnt = service.deleteMember(dto);
		
		// return
		HashMap<String, Object> map = new HashMap<>();
		map.put("cnt", cnt);
		return map;
	}
	
	@RequestMapping("/group/change/info")
	@ResponseBody
	public HashMap<String, Object> groupChangeInfo(GroupDTO dto) {
		if (dto.getProject_end_time().equals("")) { dto.setProject_end_time(null); }
		
		// 그룹 수정
		service.updateGroupInfo(dto);
		
		// return
		HashMap<String, Object> map = new HashMap<>();
		map.put("result", "성공");
		return map;
	}
	
	@RequestMapping("/group/list")
	public ModelAndView groupList(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		String id = (String)session.getAttribute("session_id");
		
		if (id != null) {
			UserDTO user = service.groupHostInfo(id);
			
			MeetingPagingDTO dto = new MeetingPagingDTO();
			dto.setUser_id(id);
			dto.setSort_type("all");
			dto.calcNum(1, divNum);
			
			List<GroupDTO> group = service.groupList(dto);
			int cnt = service.groupListCount(dto);
			
			mv.addObject("group", group);
			mv.addObject("cnt", cnt);
			mv.addObject("div", divNum);
			mv.addObject("user", user);
			mv.setViewName("group/group_list");
		}
		else {
			mv.setViewName("schedule/scheduleError");	
		}
		return mv;
	}
}
