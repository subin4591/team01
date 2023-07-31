package main;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import dto.GroupDTO;
import dto.MainDTO;
import dto.MeetingDTO;
import dto.MeetingPagingDTO;
import dto.ScheduleDTO;
import dto.UserDTO;
import jakarta.servlet.http.HttpSession;

@Controller
public class mainController {
	
	@Autowired
	@Qualifier("mainservice")
	MainService service;

	@GetMapping("/")
	@CrossOrigin(origins = "http://localhost:8065")
	public ModelAndView start(HttpSession session){
		String user_id = (String)session.getAttribute("session_id");
		List<GroupDTO> mygroup = service.myGroup(user_id);
		List<MainDTO> mywrite= service.myWrite(user_id);
		List<MainDTO> myapplication= service.myApplication(user_id);
		List<MainDTO> ranklist= service.rankList();
		List<ScheduleDTO> schedulelist = service.getSchedule(user_id);
		String json = new Gson().toJson(schedulelist);
		ModelAndView mv = new ModelAndView();
		mv.addObject("id",user_id);
		mv.addObject("mygroup", mygroup);
		mv.addObject("mywrite", mywrite);
		mv.addObject("myapplication", myapplication);
		mv.addObject("ranklist", ranklist);
		mv.addObject("sclist",json);
		mv.setViewName("main/main");
		return mv;
	}
	@RequestMapping("/address")
	public void addressConfirm(String address,String group_id) {
		service.address(address, group_id);
	}
	
	@RequestMapping("/scheduleAdd")
	public void scheduleAdd(String title,String start,String end,String address,String memo,String user_id) {
		service.scheduleAdd(user_id, start,end , title, address, memo);
	}
	@RequestMapping("/getscheduleone")
	@ResponseBody
	public Map<String, ScheduleDTO> getscheduleone(String title,String start,String end,String user_id) {
		if(start.substring(11).equals("00:00")) {
			start = start.substring(0, 10);
			end = end.substring(0,10);
		}
		Map<String, ScheduleDTO> data = new HashMap();
        data.put("schedule", service.getScheduleOne(user_id, start,end , title));
		return data;
	}
	@RequestMapping("/scheduledelete")
	public void scheduledelete(String title,String start,String end,String user_id) {
		service.scheduleDelete(user_id, start,end , title);
	}
	@RequestMapping("/schedulechange")
	public void schedulechange(String title,String start,String end,String address,String memo,String user_id
			,String p_title,String p_start,String p_end) {
		service.scheduleChange(title, start,end , address,memo,user_id,p_title,p_start,p_end);
	}
}
