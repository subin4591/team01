package group;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.GroupCreateDTO;
import dto.GroupDTO;
import dto.GroupUserDTO;
import dto.UserDTO;
import jakarta.servlet.http.HttpSession;

@Controller
public class GroupController {
	@Autowired
	@Qualifier("groupservice")
	GroupService service;
	
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
			user_info = service.groupUserInfo(dto);
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
		// 부방장 user_list에서 제거
		ArrayList<String> user_list = dto.getUser_list();
		user_list.remove(dto.getSub_host_id());
		dto.setUser_list(user_list);
		
		// GroupDTO 생성
		GroupDTO group_dto = new GroupDTO();
		group_dto.setGroup_name(dto.getGroup_name());
		group_dto.setGroup_description(dto.getGroup_description());
		if (dto.getProject_end_time() == null) {
			group_dto.setProject_end_time("none");
		}
		else {
			group_dto.setProject_end_time(dto.getProject_end_time());
		}
		
		// group_id 생성
		String group_id = RandomStringUtils.random(8, true, true);
		while (service.findGroupID(group_id) == 1) {
			group_id = RandomStringUtils.random(8, true, true);
		}
		group_dto.setGroup_id(group_id);
		
		service.insertGroup(group_dto);
		
		// GroupUserDTO 생성
		GroupUserDTO gu = new GroupUserDTO();
		gu.setGroup_id(group_id);
		
		// 방장
		gu.setUser_id(dto.getHost_id());
		gu.setHost(1);
		gu.setSub_host(0);
		service.insertGroupUser(gu);
		
		// 부방장
		gu.setUser_id(dto.getSub_host_id());
		gu.setHost(0);
		gu.setSub_host(1);
		service.insertGroupUser(gu);
		
		// 그외
		gu.setSub_host(0);
		for(int i = 0; i < user_list.size(); i++) {
			gu.setUser_id(user_list.get(i));
			service.insertGroupUser(gu);
		}
		
		// 유저 정보 생성
		UserDTO host_info = service.groupHostInfo(dto.getHost_id());	// 방장
		UserDTO sub_host_info = service.groupHostInfo(dto.getSub_host_id());	// 부방장
		
		List<UserDTO> user_info;
		dto.setUser_list(user_list);
		if (dto.getUser_list().size() == 0) {
			user_info = null;
		}
		else {
			user_info = service.groupUserInfo(dto);
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
	
	/// test
	@RequestMapping("/group/create/test")
	public ModelAndView groupCreateTest() {
		// test data
		int seq = 51;
		String session_id = "hwang1";
		
		// 승인된 유저 목록 생성
		List<UserDTO> user_info;
		GroupCreateDTO dto = new GroupCreateDTO();
		dto.setHost_id(session_id);
		dto.setUser_list(new ArrayList<>(service.groupOkUsers(seq)));
		if (dto.getUser_list().size() == 0) {
			user_info = null;
		}
		else {
			user_info = service.groupUserInfo(dto);
		}
		
		// 방장 정보 생성
		UserDTO host_info = service.groupHostInfo(session_id);
		
		// ModelAndView 생성
		ModelAndView mv = new ModelAndView();
		mv.addObject("host_info", host_info);
		mv.addObject("user_info", user_info);
		mv.setViewName("group/group_create_test");	
		return mv;
	}
	
	@RequestMapping("/group/create/result/test")
	public ModelAndView groupCreateResultTest() {
		// test data
		int seq = 51;
		String session_id = "hwang1";
		
		// 승인된 유저 목록 생성
		GroupCreateDTO dto = new GroupCreateDTO();
		dto.setHost_id(session_id);
		dto.setSub_host_id("member5");
		dto.setUser_list(new ArrayList<>(service.groupOkUsers(seq)));
		dto.setGroup_name("통기타 힐링");
		dto.setGroup_description("통기타를 함께 연주하며 힐링하는 그룹입니다.");
		dto.setProject_end_time("2023-08-31");
				
		// 부방장 user_list에서 제거
		ArrayList<String> user_list = dto.getUser_list();
		user_list.remove(dto.getSub_host_id());
		dto.setUser_list(user_list);
		
		// GroupDTO 생성
		GroupDTO group_dto = new GroupDTO();
		group_dto.setGroup_name(dto.getGroup_name());
		group_dto.setGroup_description(dto.getGroup_description());
		group_dto.setProject_end_time(dto.getProject_end_time());
		group_dto.setGroup_id("rdEn0Ipu");
		
		// 유저 정보 생성
		UserDTO host_info = service.groupHostInfo(dto.getHost_id());	// 방장
		UserDTO sub_host_info = service.groupHostInfo(dto.getSub_host_id());	// 부방장
		
		List<UserDTO> user_info;
		dto.setUser_list(user_list);
		if (dto.getUser_list().size() == 0) {
			user_info = null;
		}
		else {
			user_info = service.groupUserInfo(dto);
		}
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("group_dto", group_dto);
		mv.addObject("host_info", host_info);
		mv.addObject("sub_host_info", sub_host_info);
		mv.addObject("user_info", user_info);
		mv.addObject("group_id", "rdEn0Ipu");
		mv.setViewName("group/group_create_success_test");
		return mv;
	}
}
