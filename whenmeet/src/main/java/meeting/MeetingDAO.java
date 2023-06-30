package meeting;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.ApplicantDTO;
import dto.MeetingDTO;
import dto.MeetingPagingDTO;
import dto.UserDTO;

@Mapper
@Repository
public interface MeetingDAO {
	/// Meeting select
	// 기본 게시글 목록
	public List<MeetingDTO> meetingListAll(MeetingPagingDTO dto);
	public int meetingCountAll();
	public List<MeetingDTO> meetingListCategory(MeetingPagingDTO dto);
	public int meetingCountCategory(String category);
	
	// 유저 게시글 목록
	public List<MeetingDTO> meetingListAllUser(MeetingPagingDTO dto);
	public int meetingCountAllUser(String user_id);
	public List<MeetingDTO> meetingListCategoryUser(MeetingPagingDTO dto);
	public int meetingCountCategoryUser(MeetingPagingDTO dto);
	
	// 유저 신청 게시글 목록
	public List<Integer> userAppSeqList(String user_id);
	public List<MeetingDTO> userAppMeetingListAll(MeetingPagingDTO dto);
	public List<MeetingDTO> userAppMeetingListCategory(MeetingPagingDTO dto);
	public int userAppMeetingCountCategory(MeetingPagingDTO dto);
	
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
	
	
	/// Meeting delete
	// 게시글 삭제
	public void deleteMeeting(int seq);
	public void deleteAppAll(int seq);
	
	// 본인 댓글 삭제
	public void deleteAppOne(MeetingPagingDTO dto);
}
