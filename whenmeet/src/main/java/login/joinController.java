package login;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
@Controller
public class joinController {
	@GetMapping("/join")
	public String start(){
		return "login/login_join"; 
	}
	
}
