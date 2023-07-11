package schedule;

import java.util.*;
import java.text.SimpleDateFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import dto.UserDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import dto.GroupDTO;
import dto.GroupUserDTO;
import dto.MeetingScheduleDTO;

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
		
		//그룹 별 일정표 데이터	
		List<MeetingScheduleDTO> tableList = new ArrayList<MeetingScheduleDTO>();
		map.put("group_id", groupId);
		map.put("showView", 1);
		int tableListCnt = 1;	
		tableList= scheduleService.selectMeetingScheduleAllShow(map);
		if (scheduleService.selectMeetingScheduleAllShowCnt(map) >0) {
			tableListCnt = tableList.size();
			String[] tableListStart = new String[tableListCnt];
			String[] tableListLast = new String[tableListCnt];
			int[] tableListSeq = new int[tableListCnt];
			for (int i = 0; i < tableList.size(); i++) {
				tableListStart[i] = tableList.get(i).getFirst_date();
				tableListLast[i] = tableList.get(i).getLast_date();
				tableListSeq[i] = tableList.get(i).getSeq();
			}
			request.setAttribute("tableListLast", tableListLast);
			request.setAttribute("tableListStart", tableListStart);
			request.setAttribute("tableListSeq", tableListSeq);
		}
		request.setAttribute("tableListCnt", tableListCnt);
		
		//그룹 당 설정된 날짜
		Date today = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.setTime(today);
		cal.add(Calendar.DATE, 6);
		String startDate = format.format(today);
		String endDate = format.format(cal.getTime());
		
		if(scheduleService.selectMeetingScheduleDateCnt(groupId) > 0) {
			startDate 
			= scheduleService.selectMeetingScheduleDate(groupId).getSet_date1();
			endDate 
			= scheduleService.selectMeetingScheduleDate(groupId).getSet_date2();
		}
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		
		request.setAttribute("userId", userId);
		
		model.addAttribute("userId", userId);		
		model.addAttribute("groupName", groupName);
		model.addAttribute("groupCreateTime", groupCreateTime);
		model.addAttribute("ProjectEndTime", ProjectEndTime);
		model.addAttribute("groupDescription", groupDescription);
		
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
	
	@RequestMapping("/schedule/{groupId}/tableUpdate")
	public String updateTable(@PathVariable("groupId") String groupId, 
			@RequestParam("start") String start,
			@RequestParam("end") String end,
			@RequestParam("data") String data,
			HttpServletRequest request) throws Exception {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("set_date1", start);
		map.put("set_date2", end);
		map.put("group_id", groupId);
		if(scheduleService.selectMeetingScheduleDateCnt(groupId) > 0) {
			scheduleService.updateMeetingScheduleDate(map);
		}else {
			scheduleService.insertMeetingScheduleDate(map);
		}
		String[] datas = data.split("\\*");
		
		String startWeekFirst = datas[0];
		String startWeekLast = datas[1];
		String WeeksCnt = datas[2];
		int WeeksCntInt = Integer.parseInt(WeeksCnt);
		
		Calendar cal1 = Calendar.getInstance();
		Calendar cal2 = Calendar.getInstance();
		
		cal1.set(Integer.parseInt(startWeekFirst.substring(0, 4)), 
				Integer.parseInt(startWeekFirst.substring(4, 6))-1, 
				Integer.parseInt(startWeekFirst.substring(6)));
		
		cal2.set(Integer.parseInt(startWeekLast.substring(0, 4)), 
				Integer.parseInt(startWeekLast.substring(4, 6))-1, 
				Integer.parseInt(startWeekLast.substring(6)));
		
		Date date1 = new Date();
		Date date2 = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		
		date1 = cal1.getTime();
		date2 = cal2.getTime();
		
		//그룹 생성일 (seq)
		Calendar cal3 = Calendar.getInstance();
				
		String createTime  = scheduleService.selectGroupOne(groupId).getGroup_create_time();
		createTime = createTime.split(" ")[0];
		int createTimeY = Integer.parseInt(createTime.split("-")[0]);
		int createTimeM = Integer.parseInt(createTime.split("-")[1]);
		int createTimeD = Integer.parseInt(createTime.split("-")[2]);
				
		cal3.set(createTimeY, createTimeM-1, createTimeD);
		cal3.add(Calendar.DATE, -cal3.get(Calendar.DAY_OF_WEEK)+1);	//일요일
				
		Date date3 = new Date();
		date3 = cal3.getTime();
		
		int [] seqList = new int[WeeksCntInt];		
		String [] startWeekFirstList = new String[WeeksCntInt];
		String [] startWeekLastList = new String[WeeksCntInt];
		
		for (int i = 0; i < WeeksCntInt; i++) {
			
			long diffDays = (date1.getTime()-date3.getTime())/(24*60*60*1000);

			int diffDay = Long.valueOf(diffDays).intValue();
			diffDay /= 7;
			seqList[i] = diffDay;
			startWeekFirstList[i] = format.format(date1);
			startWeekLastList[i] = format.format(date2);
			
			cal1.add( Calendar.DATE , 7);
			cal2.add( Calendar.DATE , 7);
			date1 = cal1.getTime();
			date2 = cal2.getTime();
		}
		
		MeetingScheduleDTO dto = new MeetingScheduleDTO();
		
		scheduleService.updateMeetingScheduleShowViewAllZero(groupId);
		
		for (int i = 0; i < WeeksCntInt; i++) {
			map.put("group_id", groupId);
			map.put("seq", seqList[i]);
			
			dto.setFirst_date(startWeekFirstList[i]);
			dto.setGroup_id(groupId);
			dto.setLast_date(startWeekLastList[i]);
			dto.setSeq(seqList[i]);
			dto.setShowView(1);
			
			if (scheduleService.selectMeetingScheduleCnt(map) != 0) {
				scheduleService.updateMeetingScheduleShowViewOne(map);
				
			}else {
				scheduleService.insertMeetingSchedule(dto);
			}
		}		
		
		return "redirect:";
	}
}
