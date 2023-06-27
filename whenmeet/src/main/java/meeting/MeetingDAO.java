package meeting;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.MeetingDTO;
import dto.MeetingPagingDTO;
import dto.UserDTO;

@Mapper
@Repository
public interface MeetingDAO {
	// Test
	public String getApp();
	
	// Meating
	public List<MeetingDTO> meetingListAll(MeetingPagingDTO dto);
	public int meetingCountAll();
	public List<MeetingDTO> meetingListCategory(MeetingPagingDTO dto);
	public int meetingCountCategory(String category);
	public List<MeetingDTO> meetingListAllUser(MeetingPagingDTO dto);
	public int meetingCountAllUser(String user_id);
	public List<MeetingDTO> meetingListCategoryUser(MeetingPagingDTO dto);
	public int meetingCountCategoryUser(MeetingPagingDTO dto);
	public void insertMeetingTable(MeetingDTO dto);
	public MeetingDTO meetingDetailed(int seq);
	public UserDTO userInfo(String user_id);
	public void updateMeetingHits(int seq);
	public void updateMeetingContents(MeetingDTO dto);
}
