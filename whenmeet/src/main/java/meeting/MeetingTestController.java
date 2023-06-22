package meeting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MeetingTestController {
	@Autowired
	@Qualifier("meetingservice")
	MeetingService service;
	
	@RequestMapping("/meeting/test")
	public ModelAndView meetingTest() {
		String user_id = service.getApp();
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("user_id", user_id);
		mv.setViewName("meeting/meeting_test");
		return mv;
	}
}
