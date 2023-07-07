package schedule;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import dto.UserDTO;

@Controller
public class scheduleController {
	
	@Autowired
	private scheduleService scheduleService;
	
	@RequestMapping("/schedule")
	public ModelAndView start() throws Exception {
		String location = scheduleService.location();
		ModelAndView mv = new ModelAndView();
		mv.addObject("location", location);
		mv.setViewName("schedule/schedule");
		//db테스투
		List<UserDTO> list = scheduleService.selectUser();
		System.out.println(list.get(0).getAddress());
		
		
		return mv;
	}
}
