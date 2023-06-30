package meeting;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dto.ApplicantDTO;
import dto.MeetingDTO;
import dto.MeetingPagingDTO;

@Service("meetingetcservice")
public class MeetingEtcService {
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
	
	// sort 변환 메소드
	public String convertSort(String sort) {
		String sortResult = "";
		
		if (sort.equals("time")) {	// 최신순
			sortResult = "writing_time";
		}
		else if(sort.equals("appl")) {	// 신청순
			sortResult = "applicant_cnt";
		}
		else if(sort.equals("hits")) {	// 조회순
			sortResult = "hits";
		}
		else if(sort.equals("yes")) {
			sortResult = "승인";
		}
		else if(sort.equals("no")) {
			sortResult = "거절";
		}
		else if(sort.equals("yet")) {
			sortResult = "대기";
		}
		
		return sortResult;
	}
	
	// category 변환 메소드
	public String convertCategory(String category) {
		String categoryResult = "";
		
		if (category.equals("exercise")) {
			categoryResult = "운동";
		}
		else if (category.equals("hobby")) {
			categoryResult = "취미";
		}
		else if (category.equals("study")) {
			categoryResult = "공부";
		}
		else {
			categoryResult = "기타";
		}
		
		return categoryResult;
	}
	
	// 모임모집 게시글 목록 메소드
	public List<MeetingDTO> getMeetingList(String category, String sort, int page) {
		// 게시글 목록 생성
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		
		// 글목록 정렬
		page_dto.setSort_type(convertSort(sort));
		
		// 페이징 작업
		int div_num = 10;	// 한 페이지당 글 개수
		page_dto.calcNum(page, div_num);
		
		// 글 목록 생성
		List<MeetingDTO> meeting_list;	// 글 목록
		
		if (category.equals("all")) {
			meeting_list = service.meetingListAll(page_dto);
		}
		else {
			page_dto.setCategory(convertCategory(category));
			meeting_list = service.meetingListCategory(page_dto);
		}
		
		return meeting_list;
	}
	
	// 모임모집 게시글 개수 메소드
	public int getMeetingCount(String category) {
		int total_cnt = 0;	// 전체 글 개수
		
		if (category.equals("all")) {
			total_cnt = service.meetingCountAll();
		}
		else {
			total_cnt = service.meetingCountCategory(convertCategory(category));
		}
		
		return total_cnt;
	}
	
	// 유저 모임모집 게시글 목록 메소드
	public List<MeetingDTO> getMeetingList(String category, String sort, int page, String user_id) {
		// 게시글 목록 생성
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		page_dto.setUser_id(user_id);
		
		// 글목록 정렬
		page_dto.setSort_type(convertSort(sort));
		
		// 페이징 작업
		int div_num = 10;	// 한 페이지당 글 개수
		page_dto.calcNum(page, div_num);
		
		// 글 목록 생성
		List<MeetingDTO> meeting_list;	// 글 목록
		
		if (category.equals("all")) {
			meeting_list = service.meetingListAllUser(page_dto);
		}
		else {
			page_dto.setCategory(convertCategory(category));
			meeting_list = service.meetingListCategoryUser(page_dto);
		}
		
		return meeting_list;
	}
	
	// 유저 모임모집 게시글 개수 메소드
	public int getMeetingCount(String category, String user_id) {
		int total_cnt = 0;	// 전체 글 개수

		if (category.equals("all")) {
			total_cnt = service.meetingCountAllUser(user_id);
		}
		else {
			MeetingPagingDTO page_dto = new MeetingPagingDTO();
			page_dto.setUser_id(user_id);
			page_dto.setCategory(convertCategory(category));
			
			total_cnt = service.meetingCountCategoryUser(page_dto);
		}
		
		return total_cnt;
	}
	
	// 유저 모임모집 신청 댓글 목록 메소드
	public List<MeetingDTO> getMeetingList(String category, String sort, int page, ArrayList<Integer> seq_list) {
		// 게시글 목록 생성
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		page_dto.setSeq_list(seq_list);
		
		// 글목록 정렬
		page_dto.setSort_type(convertSort(sort));
		
		// 페이징 작업
		int div_num = 10;	// 한 페이지당 글 개수
		page_dto.calcNum(page, div_num);
		
		// 글 목록 생성
		List<MeetingDTO> meeting_list;	// 글 목록
		
		if (category.equals("all")) {
			meeting_list = service.userAppMeetingListAll(page_dto);
		}
		else {
			page_dto.setCategory(convertCategory(category));
			meeting_list = service.userAppMeetingListCategory(page_dto);
		}
		
		return meeting_list;
	}
	
	// 유저 모임모집 신청 댓글 개수 메소드
	public int getMeetingCount(String category, ArrayList<Integer> seq_list) {
		int total_cnt = 0;	// 전체 글 개수

		if (category.equals("all")) {
			total_cnt = seq_list.size();
		}
		else {
			MeetingPagingDTO page_dto = new MeetingPagingDTO();
			page_dto.setCategory(convertCategory(category));
			page_dto.setSeq_list(seq_list);
			
			total_cnt = service.userAppMeetingCountCategory(page_dto);
		}
		
		return total_cnt;
	}
	
	// 신청 댓글 목록 메소드
	public List<ApplicantDTO> getApplicantList(int seq, int page) {
		// 신청 댓글 목록 페이징 작업
		int div_num = 10;	// 한 페이지당 댓글 개수
		
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		page_dto.setSeq(seq);
		page_dto.calcNum(page, div_num);
		
		return service.applicantList(page_dto);
	}
	
	// 유저 신청 댓글 메소드
	public ApplicantDTO getApplicantList(int seq, String user_id) {
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		page_dto.setSeq(seq);
		page_dto.setUser_id(user_id);
		
		return service.applicantOneUser(page_dto);
	}
	
	// 모집글 신청자수 업데이트
	public void setApplicantCnt(int seq, int num) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("seq", seq);
		hash.put("num", num);
		
		service.updateMeetingAppNum(hash);
	}
		
}
