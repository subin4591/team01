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
import dto.WriterModeDTO;
import jakarta.servlet.http.HttpSession;

@Controller
public class MeetingController {
	@Autowired
	@Qualifier("meetingservice")
	MeetingService service;
	
	@Autowired
	@Qualifier("meetingetcservice")
	MeetingEtcService etcService;
	
	int div_num = 10;
	
	
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
		List<MeetingDTO> meeting_list = etcService.getMeetingList(category, "time", 1);
		
		// 게시글 개수
		int total_cnt = service.meetingCount(etcService.convertCategory(category));
		
		mv.addObject("category", category);
		mv.addObject("total_cnt", total_cnt);
		mv.addObject("div_num", div_num);
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
		
		if (user_id != null) {
			mv.addObject("user_dto", user_dto);
			mv.setViewName("meeting/meeting_write");			
		}
		else {
			mv.setViewName("group/group_do_login");
		}
		
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
		int total_cnt = service.applicantCount(seq);
		List<ApplicantDTO> app_list = etcService.getApplicantList(seq, 1);
		
		// 신청 댓글 중복 확인
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		page_dto.setSeq(seq);
		page_dto.setUser_id(session_id);
		
		int user_app_cnt = service.applicantUserCount(page_dto);
		
		// writer mode 신청 댓글 목록 페이징 작업
		int total_cnt_wt = etcService.getApplicantCount(seq, "yet");
		List<ApplicantDTO> app_list_wt = etcService.getApplicantList(seq, 1, "yet");
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("dto", dto);
		mv.addObject("user_dto", user_dto);
		mv.addObject("total_cnt", total_cnt);
		mv.addObject("total_cnt_wt", total_cnt_wt);
		mv.addObject("div_num", div_num);
		mv.addObject("app_list", app_list);
		mv.addObject("app_list_wt", app_list_wt);
		mv.addObject("user_app_cnt", user_app_cnt);
		if (dto == null) {
			mv.setViewName("schedule/scheduleError");
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
		
		// 신청 댓글 개수
		int total_cnt = service.applicantCount(seq);
		
		// data 전송
		HashMap<String, Object> map = new HashMap<>();
		map.put("app_list", app_list);
		map.put("total_cnt", total_cnt);
		map.put("div_num", div_num);
		
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
		
		// 신청 댓글 개수
		int total_cnt = service.applicantCount(seq);
		
		// data 전송
		HashMap<String, Object> map = new HashMap<>();
		map.put("app_list", app_list);
		map.put("total_cnt", total_cnt);
		map.put("div_num", div_num);
		
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
	
	@RequestMapping("/meeting/writerModeOk")
	@ResponseBody
	public HashMap<String, Object> writerModeOk(WriterModeDTO dto) {
		int seq = dto.getSeq();
		String sort = "yet";
		dto.setApproval("승인");
		
		// 승인
		service.updateApproval(dto);
		
		// 신청 목록
		List<ApplicantDTO> app_list = etcService.getApplicantList(seq, 1, sort);
		
		// 결과
		HashMap<String, Object> map = new HashMap<>();
		map.put("total_cnt", etcService.getApplicantCount(seq, sort));
		map.put("div_num", div_num);
		map.put("app_list", app_list);
		
		return map;
	}
	
	@RequestMapping("/meeting/writerModeRe")
	@ResponseBody
	public HashMap<String, Object> writerModeRe(WriterModeDTO dto) {
		int seq = dto.getSeq();
		String sort = "yet";
		dto.setApproval("대기");
		
		// 승인
		service.updateApproval(dto);
		
		// 신청 목록
		List<ApplicantDTO> app_list = etcService.getApplicantList(seq, 1, sort);
		
		// 결과
		HashMap<String, Object> map = new HashMap<>();
		map.put("total_cnt", etcService.getApplicantCount(seq, sort));
		map.put("div_num", div_num);
		map.put("app_list", app_list);
		
		return map;
	}
	
	@RequestMapping("/meeting/writerModeSort")
	@ResponseBody
	public HashMap<String, Object> writerModeSort(int seq, String sort) {
		// 신청 목록
		List<ApplicantDTO> app_list = etcService.getApplicantList(seq, 1, sort);
		
		// 총 개수
		int total_cnt = etcService.getApplicantCount(seq, sort);
		
		// 결과
		HashMap<String, Object> map = new HashMap<>();
		map.put("total_cnt", total_cnt);
		map.put("div_num", div_num);
		map.put("app_list", app_list);
		return map;
	}
	
	@RequestMapping("/meeting/writerModePage")
	@ResponseBody
	public List<ApplicantDTO> writerModePage(int seq, String sort, int page) {
		return etcService.getApplicantList(seq, page, sort);
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
		mv.setViewName("redirect:/meeting/detailed?seq=" + meeting_dto.getSeq());
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
	
	@RequestMapping("/meeting/detailed/stopApp")
	public String meetingDetailedStopApp(int seq) {
		// HashMap 생성
		HashMap<String, Object> map = new HashMap<>();
		map.put("end", "대기");
		map.put("seq", seq);
		
		// 모집글 대기 상태로 변경
		service.updateEnd(map);
		
		return "redirect:/meeting/detailed?seq=" + seq;
	}
	
	@RequestMapping("/meeting/my")
	public ModelAndView meetingMy(@RequestParam(value="category", defaultValue="all") String category, HttpSession session) {
		// ModelAndView 생성
		ModelAndView mv = new ModelAndView();
		
		// user_dto 생성
		String user_id = (String)session.getAttribute("session_id");
		UserDTO user_dto = service.userInfo(user_id);
		mv.addObject("user_dto", user_dto);
		
		if (user_id != null) {
			// 게시글 목록 생성
			List<MeetingDTO> meeting_list;
			int total_cnt = 0;
			if (category.equals("notfinish") || category.equals("yetfinish") || category.equals("finish")) {
				meeting_list = etcService.getMeetingList(category, "open", 1, user_id);
				total_cnt = etcService.getMeetingCount(category, "open", user_id);
			}
			else {
				meeting_list = etcService.getMeetingList(category, "time", 1, user_id);
				total_cnt = etcService.getMeetingCount(category, "time", user_id);
			}
			
			mv.addObject("category", category);
			mv.addObject("total_cnt", total_cnt);
			mv.addObject("div_num", div_num);
			mv.addObject("meeting_list", meeting_list);
			mv.setViewName("meeting/meeting_my");			
		}
		else {
			mv.setViewName("group/group_do_login");
		}
		
		return mv;
	}
	
	@RequestMapping("/meeting/meetingMySort")
	@ResponseBody
	public HashMap<String, Object> meetingMySort(String category, String sort, String user_id) {
		// 게시글 목록
		List<MeetingDTO> meeting_list = etcService.getMeetingList(category, sort, 1, user_id);
		int total_cnt = etcService.getMeetingCount(category, sort, user_id);
		
		// 결과
		HashMap<String, Object> map = new HashMap<>();
		map.put("meeting_list", meeting_list);
		map.put("total_cnt", total_cnt);
		map.put("div_num", div_num);
		return map;
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
		
		if (user_id != null) {
			// 게시글 목록 생성
			ArrayList<Integer> seq_list;
			List<MeetingDTO> meeting_list;
			int total_cnt = 0;
			
			if (category.equals("result")) {
				MeetingPagingDTO page_dto = new MeetingPagingDTO();
				page_dto.setUser_id(user_id);
				page_dto.setSort_type("승인");
				
				seq_list = new ArrayList<>(service.userAppSeqListResult(page_dto));
				
				if (seq_list.size() != 0) {
					meeting_list = etcService.getMeetingList("all", "time", 1, seq_list);
				}
				else {
					meeting_list = null;
				}
				total_cnt = seq_list.size();
			}
			else {
				seq_list = new ArrayList<>(service.userAppSeqList(user_id));
				meeting_list = etcService.getMeetingList(category, "time", 1, seq_list);
				total_cnt = etcService.getMeetingCount(category, seq_list);
			}
			
			mv.addObject("category", category);
			mv.addObject("total_cnt", total_cnt);
			mv.addObject("div_num", div_num);
			mv.addObject("meeting_list", meeting_list);
			mv.setViewName("meeting/meeting_myapp");
		}
		else {
			mv.setViewName("group/group_do_login");
		}
		
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
		ArrayList<Integer> seq_list;
		List<MeetingDTO> meeting_list;
		
		if (category.equals("result")) {
			MeetingPagingDTO page_dto = new MeetingPagingDTO();
			page_dto.setUser_id(user_id);
			page_dto.setSort_type(etcService.convertSort(sort));
			
			seq_list = new ArrayList<>(service.userAppSeqListResult(page_dto));
			
			if (seq_list.size() != 0) {
				meeting_list = etcService.getMeetingList("all", "time", page, seq_list);
			}
			else {
				meeting_list = null;
			}
		}
		else {
			seq_list = new ArrayList<>(service.userAppSeqList(user_id));
			meeting_list = etcService.getMeetingList(category, sort, page, seq_list);
		}
		
		return meeting_list;
	}
	
	@RequestMapping("/meeting/meetingMyAppResultSort")
	@ResponseBody
	public HashMap<String, Object> meetingMyAppResultSort(String category, String sort, String user_id) {
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
		map.put("div_num", div_num);
		
		return map;
	}
}