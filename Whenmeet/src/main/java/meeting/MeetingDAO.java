package meeting;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.ApplicantDTO;
import dto.MeetingDTO;
import dto.MeetingPagingDTO;
import dto.UserDTO;
import dto.WriterModeDTO;

@Mapper
@Repository
public interface MeetingDAO {
	/// Meeting select
	// 기본 게시글 목록
	public List<MeetingDTO> meetingList(MeetingPagingDTO dto);
	public int meetingCount(String category);
	
	// 유저 게시글 목록
	public List<MeetingDTO> meetingListUser(MeetingPagingDTO dto);
	public int meetingCountUser(MeetingPagingDTO dto);
	
	// 유저 신청 게시글 목록
	public List<Integer> userAppSeqList(String user_id);
	public List<MeetingDTO> userAppMeetingList(MeetingPagingDTO dto);
	public int userAppMeetingCount(MeetingPagingDTO dto);
	
	// 유저 신청 게시글 결과
	public List<Integer> userAppSeqListResult(MeetingPagingDTO dto);
	
	// 게시글 상세
	public MeetingDTO meetingDetailed(int seq);
	
	// 유저 정보
	public UserDTO userInfo(String user_id);
	
	// 신청 댓글 정보
	public List<ApplicantDTO> applicantList(MeetingPagingDTO dto);
	public int applicantCount(int seq);
	public ApplicantDTO applicantOneUser(MeetingPagingDTO dto);
	
	// 신청 댓글 중복 확인
	public int applicantUserCount(MeetingPagingDTO dto);
	
	// writer mode 신청 댓글 정보
	public List<ApplicantDTO> writerModeList(MeetingPagingDTO dto);
	public int writerModeCount(MeetingPagingDTO dto);
	
	
	/// Meeting insert
	// 게시글 작성
	public void insertMeetingTable(MeetingDTO dto);
	
	// 신청 댓글 작성
	public void insertApplicantTable(ApplicantDTO dto);
	
	
	/// Meeting update
	// 조회수 증가
	public void updateMeetingHits(int seq);
	
	// 신청자수 증가 혹은 감소
	public void updateMeetingAppNum(HashMap<String, Integer> hash);
	
	// 게시글 수정
	public void updateMeetingContents(MeetingDTO dto);
	
	// 댓글 수정
	public void updateAppContents(ApplicantDTO dto);
	
	// 모집 신청 승인/거절
	public void updateApproval(WriterModeDTO dto);
	
	// 모집글 상태 변경
	public void updateEnd(HashMap<String, Object> map);
	
	
	/// Meeting delete
	// 게시글 삭제
	public void deleteMeeting(int seq);
	public void deleteAppAll(int seq);
	
	// 본인 댓글 삭제
	public void deleteAppOne(MeetingPagingDTO dto);
	
	
	/// Meeting test
	public List<Integer> testSelect1();
	public List<String> testSelect2();
	public void testUpdate(HashMap<String, Object> map);
}
