package schedule;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class scheduleController {
	@GetMapping("/schedule")
	public String start() {
		return "schedule/schedule";
	}
}
