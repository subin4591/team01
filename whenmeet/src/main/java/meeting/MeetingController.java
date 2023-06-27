package meeting;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	// banner 메소드
	public HashMap<String, MeetingDTO> makeBanner() {
		// banner MeetingPagingDTO 생성
		MeetingPagingDTO bannerPage = new MeetingPagingDTO();
		bannerPage.setSort_type("applicant_cnt");
		bannerPage.setStart(0);
		bannerPage.setEnd(1);
		
		// List 생성
		HashMap<String, MeetingDTO> bannerMap = new HashMap<>();
		
		// all banner
		bannerMap.put("all", service.meetingListAll(bannerPage).get(0));
		
		// exercise banner
		bannerPage.setCategory("운동");
		bannerMap.put("exercise", service.meetingListCategory(bannerPage).get(0));
		
		// hobby banner
		bannerPage.setCategory("취미");
		bannerMap.put("hobby", service.meetingListCategory(bannerPage).get(0));
		
		// study banner
		bannerPage.setCategory("공부");
		bannerMap.put("study", service.meetingListCategory(bannerPage).get(0));

		// etc banner
		bannerPage.setCategory("기타");
		bannerMap.put("etc", service.meetingListCategory(bannerPage).get(0));
		
		return bannerMap;
	}
	
	@RequestMapping("/meeting")
	public ModelAndView meeting(@RequestParam(value="category", defaultValue="all") String category,
			@RequestParam(value="sort", defaultValue="time") String sort,
			@RequestParam(value="page", defaultValue="1") int page,
			HttpSession session) {
		// ModelAndView 생성
		ModelAndView mv = new ModelAndView();
		
		// banner HashMap 생성
		HashMap<String, MeetingDTO> bannerMap = makeBanner();
		mv.addObject("all_banner", bannerMap.get("all"));
		mv.addObject("exercise_banner", bannerMap.get("exercise"));
		mv.addObject("hobby_banner", bannerMap.get("hobby"));
		mv.addObject("study_banner", bannerMap.get("study"));
		mv.addObject("etc_banner", bannerMap.get("etc"));
		
		// 게시글 목록 생성
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		
		// 글목록 정렬
		if (sort.equals("time")) {	// 최신순
			page_dto.setSort_type("writing_time");
			sort = "time";
		}
		else if(sort.equals("appl")) {	// 신청순
			page_dto.setSort_type("applicant_cnt");
			sort = "appl";
		}
		else if(sort.equals("hits")) {	// 조회순
			page_dto.setSort_type(sort);
		}
		
		// 페이징 작업
		int div_num = 10;	// 한 페이지당 글 개수
		page_dto.setStart((page - 1) * div_num);
		page_dto.setEnd(div_num);
		
		// 글 목록 생성
		int total_cnt = 0;	// 전체 글 개수
		List<MeetingDTO> meeting_list;	// 글 목록
		mv.addObject("category", category);	// 카테고리
		
		if (category.equals("all")) {
			total_cnt = service.meetingCountAll();
			meeting_list = service.meetingListAll(page_dto);
		}
		else {
			if (category.equals("exercise")) {
				category = "운동";
			}
			else if (category.equals("hobby")) {
				category = "취미";
			}
			else if (category.equals("study")) {
				category = "공부";
			}
			else {
				category = "기타";
			}
			page_dto.setCategory(category);
			total_cnt = service.meetingCountCategory(category);
			meeting_list = service.meetingListCategory(page_dto);
		}
		
		mv.addObject("sort", sort);
		mv.addObject("page", page);
		mv.addObject("total_cnt", total_cnt);
		mv.addObject("div_num", div_num);
		mv.addObject("meeting_list", meeting_list);
		mv.setViewName("meeting/meeting_category");
		
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
	
	@RequestMapping("/meeting/my")
	public ModelAndView meetingMy(@RequestParam(value="category", defaultValue="all") String category,
			@RequestParam(value="sort", defaultValue="time") String sort,
			@RequestParam(value="page", defaultValue="1") int page,
			HttpSession session) {
		// ModelAndView 생성
		ModelAndView mv = new ModelAndView();
		
		// user_dto 생성
		String user_id = (String)session.getAttribute("session_id");
		UserDTO user_dto = service.userInfo(user_id);
		mv.addObject("user_dto", user_dto);
		
		// 게시글 목록 생성
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		page_dto.setUser_id(user_id);
		
		// 글목록 정렬
		if (sort.equals("time")) {	// 최신순
			page_dto.setSort_type("writing_time");
			sort = "time";
		}
		else if(sort.equals("appl")) {	// 신청순
			page_dto.setSort_type("applicant_cnt");
			sort = "appl";
		}
		else if(sort.equals("hits")) {	// 조회순
			page_dto.setSort_type(sort);
		}
		
		// 페이징 작업
		int div_num = 10;	// 한 페이지당 글 개수
		page_dto.setStart((page - 1) * div_num);
		page_dto.setEnd(div_num);
		
		// 글 목록 생성
		int total_cnt = 0;	// 전체 글 개수
		List<MeetingDTO> meeting_list;	// 글 목록
		mv.addObject("category", category);	// 카테고리
		
		if (category.equals("all")) {
			total_cnt = service.meetingCountAllUser(user_id);
			meeting_list = service.meetingListAllUser(page_dto);
		}
		else {
			if (category.equals("exercise")) {
				category = "운동";
			}
			else if (category.equals("hobby")) {
				category = "취미";
			}
			else if (category.equals("study")) {
				category = "공부";
			}
			else {
				category = "기타";
			}
			page_dto.setCategory(category);
			total_cnt = service.meetingCountCategoryUser(page_dto);
			meeting_list = service.meetingListCategoryUser(page_dto);
		}
		
		mv.addObject("sort", sort);
		mv.addObject("page", page);
		mv.addObject("total_cnt", total_cnt);
		mv.addObject("div_num", div_num);
		mv.addObject("meeting_list", meeting_list);
		mv.setViewName("meeting/meeting_my");
		
		return mv;
	}
}