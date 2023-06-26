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
	public void insertMeetingTable(MeetingDTO dto);
	public MeetingDTO meetingDetailed(int seq);
	public UserDTO userInfo(String user_id);
	public void updateMeetingHits(int seq);
	public void updateMeetingContents(MeetingDTO dto);
}
