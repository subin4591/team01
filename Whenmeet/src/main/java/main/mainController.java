package main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.MainDTO;

@Controller
public class mainController {
	
	@Autowired
	@Qualifier("mainservice")
	MainService service;

	@GetMapping("/")
	public ModelAndView start(String id){
		List<String> mygroup = service.myGroup(id);
		List<MainDTO> mywrite= service.myWrite(id);
		List<MainDTO> myapplication= service.myApplication(id);
		List<MainDTO> ranklist= service.rankList();
		ModelAndView mv = new ModelAndView();
		mv.addObject("id",id);
		mv.addObject("mygroup", mygroup);
		mv.addObject("mywrite", mywrite);
		mv.addObject("myapplication", myapplication);
		mv.addObject("ranklist", ranklist);
		mv.setViewName("main/main");
		return mv;
	}
	
}
