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
	public List<MeetingDTO> meetingListCategory(MeetingPagingDTO dto) {
		return dao.meetingListCategory(dto);
	}
	public int meetingCountCategory(String category) {
		return dao.meetingCountCategory(category);
	}
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
