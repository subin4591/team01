package schedule;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import dto.UserDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import dto.ChatDTO;
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
	
	@RequestMapping(value = {"/schedule/{groupId}", "/schedule/{groupId}/"})
	public String start(@PathVariable("groupId") String groupId, Model model, HttpSession session, HttpServletRequest request) throws Exception {
		
		String userId = (String) session.getAttribute("session_id");

		UserDTO user = scheduleService.selectUserOne(userId);
		model.addAttribute("username", user.getName());
		userId = "admin";	//나중에 꼭 지우기! 방장 아이디임
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("groupId", groupId);
		
		List<UserDTO> userList = new ArrayList<UserDTO>();
		UserDTO userOne = new UserDTO();
		List<GroupDTO> groupList = new ArrayList<GroupDTO>();
		GroupDTO groupOne = new GroupDTO();	
		List<GroupUserDTO> groupUserList = new ArrayList<GroupUserDTO>();	
		GroupUserDTO groupUserOne = new GroupUserDTO();
		List<GroupUserDTO> groupUsers = new ArrayList<GroupUserDTO>();
		
		
		userList = scheduleService.selectUser();
		userOne = scheduleService.selectUserOne(userId);
		groupList = scheduleService.selectGroup();
		groupOne = scheduleService.selectGroupOne(groupId);
		groupUserList = scheduleService.selectGroupUser();
		groupUserOne = scheduleService.selectGroupUserOne(map);
		groupUsers = scheduleService.selectGroupUsers(groupId);
		
		String location = scheduleService.getLocation(groupId);
		List<ChatDTO> chatlist = scheduleService.getChat(groupId);
		
		//그룹 정보 관련
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
		
		//그룹 별 회원정보 관련
		List<String> groupUserUserIdList = new ArrayList<String>();
		List<String> WhoHostList = new ArrayList<String>();
		List<String> WhoSubHostList = new ArrayList<String>();
		List<String> WhoMemberList = new ArrayList<String>();
		List<String>WhoSetScheduleList = new ArrayList<String>();
		List<String>WhoDontSetScheduleList = new ArrayList<String>();
		
		if (groupUsers == null) {
			return "schedule/scheduleError";			
		}else {
			for(int i = 0; i < groupUsers.size(); i++) {
				
				groupUserUserIdList.add(groupUsers.get(i).getUser_id());
				
				if (groupUsers.get(i).getHost() == 1 && groupUsers.get(i).getSub_host() == 0) {
					WhoHostList.add(groupUsers.get(i).getUser_id());
				}
				if (groupUsers.get(i).getHost() == 0 && groupUsers.get(i).getSub_host() == 1) {
					WhoSubHostList.add(groupUsers.get(i).getUser_id());
				}
				if (groupUsers.get(i).getHost() == 0 && groupUsers.get(i).getSub_host() == 0) {
					WhoMemberList.add(groupUsers.get(i).getUser_id());
				}
				if (groupUsers.get(i).getSet_schedule() == 1) {
					WhoSetScheduleList.add(groupUsers.get(i).getUser_id());
				}else {
					WhoDontSetScheduleList.add(groupUsers.get(i).getUser_id());
				}
			}
		}
		
		//모든 그룹 내 유저를 대상으로
		String[] groupAllUsersId = new String[groupUserUserIdList.size()];
		String[] groupAllUsersName = new String[groupUserUserIdList.size()];
		String[] groupAllUsersAddress = new String[groupUserUserIdList.size()];
		String[] groupAllUsersPhone = new String[groupUserUserIdList.size()];
		String[] groupAllUsersEmail = new String[groupUserUserIdList.size()];
		String[] groupAllUsersProfileUrl = new String[groupUserUserIdList.size()];
		
		for (int i = 0; i < groupUserUserIdList.size(); i++) {
			groupAllUsersId[i] = scheduleService.selectUserOne(groupUserUserIdList.get(i)).getUser_id();
			groupAllUsersName[i] = scheduleService.selectUserOne(groupUserUserIdList.get(i)).getName();
			groupAllUsersAddress[i] = scheduleService.selectUserOne(groupUserUserIdList.get(i)).getAddress();
			groupAllUsersPhone[i] = scheduleService.selectUserOne(groupUserUserIdList.get(i)).getPhone();
			groupAllUsersEmail[i] = scheduleService.selectUserOne(groupUserUserIdList.get(i)).getEmail();
			groupAllUsersProfileUrl[i] = scheduleService.selectUserOne(groupUserUserIdList.get(i)).getProfile_url();
		}
		request.setAttribute("groupAllUsersId", groupAllUsersId);		
		request.setAttribute("groupAllUsersName", groupAllUsersName);
		request.setAttribute("groupAllUsersAddress", groupAllUsersAddress);
		request.setAttribute("groupAllUsersPhone", groupAllUsersPhone);
		request.setAttribute("groupAllUsersEmail", groupAllUsersEmail);
		request.setAttribute("groupAllUsersProfileUrl", groupAllUsersProfileUrl);
		
		//방장인 맴버를 대상으로
		String[] groupHostUserId = new String[WhoHostList.size()];
		String[] groupHostUserName = new String[WhoHostList.size()];
		String[] groupHostUserAddress = new String[WhoHostList.size()];
		String[] groupHostUserPhone = new String[WhoHostList.size()];
		String[] groupHostUserEmail = new String[WhoHostList.size()];
		String[] groupHostUserProfileUrl = new String[WhoHostList.size()];
		
		for (int i = 0; i < WhoHostList.size(); i++) {
			groupHostUserId[i] = scheduleService.selectUserOne(WhoHostList.get(i)).getUser_id();
			groupHostUserName[i] = scheduleService.selectUserOne(WhoHostList.get(i)).getName();
			groupHostUserAddress[i] = scheduleService.selectUserOne(WhoHostList.get(i)).getAddress();
			groupHostUserPhone[i] = scheduleService.selectUserOne(WhoHostList.get(i)).getPhone();
			groupHostUserEmail[i] = scheduleService.selectUserOne(WhoHostList.get(i)).getEmail();
			groupHostUserProfileUrl[i] = scheduleService.selectUserOne(WhoHostList.get(i)).getProfile_url();
		}
		request.setAttribute("groupHostUserId", groupHostUserId);		
		request.setAttribute("groupHostUserName", groupHostUserName);
		request.setAttribute("groupHostUserAddress", groupHostUserAddress);
		request.setAttribute("groupHostUserPhone", groupHostUserPhone);
		request.setAttribute("groupHostUserEmail", groupHostUserEmail);
		request.setAttribute("groupHostUserProfileUrl", groupHostUserProfileUrl);
		
		//부방장인 맴버를 대상으로
		String[] groupSubHostUsersId = new String[WhoSubHostList.size()];
		String[] groupSubHostUsersName = new String[WhoSubHostList.size()];
		String[] groupSubHostUsersAddress = new String[WhoSubHostList.size()];
		String[] groupSubHostUsersPhone = new String[WhoSubHostList.size()];
		String[] groupSubHostUsersEmail = new String[WhoSubHostList.size()];
		String[] groupSubHostUsersProfileUrl = new String[WhoSubHostList.size()];
		
		for (int i = 0; i < WhoSubHostList.size(); i++) {
			groupSubHostUsersId[i] = scheduleService.selectUserOne(WhoSubHostList.get(i)).getUser_id();
			groupSubHostUsersName[i] = scheduleService.selectUserOne(WhoSubHostList.get(i)).getName();
			groupSubHostUsersAddress[i] = scheduleService.selectUserOne(WhoSubHostList.get(i)).getAddress();
			groupSubHostUsersPhone[i] = scheduleService.selectUserOne(WhoSubHostList.get(i)).getPhone();
			groupSubHostUsersEmail[i] = scheduleService.selectUserOne(WhoSubHostList.get(i)).getEmail();
			groupSubHostUsersProfileUrl[i] = scheduleService.selectUserOne(WhoSubHostList.get(i)).getProfile_url();
		}
		request.setAttribute("groupSubHostUsersId", groupSubHostUsersId);		
		request.setAttribute("groupSubHostUsersName", groupSubHostUsersName);
		request.setAttribute("groupSubHostUsersAddress", groupSubHostUsersAddress);
		request.setAttribute("groupSubHostUsersPhone", groupSubHostUsersPhone);
		request.setAttribute("groupSubHostUsersEmail", groupSubHostUsersEmail);
		request.setAttribute("groupSubHostUsersProfileUrl", groupSubHostUsersProfileUrl);
		
		//일반맴버를 대상으로
		String[] groupMemberUsersId = new String[WhoMemberList.size()];
		String[] groupMemberUsersName = new String[WhoMemberList.size()];
		String[] groupMemberUsersAddress = new String[WhoMemberList.size()];
		String[] groupMemberUsersPhone = new String[WhoMemberList.size()];
		String[] groupMemberUsersEmail = new String[WhoMemberList.size()];
		String[] groupMemberUsersProfileUrl = new String[WhoMemberList.size()];
		
		for (int i = 0; i < WhoMemberList.size(); i++) {
			groupMemberUsersId[i] = scheduleService.selectUserOne(WhoMemberList.get(i)).getUser_id();
			groupMemberUsersName[i] = scheduleService.selectUserOne(WhoMemberList.get(i)).getName();
			groupMemberUsersAddress[i] = scheduleService.selectUserOne(WhoMemberList.get(i)).getAddress();
			groupMemberUsersPhone[i] = scheduleService.selectUserOne(WhoMemberList.get(i)).getPhone();
			groupMemberUsersEmail[i] = scheduleService.selectUserOne(WhoMemberList.get(i)).getEmail();
			groupMemberUsersProfileUrl[i] = scheduleService.selectUserOne(WhoMemberList.get(i)).getProfile_url();
		}
		request.setAttribute("groupMemberUsersId", groupMemberUsersId);		
		request.setAttribute("groupMemberUsersName", groupMemberUsersName);
		request.setAttribute("groupMemberUsersAddress", groupMemberUsersAddress);
		request.setAttribute("groupMemberUsersPhone", groupMemberUsersPhone);
		request.setAttribute("groupMemberUsersEmail", groupMemberUsersEmail);
		request.setAttribute("groupMemberUsersProfileUrl", groupMemberUsersProfileUrl);
		
		//스케쥴을 입력한 맴버를 대상으로
		String[] groupSetScheduleUsersId = new String[WhoSetScheduleList.size()];
		String[] groupSetScheduleUsersName = new String[WhoSetScheduleList.size()];
		String[] groupSetScheduleUsersAddress = new String[WhoSetScheduleList.size()];
		String[] groupSetScheduleUsersPhone = new String[WhoSetScheduleList.size()];
		String[] groupSetScheduleUsersEmail = new String[WhoSetScheduleList.size()];
		String[] groupSetScheduleUsersProfileUrl = new String[WhoSetScheduleList.size()];
		
		for (int i = 0; i < WhoSetScheduleList.size(); i++) {
			groupSetScheduleUsersId[i] = scheduleService.selectUserOne(WhoSetScheduleList.get(i)).getUser_id();
			groupSetScheduleUsersName[i] = scheduleService.selectUserOne(WhoSetScheduleList.get(i)).getName();
			groupSetScheduleUsersAddress[i] = scheduleService.selectUserOne(WhoSetScheduleList.get(i)).getAddress();
			groupSetScheduleUsersPhone[i] = scheduleService.selectUserOne(WhoSetScheduleList.get(i)).getPhone();
			groupSetScheduleUsersEmail[i] = scheduleService.selectUserOne(WhoSetScheduleList.get(i)).getEmail();
			groupSetScheduleUsersProfileUrl[i] = scheduleService.selectUserOne(WhoSetScheduleList.get(i)).getProfile_url();
		}
		request.setAttribute("groupSetScheduleUsersId", groupSetScheduleUsersId);		
		request.setAttribute("groupSetScheduleUsersName", groupSetScheduleUsersName);
		request.setAttribute("groupSetScheduleUsersAddress", groupSetScheduleUsersAddress);
		request.setAttribute("groupSetScheduleUsersPhone", groupSetScheduleUsersPhone);
		request.setAttribute("groupSetScheduleUsersEmail", groupSetScheduleUsersEmail);
		request.setAttribute("groupSetScheduleUsersProfileUrl", groupSetScheduleUsersProfileUrl);
		
		//스케쥴을 입력하지 않은 맴버를 대상으로
		String[] groupDontSetScheduleUsersId = new String[WhoDontSetScheduleList.size()];
		String[] groupDontSetScheduleUsersName = new String[WhoDontSetScheduleList.size()];
		String[] groupDontSetScheduleUsersAddress = new String[WhoDontSetScheduleList.size()];
		String[] groupDontSetScheduleUsersPhone = new String[WhoDontSetScheduleList.size()];
		String[] groupDontSetScheduleUsersEmail = new String[WhoDontSetScheduleList.size()];
		String[] groupDontSetScheduleUsersProfileUrl = new String[WhoDontSetScheduleList.size()];
		
		for (int i = 0; i < WhoDontSetScheduleList.size(); i++) {
			groupDontSetScheduleUsersId[i] = scheduleService.selectUserOne(WhoDontSetScheduleList.get(i)).getUser_id();
			groupDontSetScheduleUsersName[i] = scheduleService.selectUserOne(WhoDontSetScheduleList.get(i)).getName();
			groupDontSetScheduleUsersAddress[i] = scheduleService.selectUserOne(WhoDontSetScheduleList.get(i)).getAddress();
			groupDontSetScheduleUsersPhone[i] = scheduleService.selectUserOne(WhoDontSetScheduleList.get(i)).getPhone();
			groupDontSetScheduleUsersEmail[i] = scheduleService.selectUserOne(WhoDontSetScheduleList.get(i)).getEmail();
			groupDontSetScheduleUsersProfileUrl[i] = scheduleService.selectUserOne(WhoDontSetScheduleList.get(i)).getProfile_url();
		}
		request.setAttribute("groupDontSetScheduleUsersId", groupDontSetScheduleUsersId);		
		request.setAttribute("groupDontSetScheduleUsersName", groupDontSetScheduleUsersName);
		request.setAttribute("groupDontSetScheduleUsersAddress", groupDontSetScheduleUsersAddress);
		request.setAttribute("groupDontSetScheduleUsersPhone", groupDontSetScheduleUsersPhone);
		request.setAttribute("groupDontSetScheduleUsersEmail", groupDontSetScheduleUsersEmail);
		request.setAttribute("groupDontSetScheduleUsersProfileUrl", groupDontSetScheduleUsersProfileUrl);		
		
		request.setAttribute("userId", userId);
		
		model.addAttribute("userId", userId);		
		model.addAttribute("groupName", groupName);
		model.addAttribute("groupCreateTime", groupCreateTime);
		model.addAttribute("ProjectEndTime", ProjectEndTime);
		model.addAttribute("groupDescription", groupDescription);
		model.addAttribute("location", location);
		model.addAttribute("groupId", groupId);
		model.addAttribute("chatlist", chatlist);
		
		return "schedule/schedule";
	}
	
	@RequestMapping("/schedule/{groupId}/update")
	public String updateSubHost(@PathVariable("groupId") String groupId, 
			String userId, 
			String subHost,
			Model model) throws Exception {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int subHostInt = Integer.parseInt(subHost);
		map.put("sub_host", subHostInt);
		map.put("group_id", groupId);
		map.put("user_id", userId);
		scheduleService.updateGroupUserSubHost(map);
		
		return "redirect:";
	}
	@RequestMapping("/schedule/{groupId}/addchat")
	@ResponseBody
	public void addchat(@PathVariable("groupId") String groupId, String userId, String text) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		UserDTO userOne = scheduleService.selectUserOne(userId);
		LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd HH:mm");

        String formattedTime = now.format(formatter);
        int hour = Integer.parseInt(formattedTime.substring(6,8));
        String time = "오전 ";
        if(hour > 12) {
        	hour = hour - 12;
        	time = "오후 ";
        }
        String now_time = formattedTime.substring(0,6) + time + hour + formattedTime.substring(8,11);

		map.put("group_id", groupId);
		map.put("name", userOne.getName());
		map.put("text", text);
		map.put("profile_url", userOne.getProfile_url());
		map.put("now", now_time);
		scheduleService.addCaht(map);
	}
}
