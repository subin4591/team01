package meeting;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.ApplicantDTO;
import dto.MeetingDTO;
import dto.MeetingPagingDTO;
import dto.UserDTO;
import dto.WriterModeDTO;

@Service("meetingservice")
public class MeetingService {
	@Autowired
	MeetingDAO dao;
	
	/// Meeting select
	// 기본 게시글 목록
	public List<MeetingDTO> meetingList(MeetingPagingDTO dto) {
		return dao.meetingList(dto);
	}
	public int meetingCount(String category) {
		return dao.meetingCount(category);
	}
	
	// 유저 게시글 목록
	public List<MeetingDTO> meetingListUser(MeetingPagingDTO dto) {
		return dao.meetingListUser(dto);
	}
	public int meetingCountUser(MeetingPagingDTO dto) {
		return dao.meetingCountUser(dto);
	}
	
	// 유저 신청 게시글 목록
	public List<Integer> userAppSeqList(String user_id) {
		return dao.userAppSeqList(user_id);
	}
	public List<MeetingDTO> userAppMeetingList(MeetingPagingDTO dto) {
		return dao.userAppMeetingList(dto);
	}
	public int userAppMeetingCount(MeetingPagingDTO dto) {
		return dao.userAppMeetingCount(dto);
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
	
	// writer mode 신청 댓글 정보
	public List<ApplicantDTO> writerModeList(MeetingPagingDTO dto) {
		return dao.writerModeList(dto);
	}
	public int writerModeCount(MeetingPagingDTO dto) {
		return dao.writerModeCount(dto);
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
	
	// 모집 신청 승인/거절
	public void updateApproval(WriterModeDTO dto) {
		dao.updateApproval(dto);
	}
	
	// 모집글 상태 변경
	public void updateEnd(HashMap<String, Object> map) {
		dao.updateEnd(map);
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
