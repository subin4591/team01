package schedule;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.UserDTO;

@Service("scheduleService")
public class scheduleService {
	
	@Autowired
	private scheduleMapper scheduleMapper;

	public List<UserDTO> selectUser() throws Exception {
		return scheduleMapper.selectUser();
	}
}
