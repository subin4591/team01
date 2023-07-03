package meeting;

import java.util.ArrayList;
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
	
	@RequestMapping("/meeting/meetingSort")
	@ResponseBody
	public List<MeetingDTO> meetingSort(String category, String sort) {
		return etcService.getMeetingList(category, sort, 1);
	}
	
	@RequestMapping("/meeting/meetingPage")
	@ResponseBody
	public List<MeetingDTO> meetingPage(String category, String sort, int page) {
		return etcService.getMeetingList(category, sort, page);
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
		if (dto == null) {
			mv.setViewName("meeting/meeting_not_found");
		}
		else {
			mv.setViewName("meeting/meeting_detailed");
		}
		return mv;
	}
	
	@RequestMapping("/meeting/applicantInsert")
	@ResponseBody
	public HashMap<String, Object> meetingApplicantInsert(ApplicantDTO app_dto) {
		// 신청 댓글의 게시글 번호
		int seq = app_dto.getSeq();
		
		// 신청 댓글 insert
		service.insertApplicantTable(app_dto);
		
		// 게시글 신청자수 증가
		etcService.setApplicantCnt(seq, 1);
		
		// 게시글 목록 update
		List<ApplicantDTO> app_list = etcService.getApplicantList(seq, 1);
		
		// 게시글 개수
		int total_cnt = service.applicantCount(seq);
		
		// data 전송
		HashMap<String, Object> map = new HashMap<>();
		map.put("app_list", app_list);
		map.put("total_cnt", total_cnt);
		map.put("div_num", 10);
		
		return map;
	}
	
	@RequestMapping("/meeting/applicantChange")
	@ResponseBody
	public ApplicantDTO meetingApplicantChange(ApplicantDTO app_dto) {
		int seq = app_dto.getSeq();
		String user_id = app_dto.getUser_id();
		
		// 유저 신청 댓글 수정
		service.updateAppContents(app_dto);
		
		// 유저 신청 댓글 생성
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		page_dto.setSeq(seq);
		page_dto.setUser_id(user_id);
		
		return service.applicantOneUser(page_dto);
	}
	
	@RequestMapping("/meeting/applicantDelete")
	@ResponseBody
	public HashMap<String, Object> meetingApplicantDelete(int seq, String user_id) {
		// 신청 댓글 delete
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		page_dto.setSeq(seq);
		page_dto.setUser_id(user_id);
		service.deleteAppOne(page_dto);
		
		// 게시글 신청자수 감소
		etcService.setApplicantCnt(seq, -1);
		
		// 게시글 목록 update
		List<ApplicantDTO> app_list = etcService.getApplicantList(seq, 1);
		
		// 게시글 개수
		int total_cnt = service.applicantCount(seq);
		
		// data 전송
		HashMap<String, Object> map = new HashMap<>();
		map.put("app_list", app_list);
		map.put("total_cnt", total_cnt);
		map.put("div_num", 10);
		
		return map;
	}
	
	@RequestMapping("/meeting/applicantSort")
	@ResponseBody
	public List<ApplicantDTO> applicantSort(int seq) {
		return etcService.getApplicantList(seq, 1);
	}
	
	@RequestMapping("/meeting/applicantMy")
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
	
	@RequestMapping("/meeting/applicantPage")
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
	
	@RequestMapping("/meeting/delete")
	public String meetingDelete(int seq) {
		// 게시글 삭제
		service.deleteMeeting(seq);
		
		// 게시글 삭제 후 신청댓글 삭제
		service.deleteAppAll(seq);
		
		return "redirect:/meeting";
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
	
	@RequestMapping("/meeting/meetingMySort")
	@ResponseBody
	public List<MeetingDTO> meetingMySort(String category, String sort, String user_id) {
		return etcService.getMeetingList(category, sort, 1, user_id);
	}
	
	@RequestMapping("/meeting/meetingMyPage")
	@ResponseBody
	public List<MeetingDTO> meetingMyPage(String category, String sort, int page, String user_id) {
		return etcService.getMeetingList(category, sort, page, user_id);
	}
	
	@RequestMapping("/meeting/myapp")
	public ModelAndView meetingMyApp(@RequestParam(value="category", defaultValue="all") String category, HttpSession session) {
		// ModelAndView 생성
		ModelAndView mv = new ModelAndView();
		
		// user_dto 생성
		String user_id = (String)session.getAttribute("session_id");
		UserDTO user_dto = service.userInfo(user_id);
		mv.addObject("user_dto", user_dto);
		
		// 게시글 목록 생성
		ArrayList<Integer> seq_list = new ArrayList<>(service.userAppSeqList(user_id));
		
		String sort = "time";
		int page = 1;
		List<MeetingDTO> meeting_list = etcService.getMeetingList(category, sort, page, seq_list);
		
		// 게시글 개수
		int total_cnt = etcService.getMeetingCount(category, seq_list);
		
		mv.addObject("category", category);
		mv.addObject("sort", sort);
		mv.addObject("page", page);
		mv.addObject("total_cnt", total_cnt);
		mv.addObject("div_num", 10);
		mv.addObject("meeting_list", meeting_list);
		mv.setViewName("meeting/meeting_myapp");
		
		return mv;
	}
	
	@RequestMapping("/meeting/meetingMyAppSort")
	@ResponseBody
	public List<MeetingDTO> meetingMyAppSort(String category, String sort, String user_id) {
		// 게시글 목록 생성
		ArrayList<Integer> seq_list = new ArrayList<>(service.userAppSeqList(user_id));
		
		return etcService.getMeetingList(category, sort, 1, seq_list);
	}
	
	@RequestMapping("/meeting/meetingMyAppPage")
	@ResponseBody
	public List<MeetingDTO> meetingMyAppPage(String category, String sort, int page, String user_id) {
		// 게시글 목록 생성
		ArrayList<Integer> seq_list = new ArrayList<>(service.userAppSeqList(user_id));
				
		return etcService.getMeetingList(category, sort, 1, seq_list);
	}
	
	@RequestMapping("/meeting/myapp/result")
	public ModelAndView meetingMyAppResult(HttpSession session) {
		// ModelAndView 생성
		ModelAndView mv = new ModelAndView();
		
		// user_dto 생성
		String user_id = (String)session.getAttribute("session_id");
		UserDTO user_dto = service.userInfo(user_id);
		mv.addObject("user_dto", user_dto);
		
		// 게시글 목록 생성
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		page_dto.setUser_id(user_id);
		page_dto.setSort_type("승인");
		
		ArrayList<Integer> seq_list = new ArrayList<>(service.userAppSeqListResult(page_dto));
		List<MeetingDTO> meeting_list;
		
		if (seq_list.size() != 0) {
			meeting_list = etcService.getMeetingList("all", "time", 1, seq_list);
		}
		else {
			meeting_list = null;
		}
		
		// 게시글 개수
		int total_cnt = seq_list.size();
		
		mv.addObject("sort", "yes");
		mv.addObject("page", 1);
		mv.addObject("total_cnt", total_cnt);
		mv.addObject("div_num", 10);
		mv.addObject("meeting_list", meeting_list);
		mv.setViewName("meeting/meeting_myapp_result");
		
		return mv;
	}
	
	@RequestMapping("/meeting/meetingMyAppResultSort")
	@ResponseBody
	public HashMap<String, Object> meetingMyAppResultSort(String sort, String user_id) {
		// 게시글 목록 생성
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		page_dto.setUser_id(user_id);
		page_dto.setSort_type(etcService.convertSort(sort));
		
		ArrayList<Integer> seq_list = new ArrayList<>(service.userAppSeqListResult(page_dto));
		List<MeetingDTO> meeting_list;
		
		if (seq_list.size() != 0) {
			meeting_list = etcService.getMeetingList("all", "time", 1, seq_list);
		}
		else {
			meeting_list = new ArrayList<>();
		}
		
		// 결과
		HashMap<String, Object> map = new HashMap<>();
		map.put("meeting_list", meeting_list);
		map.put("total_cnt", seq_list.size());
		map.put("div_num", 10);
		
		return map;
	}
	
	@RequestMapping("/meeting/meetingMyAppResultPage")
	@ResponseBody
	public List<MeetingDTO> meetingMyAppResultPage(String sort, int page, String user_id) {
		// 게시글 목록 생성
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		page_dto.setUser_id(user_id);
		page_dto.setSort_type(etcService.convertSort(sort));
		
		ArrayList<Integer> seq_list = new ArrayList<>(service.userAppSeqListResult(page_dto));
		List<MeetingDTO> meeting_list;
		
		if (seq_list.size() != 0) {
			meeting_list = etcService.getMeetingList("all", "time", page, seq_list);
		}
		else {
			meeting_list = null;
		}
				
		return meeting_list;
	}
}