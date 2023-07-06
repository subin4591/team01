package schedule;

import java.util.List;
import dto.UserDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface scheduleMapper {
	List<UserDTO> selectUser() throws Exception;
	String location();
}
