package meeting;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

@Controller
public class MeetingTestController {
	@Autowired
	@Qualifier("meetingservice")
	MeetingService service;
	
	@RequestMapping("/meeting/test")
	public String meetingTest() {
		return "meeting/meeting_test";
	}
	
	@RequestMapping("/meeting/test/login")
	public String meetingTestLogin(String id, HttpSession session) {
		session.setAttribute("session_id", id);
		return "redirect:/meeting/test";
	}
	
	@RequestMapping("/meeting/test/logout")
	public String meetingTestLogout(HttpSession session) {
		session.removeAttribute("session_id");
		return "redirect:/meeting/test";
	}
	
	@RequestMapping("/meeting/test/random")
	public String meetingTestRandom() {
		ArrayList<Integer> seqList = new ArrayList<>(service.testSelect1());
		ArrayList<String> timeList = new ArrayList<>(service.testSelect2());
		String[] userArr = {"hwang1", "moon2", "chae3", "kwon4",
				"member1", "member2", "member3", "member4", 
				"member5", "member6", "member7", "member8", "member9"};
		String[] dayArr = {"24", "25", "26", "27", "28", "29", "30", "1", "2", "3", "4", "5"};
		String[] hourArr = {"12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"};
		
		int num = 0, cnt = 0;
		
		for (int i = 0; i < seqList.size(); i++) {
			HashMap<String, Object> map = new HashMap<>();
			String time = "";
			
			map.put("seq", seqList.get(i));
			
			num = (int)(Math.random() * (userArr.length - 1));
			map.put("user_id", userArr[num]);
			
			num = (int)(Math.random() * 6);
			
			if (i < 11) {
				time = "2023-06-";
				if (i % 2 == 1) {
					time += dayArr[cnt++] + " ";
					time += hourArr[num + 6];
				}
				else {
					time += dayArr[cnt] + " ";
					time += hourArr[num];
				}
			}
			else {
				time = "2023-07-";
				if (i % 2 == 1) {
					time += dayArr[cnt++] + " ";
					time += hourArr[num + 6];
				}
				else {
					time += dayArr[cnt] + " ";
					time += hourArr[num];
				}
			}
			time += timeList.get(i).substring(13);
			
			map.put("writing_time", time);
			service.testUpdate(map);
		}
		return "redirect:/meeting/test";
	}
}
