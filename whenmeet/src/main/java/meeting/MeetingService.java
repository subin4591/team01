package meeting;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.ApplicantDTO;
import dto.MeetingDTO;
import dto.MeetingPagingDTO;
import dto.UserDTO;

@Service("meetingservice")
public class MeetingService {
	@Autowired
	MeetingDAO dao;
	
	/// Meeting select
	// 기본 게시글 목록
	public List<MeetingDTO> meetingListAll(MeetingPagingDTO dto) {
		return dao.meetingListAll(dto);
	}
	public int meetingCountAll() {
		return dao.meetingCountAll();
	}
	public List<MeetingDTO> meetingListCategory(MeetingPagingDTO dto) {
		return dao.meetingListCategory(dto);
	}
	public int meetingCountCategory(String category) {
		return dao.meetingCountCategory(category);
	}
	
	// 유저 게시글 목록
	public List<MeetingDTO> meetingListAllUser(MeetingPagingDTO dto) {
		return dao.meetingListAllUser(dto);
	}
	public int meetingCountAllUser(String user_id) {
		return dao.meetingCountAllUser(user_id);
	}
	public List<MeetingDTO> meetingListCategoryUser(MeetingPagingDTO dto) {
		return dao.meetingListCategoryUser(dto);
	}
	public int meetingCountCategoryUser(MeetingPagingDTO dto) {
		return dao.meetingCountCategoryUser(dto);
	}
	
	// 유저 신청 게시글 목록
	public List<Integer> userAppSeqList(String user_id) {
		return dao.userAppSeqList(user_id);
	}
	public List<MeetingDTO> userAppMeetingListAll(MeetingPagingDTO dto) {
		return dao.userAppMeetingListAll(dto);
	}
	public List<MeetingDTO> userAppMeetingListCategory(MeetingPagingDTO dto) {
		return dao.userAppMeetingListCategory(dto);
	}
	public int userAppMeetingCountCategory(MeetingPagingDTO dto) {
		return dao.userAppMeetingCountCategory(dto);
	}
	
	// 유저 신청 게시글 결과
	public List<Integer> userAppSeqListResult(MeetingPagingDTO dto) {
		return dao.userAppSeqListResult(dto);
	}
	
	// 게시글 상세
	public MeetingDTO meetingDetailed(int seq) {
		return dao.meetingDetailed(seq);
	}
	
	// 유저 정보
	public UserDTO userInfo(String user_id) {
		return dao.userInfo(user_id);
	}
	
	// 신청 댓글 정보
	public List<ApplicantDTO> applicantList(MeetingPagingDTO dto) {
		return dao.applicantList(dto);
	}
	public int applicantCount(int seq) {
		return dao.applicantCount(seq);
	}
	public ApplicantDTO applicantOneUser(MeetingPagingDTO dto) {
		return dao.applicantOneUser(dto);
	}
	
	// 신청 댓글 중복 확인
	public int applicantUserCount(MeetingPagingDTO dto) {
		return dao.applicantUserCount(dto);
	}
	
	
	/// Meeting insert
	// 게시글 작성
	public void insertMeetingTable(MeetingDTO dto) {
		dao.insertMeetingTable(dto);
	}
	
	// 신청 댓글 작성
	public void insertApplicantTable(ApplicantDTO dto) {
		dao.insertApplicantTable(dto);
	}
	
	
	/// Meeting update
	// 조회수 증가
	public void updateMeetingHits(int seq) {
		dao.updateMeetingHits(seq);
	}
	
	// 신청자수 증가 혹은 감소
	public void updateMeetingAppNum(HashMap<String, Integer> hash) {
		dao.updateMeetingAppNum(hash);
	}
	
	// 게시글 수정
	public void updateMeetingContents(MeetingDTO dto) {
		dao.updateMeetingContents(dto);
	}
	
	// 댓글 수정
	public void updateAppContents(ApplicantDTO dto) {
		dao.updateAppContents(dto);
	}
	
	
	/// Meeting delete
	// 게시글 삭제
	public void deleteMeeting(int seq) {
		dao.deleteMeeting(seq);
	}
	public void deleteAppAll(int seq) {
		dao.deleteAppAll(seq);
	}
	
	// 본인 댓글 삭제
	public void deleteAppOne(MeetingPagingDTO dto) {
		dao.deleteAppOne(dto);
	}
}
