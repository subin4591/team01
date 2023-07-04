package schedule;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import dto.UserDTO;

@Controller
public class scheduleController {
	
	@Autowired
	private scheduleService scheduleService;
	
	@RequestMapping("/schedule")
	public String start() throws Exception {
		//db테스투
		List<UserDTO> list = scheduleService.selectUser();
		System.out.println(list.get(0).getAddress());
		
		return "schedule/schedule";
	}
}
