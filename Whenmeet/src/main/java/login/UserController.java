package login;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {
	
	@GetMapping("/login")
	public String login() {
		return "/login/login_login";
	}
	
	@GetMapping("/signup")
	public String signup() {
		return "/login/login_join";
	}
	
	@GetMapping("/myinfo")
	public String myinfo() {
		return "/login/login_info";
	}
}
