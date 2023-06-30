package com.project.wm.login;


@Controller
public class UserController {
	
	@GetMapping("/myPage")
	public String myPage() {
		return "user/myPage";
	}
	
	@GetMapping("/login")
	public String login() {
		return "user/login";
	}
}
