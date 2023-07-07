package schedule;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import dto.UserDTO;
import dto.GroupDTO;
import dto.GroupUserDTO;

@Controller
public class scheduleController {
	
	@Autowired
	private scheduleService scheduleService;
	
	@RequestMapping(value = {"/schedule", "/schedule/"})
	public String start() throws Exception {

		return "schedule/scheduleError";
	}
	
	@RequestMapping("/schedule/{groupId}")
	public String start(@PathVariable("groupId") String groupId, Model model) throws Exception {

		List<UserDTO> userList = new ArrayList<UserDTO>();
		List<GroupDTO> groupList = new ArrayList<GroupDTO>();
		GroupDTO groupOne = new GroupDTO();
		List<GroupUserDTO> groupUserList = new ArrayList<GroupUserDTO>();
		
		userList = scheduleService.selectUser();
		groupList = scheduleService.selectGroup();
		groupOne = scheduleService.selectGroupOne(groupId);
		groupUserList = scheduleService.selectGroupUser();

		String groupName, groupCreateTime, ProjectEndTime, groupDescription;
		
		if (groupOne == null) {
			return "schedule/scheduleError";
			
		}else {
			groupName = groupOne.getGroup_name();
			
			groupCreateTime = groupOne.getGroup_create_time();
			groupCreateTime = groupCreateTime.split(" ")[0];
			
			ProjectEndTime = groupOne.getProject_end_time();
			if (ProjectEndTime != null)
				ProjectEndTime = ProjectEndTime.split(" ")[0];
			
			groupDescription = groupOne.getGroup_description();
		}
		
		
		model.addAttribute("groupName", groupName);
		model.addAttribute("groupCreateTime", groupCreateTime);
		model.addAttribute("ProjectEndTime", ProjectEndTime);
		model.addAttribute("groupDescription", groupDescription);
		
		return "schedule/schedule";
	}
}
