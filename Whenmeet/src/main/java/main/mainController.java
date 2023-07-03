package main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class mainController {
	
	@Autowired
	@Qualifier("mainservice")
	MainService service;

	@GetMapping("/")
	public ModelAndView start(){
		List<String> mygroup = service.myGroup("member1");
		List<String> mywrite= service.myWrite("member1");
		List<String> myapplication= service.myApplication("member1");
		List<String> ranklist= service.rankList();
		ModelAndView mv = new ModelAndView();
		mv.addObject("mygroup", mygroup);
		mv.addObject("mywrite", mywrite);
		mv.addObject("myapplication", myapplication);
		mv.addObject("ranklist", ranklist);
		mv.setViewName("main/main");
		return mv;
	}
	@GetMapping("/schedule")
	public String schedule() {
		return "schedule/schedule";
	}
}
