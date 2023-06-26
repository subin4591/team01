package meeting;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.MeetingDTO;
import dto.MeetingPagingDTO;
import dto.UserDTO;

@Service("meetingservice")
public class MeetingService {
	@Autowired
	MeetingDAO dao;
	
	public List<MeetingDTO> meetingListAll(MeetingPagingDTO dto) {
		return dao.meetingListAll(dto);
	}
	public int meetingCountAll() {
		return dao.meetingCountAll();
	}
	public void insertMeetingTable(MeetingDTO dto) {
		dao.insertMeetingTable(dto);
	}
	public MeetingDTO meetingDetailed(int seq) {
		return dao.meetingDetailed(seq);
	}
	public UserDTO userInfo(String user_id) {
		return dao.userInfo(user_id);
	}
	public void updateMeetingHits(int seq) {
		dao.updateMeetingHits(seq);
	}
	public void updateMeetingContents(MeetingDTO dto) {
		dao.updateMeetingContents(dto);
	}
}
