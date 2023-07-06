package group;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.GroupCreateDTO;
import dto.GroupDTO;
import dto.GroupUserDTO;
import dto.UserDTO;

@Controller
public class GroupController {
	@Autowired
	@Qualifier("groupservice")
	GroupService service;
	
	@RequestMapping("/group/create")
	public ModelAndView groupCreate() {
		// 임시 data
		int seq = 10;
		String session_id = "member1";
		
		// 그룹 유저 목록 생성
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
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("host_info", host_info);
		mv.addObject("user_info", user_info);
		mv.setViewName("group/group_create");
		return mv;
	}
	
	@RequestMapping("/group/create/result")
	public ModelAndView groupCreateResult(GroupCreateDTO dto) {
		// 부방장 user_list에서 제거
		ArrayList<String> user_list = dto.getUser_list();
		user_list.remove(dto.getSub_host_id());
		dto.setUser_list(user_list);
		
		// GroupDTO 생성
		GroupDTO group_dto = new GroupDTO();
		group_dto.setGroup_name(dto.getGroup_name());
		group_dto.setGroup_description(dto.getGroup_description());
		
		// GroupUserDTO 생성
		GroupUserDTO gu = new GroupUserDTO();
		ArrayList<GroupUserDTO> gu_list = new ArrayList<>();
		
		// 방장
		gu.setUser_id(dto.getHost_id());
		gu.setHost(1);
		gu.setSub_host(0);
		gu_list.add(gu);
		
		// 부방장
		gu.setUser_id(dto.getSub_host_id());
		gu.setHost(0);
		gu.setSub_host(1);
		gu_list.add(gu);
		
		// 그외
		gu.setSub_host(0);
		for(int i = 0; i < user_list.size(); i++) {
			gu.setUser_id(user_list.get(i));
			gu_list.add(gu);
		}
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/group/create");
		return mv;
	}
}
