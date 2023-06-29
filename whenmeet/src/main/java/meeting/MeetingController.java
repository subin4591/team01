package meeting;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.ApplicantDTO;
import dto.MeetingDTO;
import dto.MeetingPagingDTO;
import dto.UserDTO;
import jakarta.servlet.http.HttpSession;

@Controller
public class MeetingController {
	@Autowired
	@Qualifier("meetingservice")
	MeetingService service;
	
	@Autowired
	@Qualifier("meetingetcservice")
	MeetingEtcService etcService;
	
	
	@RequestMapping("/meeting")
	public ModelAndView meeting(@RequestParam(value="category", defaultValue="all") String category, HttpSession session) {
		// ModelAndView 생성
		ModelAndView mv = new ModelAndView();
		
		// banner HashMap 생성
		HashMap<String, MeetingDTO> bannerMap = etcService.makeBanner();
		mv.addObject("all_banner", bannerMap.get("all"));
		mv.addObject("exercise_banner", bannerMap.get("exercise"));
		mv.addObject("hobby_banner", bannerMap.get("hobby"));
		mv.addObject("study_banner", bannerMap.get("study"));
		mv.addObject("etc_banner", bannerMap.get("etc"));
		
		// 게시글 목록 생성
		String sort = "time";	// 기본 정렬 : 최신순
		int page = 1;	// 기본 페이지 : 1 page
		List<MeetingDTO> meeting_list = etcService.getMeetingList(category, sort, page);
		
		// 게시글 개수
		int total_cnt = etcService.getMeetingCount(category);
		
		mv.addObject("category", category);
		mv.addObject("sort", sort);
		mv.addObject("page", page);
		mv.addObject("total_cnt", total_cnt);
		mv.addObject("div_num", 10);
		mv.addObject("meeting_list", meeting_list);
		mv.setViewName("meeting/meeting_category");
		
		return mv;
	}
	
	@RequestMapping("/meetingSort")
	@ResponseBody
	public HashMap<String, Object> meetingSort(String category, String sort) {
		// 게시글 목록 생성
		List<MeetingDTO> meeting_list = etcService.getMeetingList(category, sort, 1);
		
		// 게시글 개수
		int total_cnt = etcService.getMeetingCount(category);
		
		// JSON 형태 반환
		HashMap<String, Object> map = new HashMap<>();
		map.put("meeting_list", meeting_list);
		map.put("total_cnt", total_cnt);
		map.put("div_num", 10);
		return map;
	}
	
	@RequestMapping("/meetingPage")
	@ResponseBody
	public List<MeetingDTO> meetingPage(String category, String sort, int page) {
		// 게시글 목록 생성
		List<MeetingDTO> meeting_list = etcService.getMeetingList(category, sort, page);
		
		return meeting_list;
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
	public ModelAndView meetingDetailed(int seq, HttpSession session) {
		// MeetingDTO 생성
		MeetingDTO dto = service.meetingDetailed(seq);
		
		// 조회수 증가
		service.updateMeetingHits(seq);
		
		// 로그인 유저 정보
		String session_id = (String)session.getAttribute("session_id");
		UserDTO user_dto = service.userInfo(session_id);
		
		// 신청 댓글 목록 페이징 작업
		String sort = "time";
		int page = 1;
		int total_cnt = service.applicantCount(seq);
		List<ApplicantDTO> app_list = etcService.getApplicantList(seq, page);
		
		// 신청 댓글 중복 확인
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		page_dto.setSeq(seq);
		page_dto.setUser_id(session_id);
		
		int user_app_cnt = service.applicantUserCount(page_dto);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("dto", dto);
		mv.addObject("user_dto", user_dto);
		mv.addObject("sort", sort);
		mv.addObject("page", page);
		mv.addObject("total_cnt", total_cnt);
		mv.addObject("div_num", 10);
		mv.addObject("app_list", app_list);
		mv.addObject("user_app_cnt", user_app_cnt);
		mv.setViewName("meeting/meeting_detailed");
		return mv;
	}
	
	@RequestMapping("/meeting/applicantInsert")
	public String meetingApplicantInsert(ApplicantDTO app_dto) {
		// 신청 댓글의 게시글 번호
		int seq = app_dto.getSeq();
		
		// 신청 댓글 insert
		service.insertApplicantTable(app_dto);
		
		// 게시글 신청자수 update
		service.updateMeetingApp(seq);
		
		return "redirect:/meeting/detailed?seq=" + seq;
	}
	
	@RequestMapping("/applicantSort")
	@ResponseBody
	public HashMap<String, Object> applicantSort(int seq) {
		// 신청 댓글 목록 생성
		List<ApplicantDTO> app_list = etcService.getApplicantList(seq, 1);
		
		// 게시글 개수
		int total_cnt = service.applicantCount(seq);
		
		// JSON 형태 반환
		HashMap<String, Object> map = new HashMap<>();
		map.put("app_list", app_list);
		map.put("total_cnt", total_cnt);
		map.put("div_num", 10);
		
		return map;
	}
	
	@RequestMapping("/applicantMy")
	@ResponseBody
	public ApplicantDTO applicantMy(int seq, String user_id) {
		// 유저 신청 댓글 생성
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		page_dto.setSeq(seq);
		page_dto.setUser_id(user_id);
		ApplicantDTO app = service.applicantOneUser(page_dto);
		
		if (app == null) {
			app = new ApplicantDTO();
			app.setUser_id("none");
		}
		
		return app;
	}
	
	@RequestMapping("/applicantPage")
	@ResponseBody
	public List<ApplicantDTO> applicantPage(int seq, int page) {
		return etcService.getApplicantList(seq, page);
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
	
	@RequestMapping("/meeting/my")
	public ModelAndView meetingMy(@RequestParam(value="category", defaultValue="all") String category, HttpSession session) {
		// ModelAndView 생성
		ModelAndView mv = new ModelAndView();
		
		// user_dto 생성
		String user_id = (String)session.getAttribute("session_id");
		UserDTO user_dto = service.userInfo(user_id);
		mv.addObject("user_dto", user_dto);
		
		// 게시글 목록 생성
		String sort = "time";
		int page = 1;
		List<MeetingDTO> meeting_list = etcService.getMeetingList(category, sort, page, user_id);
		
		// 게시글 개수
		int total_cnt = etcService.getMeetingCount(category, user_id);
		
		mv.addObject("category", category);
		mv.addObject("sort", sort);
		mv.addObject("page", page);
		mv.addObject("total_cnt", total_cnt);
		mv.addObject("div_num", 10);
		mv.addObject("meeting_list", meeting_list);
		mv.setViewName("meeting/meeting_my");
		
		return mv;
	}
	
	@RequestMapping("/meetingMySort")
	@ResponseBody
	public HashMap<String, Object> meetingMySort(String category, String sort, String user_id) {
		// 게시글 목록 생성
		List<MeetingDTO> meeting_list = etcService.getMeetingList(category, sort, 1, user_id);
		
		// 게시글 개수
		int total_cnt = etcService.getMeetingCount(category, user_id);
		
		// JSON 형태 반환
		HashMap<String, Object> map = new HashMap<>();
		map.put("meeting_list", meeting_list);
		map.put("total_cnt", total_cnt);
		map.put("div_num", 10);
		return map;
	}
	
	@RequestMapping("/meetingMyPage")
	@ResponseBody
	public List<MeetingDTO> meetingMyPage(String category, String sort, int page, String user_id) {
		// 게시글 목록 생성
		List<MeetingDTO> meeting_list = etcService.getMeetingList(category, sort, page, user_id);
		
		return meeting_list;
	}
}