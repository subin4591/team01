package main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.GroupDTO;
import dto.MainDTO;
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
		ModelAndView mv = new ModelAndView();
		mv.addObject("id",user_id);
		mv.addObject("mygroup", mygroup);
		mv.addObject("mywrite", mywrite);
		mv.addObject("myapplication", myapplication);
		mv.addObject("ranklist", ranklist);
		mv.setViewName("main/main");
		return mv;
	}
	@RequestMapping("/address")
	public void addressConfirm(String address,String group_id) {
		service.address(address, group_id);
	}
	
}
