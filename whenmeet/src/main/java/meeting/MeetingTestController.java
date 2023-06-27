package meeting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;

@Controller
public class MeetingTestController {
	@Autowired
	@Qualifier("meetingservice")
	MeetingService service;
	
	@RequestMapping("/meeting/test")
	public ModelAndView meetingTest() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("meeting/meeting_test");
		return mv;
	}
	
	@RequestMapping("/meeting/test/login")
	public ModelAndView meetingTestLogin(String id, HttpSession session) {
		session.setAttribute("session_id", id);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/meeting/test");
		return mv;
	}
	
	@RequestMapping("/meeting/test/logout")
	public ModelAndView meetingTestLogout(HttpSession session) {
		session.removeAttribute("session_id");
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/meeting/test");
		return mv;
	}
}
