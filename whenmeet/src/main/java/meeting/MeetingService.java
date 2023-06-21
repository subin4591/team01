package meeting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("meetingservice")
public class MeetingService {
	@Autowired
	MeetingDAO dao;
	
	public String getApp() {
		return dao.getApp();
	}
}
