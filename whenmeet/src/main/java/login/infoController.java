package login;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
@Controller
public class infoController {
	@GetMapping("/info")
	public String start(){
		return "login/login_info"; 
	}
	
}
