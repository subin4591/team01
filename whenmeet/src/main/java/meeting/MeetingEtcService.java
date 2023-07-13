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
	
	int div_num = 10;
	
	// banner 메소드
	public HashMap<String, MeetingDTO> makeBanner() {
		// banner MeetingPagingDTO 생성
		MeetingPagingDTO bannerPage = new MeetingPagingDTO();
		bannerPage.setSort_type("applicant_cnt");
		bannerPage.setStart(0);
		bannerPage.setEnd(1);
		
		// List 생성
		HashMap<String, MeetingDTO> bannerMap = new HashMap<>();
		List<MeetingDTO> meeting_list;
		
		// DB 게시글 없을 때 대비
		MeetingDTO meeting_dto;
		MeetingDTO meeting_none = new MeetingDTO();
		meeting_none.setTitle("none");
		meeting_none.setContents("none");
		
		// all banner
		bannerPage.setCategory("전체");
		meeting_list = service.meetingList(bannerPage);
		if (meeting_list.size() == 0) {
			meeting_dto = meeting_none;
		}
		else {
			meeting_dto = meeting_list.get(0);
		}
		bannerMap.put("all", meeting_dto);
		
		// exercise banner
		bannerPage.setCategory("운동");
		meeting_list = service.meetingList(bannerPage);
		if (meeting_list.size() == 0) {
			meeting_dto = meeting_none;
		}
		else {
			meeting_dto = meeting_list.get(0);
		}
		bannerMap.put("exercise", meeting_dto);
		
		// hobby banner
		bannerPage.setCategory("취미");
		meeting_list = service.meetingList(bannerPage);
		if (meeting_list.size() == 0) {
			meeting_dto = meeting_none;
		}
		else {
			meeting_dto = meeting_list.get(0);
		}
		bannerMap.put("hobby", meeting_dto);
		
		// study banner
		bannerPage.setCategory("공부");
		meeting_list = service.meetingList(bannerPage);
		if (meeting_list.size() == 0) {
			meeting_dto = meeting_none;
		}
		else {
			meeting_dto = meeting_list.get(0);
		}
		bannerMap.put("study", meeting_dto);

		// etc banner
		bannerPage.setCategory("기타");
		meeting_list = service.meetingList(bannerPage);
		if (meeting_list.size() == 0) {
			meeting_dto = meeting_none;
		}
		else {
			meeting_dto = meeting_list.get(0);
		}
		bannerMap.put("etc", meeting_dto);
		
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
		else if(sort.equals("yes") || sort.equals("ready")) {
			sortResult = "승인";
		}
		else if(sort.equals("no")) {
			sortResult = "거절";
		}
		else if(sort.equals("yet")) {
			sortResult = "대기";
		}
		else if(sort.equals("open")) {
			sortResult = "공개";
		}
		else if(sort.equals("hidden")) {
			sortResult = "비공개";
		}
		
		return sortResult;
	}
	
	// category 변환 메소드
	public String convertCategory(String category) {
		String categoryResult = "";
		
		if (category.equals("all")) {
			categoryResult = "전체";
		}
		else if (category.equals("exercise")) {
			categoryResult = "운동";
		}
		else if (category.equals("hobby")) {
			categoryResult = "취미";
		}
		else if (category.equals("study")) {
			categoryResult = "공부";
		}
		else if (category.equals("etc")) {
			categoryResult = "기타";
		}
		else if (category.equals("notfinish")) {
			categoryResult = "진행";
		}
		else if (category.equals("yetfinish")) {
			categoryResult = "대기";
		}
		else if (category.equals("finish")) {
			categoryResult = "완료";
		}
		
		return categoryResult;
	}
	
	// 모임모집 게시글 목록 메소드
	public List<MeetingDTO> getMeetingList(String category, String sort, int page) {
		// 게시글 목록 생성
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		
		// 글목록 정렬
		page_dto.setSort_type(convertSort(sort));
		page_dto.setCategory(convertCategory(category));
		
		// 페이징 작업
		page_dto.calcNum(page, div_num);
		
		return service.meetingList(page_dto);
	}
	
	// 유저 모임모집 게시글 목록 메소드
	public List<MeetingDTO> getMeetingList(String category, String sort, int page, String user_id) {
		// 게시글 목록 생성
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		page_dto.setUser_id(user_id);
		
		// 페이징 작업
		page_dto.calcNum(page, div_num);
		
		// 글목록 정렬
		if (category.equals("notfinish") || category.equals("yetfinish") || category.equals("finish")) {
			page_dto.setCategory("result");
			
			ArrayList<String> sort_list = new ArrayList<>();
			sort_list.add(convertCategory(category));
			sort_list.add(convertSort(sort));

			page_dto.setSort_list(sort_list);
			page_dto.setSort_type(convertSort("time"));
		}
		else {
			page_dto.setCategory(convertCategory(category));
			page_dto.setSort_type(convertSort(sort));
		}
		
		return service.meetingListUser(page_dto);
	}
	
	// 유저 모임모집 게시글 개수 메소드
	public int getMeetingCount(String category, String sort, String user_id) {
		// 게시글 목록 생성
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		page_dto.setUser_id(user_id);
		
		// 글목록 정렬
		if (category.equals("notfinish") || category.equals("yetfinish") || category.equals("finish")) {
			page_dto.setCategory("result");
			
			ArrayList<String> sort_list = new ArrayList<>();
			sort_list.add(convertCategory(category));
			sort_list.add(convertSort(sort));

			page_dto.setSort_list(sort_list);
		}
		else {
			page_dto.setCategory(convertCategory(category));
		}
		
		return service.meetingCountUser(page_dto);
	}
	
	// 유저 모임모집 신청 댓글 목록 메소드
	public List<MeetingDTO> getMeetingList(String category, String sort, int page, ArrayList<Integer> seq_list) {
		// 게시글 목록 생성
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		page_dto.setSeq_list(seq_list);
		
		// 글목록 정렬
		page_dto.setSort_type(convertSort(sort));
		page_dto.setCategory(convertCategory(category));
		
		// 페이징 작업
		page_dto.calcNum(page, div_num);
		
		// DB 0개 대비
		List<MeetingDTO> meeting_list = null;
		if (seq_list.size() != 0) {
			meeting_list = service.userAppMeetingList(page_dto);
		}
		
		return meeting_list;
	}
	
	// 유저 모임모집 신청 댓글 개수 메소드
	public int getMeetingCount(String category, ArrayList<Integer> seq_list) {
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		page_dto.setCategory(convertCategory(category));
		page_dto.setSeq_list(seq_list);
		
		// DB 0개 대비
		int cnt = 0;
		if (seq_list.size() != 0) {
			cnt = service.userAppMeetingCount(page_dto);
		}
		
		return cnt;
	}
	
	// 신청 댓글 목록 메소드
	public List<ApplicantDTO> getApplicantList(int seq, int page) {
		// 신청 댓글 목록 페이징 작업
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		page_dto.setSeq(seq);
		page_dto.calcNum(page, div_num);
		
		return service.applicantList(page_dto);
	}
	
	// wirter mode 신청 댓글 목록 메소드
	public List<ApplicantDTO> getApplicantList(int seq, int page, String sort) {
		// 신청 댓글 목록 페이징 작업
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		page_dto.setSeq(seq);
		page_dto.calcNum(page, div_num);
		
		if (sort.equals("yet")) {
			page_dto.setSort_type("대기");
		}
		else {
			page_dto.setSort_type("승인");
		}
		
		return service.writerModeList(page_dto);
	}
	
	// writer mode 신청 댓글 개수 메소드
	public int getApplicantCount(int seq, String sort) {
		MeetingPagingDTO page_dto = new MeetingPagingDTO();
		page_dto.setSeq(seq);
		
		if (sort.equals("yet")) {
			page_dto.setSort_type("대기");
		}
		else {
			page_dto.setSort_type("승인");
		}
		
		return service.writerModeCount(page_dto);
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
