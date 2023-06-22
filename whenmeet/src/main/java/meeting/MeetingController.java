package meeting;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MeetingController {
	@RequestMapping("/meeting")
	public ModelAndView meeting() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("meeting/meeting");
		return mv;
	}
}