package meeting;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import dto.MeetingDTO;
import dto.MeetingPagingDTO;
import dto.UserDTO;
import jakarta.servlet.http.HttpSession;

@Controller
public class MeetingController {
	@Autowired
	@Qualifier("meetingservice")
	MeetingService service;
	
	@RequestMapping("/meeting")
	public ModelAndView meeting(@RequestParam(value="sort", defaultValue="time") String sort,
			@RequestParam(value="page", defaultValue="1") int page,
			HttpSession session) {
		// MeetingPagingDTO 생성
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		
		int total_cnt = service.meetingCountAll();
		int div_num = 5;
		
		if (sort.equals("time")) {
			page_dto.setSort_type("writing_time");
			sort = "time";
		}
		else if(sort.equals("appl")) {
			page_dto.setSort_type("applicant_cnt");
			sort = "appl";
		}
		else if(sort.equals("hits")) {
			page_dto.setSort_type(sort);
		}
		
		page_dto.setStart((page - 1) * div_num);
		page_dto.setEnd(div_num);
		
		// meeting_list 생성
		List<MeetingDTO> meeting_list = service.meetingListAll(page_dto);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("meeting_list", meeting_list);
		mv.addObject("sort", sort);
		mv.addObject("page", page);
		mv.addObject("total_cnt", total_cnt);
		mv.addObject("div_num", div_num);
		mv.setViewName("meeting/meeting");
		return mv;
	}
	
	@RequestMapping("/meeting/write")
	public ModelAndView meetingWrite(HttpSession session) {
		// UserDTO 생성
		String user_id = (String)session.getAttribute("session_id");
		UserDTO user_dto = service.userInfo(user_id);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("user_dto", user_dto);
		mv.setViewName("meeting/meeting_write");
		return mv;
	}
	
	@RequestMapping("/meeting/write/result")
	public ModelAndView meetingWriteResult(MeetingDTO meeting_dto) {
		service.insertMeetingTable(meeting_dto);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/meeting");
		return mv;
	}
	
	@RequestMapping("/meeting/detailed")
	public ModelAndView meetingDetailed(int seq) {
		// MeetingDTO 생성
		MeetingDTO dto = service.meetingDetailed(seq);
		
		// 조회수 증가
		service.updateMeetingHits(seq);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("dto", dto);
		mv.setViewName("meeting/meeting_detailed");
		return mv;
	}
	
	@RequestMapping("/meeting/change")
	public ModelAndView meetingChange(int seq) {
		// MeetingDTO 생성
		MeetingDTO dto = service.meetingDetailed(seq);
				
		ModelAndView mv = new ModelAndView();
		mv.addObject("dto", dto);
		mv.setViewName("meeting/meeting_change");
		return mv;
	}
	
	@RequestMapping("/meeting/change/result")
	public ModelAndView meetingChangeResult(MeetingDTO meeting_dto) {
		service.updateMeetingContents(meeting_dto);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/meeting");
		return mv;
	}
}